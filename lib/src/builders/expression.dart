library code_builder.src.builders.expression;

// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/src/builders/method.dart';
import 'package:code_builder/src/builders/parameter.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/builders/statement/if.dart';
import 'package:code_builder/src/builders/type.dart';
import 'package:code_builder/src/tokens.dart';

part 'expression/assert.dart';
part 'expression/assign.dart';
part 'expression/invocation.dart';
part 'expression/negate.dart';
part 'expression/operators.dart';
part 'expression/return.dart';

final _false = new BooleanLiteral(new KeywordToken(Keyword.FALSE, 0), true);

final _null = new NullLiteral(new KeywordToken(Keyword.NULL, 0));

final _true = new BooleanLiteral(new KeywordToken(Keyword.TRUE, 0), true);

/// Returns a pre-defined literal expression of [value].
///
/// Only primitive values are allowed.
ExpressionBuilder literal(value) => new _LiteralExpression(_literal(value));

Literal _literal(value) {
  if (value == null) {
    return _null;
  } else if (value is bool) {
    return value ? _true : _false;
  } else if (value is String) {
    return new SimpleStringLiteral(stringToken("'$value'"), value);
  } else if (value is int) {
    return new IntegerLiteral(stringToken('$value'), value);
  } else if (value is double) {
    return new DoubleLiteral(stringToken('$value'), value);
  } else if (value is List) {
    return new ListLiteral(
      null,
      null,
      $openBracket,
      value.map/*<Literal>*/(_literal).toList(),
      $closeBracket,
    );
  } else if (value is Map) {
    return new MapLiteral(
      null,
      null,
      $openBracket,
      value.keys.map/*<MapLiteralEntry>*/((k) {
        return new MapLiteralEntry(_literal(k), $colon, _literal(value[k]));
      }).toList(),
      $closeBracket,
    );
  }
  throw new ArgumentError.value(value, 'Unsupported');
}

/// Implements much of [ExpressionBuilder].
abstract class AbstractExpressionMixin implements ExpressionBuilder {
  @override
  ExpressionBuilder operator *(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $multiply,
    );
  }

  @override
  ExpressionBuilder operator +(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $plus,
    );
  }

  @override
  ExpressionBuilder operator -(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $minus,
    );
  }

  @override
  ExpressionBuilder operator /(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $divide,
    );
  }

  @override
  StatementBuilder asAssert() => new _AsAssert(this);

  @override
  StatementBuilder asAssign(
    String variable, {
    bool nullAware: false,
  }) =>
      new _AsAssign(this, variable, nullAware);

  @override
  StatementBuilder asConst(String variable, [TypeBuilder type]) {
    return new _AsAssignNew(this, variable, type, $const);
  }

  @override
  StatementBuilder asFinal(String variable, [TypeBuilder type]) {
    return new _AsAssignNew(this, variable, type, $final);
  }

  @override
  IfStatementBuilder asIf() => new IfStatementBuilder(this);

  @override
  StatementBuilder asReturn() => new _AsReturn(this);

  @override
  StatementBuilder asStatement() => new _AsStatement(this);

  @override
  StatementBuilder asVar(String variable, [TypeBuilder type]) {
    return new _AsAssignNew(this, variable, type, $var);
  }

  @override
  Statement buildStatement([Scope scope]) {
    return asStatement().buildStatement(scope);
  }

  @override
  InvocationBuilder call(
    Iterable<ExpressionBuilder> positionalArguments, [
    Map<String, ExpressionBuilder> namedArguments = const {},
  ]) {
    final invocation = new InvocationBuilder._(this);
    positionalArguments.forEach(invocation.addPositionalArgument);
    namedArguments.forEach(invocation.addNamedArgument);
    return invocation;
  }

  @override
  ExpressionBuilder equals(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $equalsEquals,
    );
  }

  @override
  ExpressionBuilder identical(ExpressionBuilder other) {
    return lib$core.identical.call([
      this,
      other,
    ]);
  }

  @override
  InvocationBuilder invoke(
    String method,
    Iterable<ExpressionBuilder> positionalArguments, [
    Map<String, ExpressionBuilder> namedArguments = const {},
  ]) {
    final invocation = new InvocationBuilder._on(this, method);
    positionalArguments.forEach(invocation.addPositionalArgument);
    namedArguments.forEach(invocation.addNamedArgument);
    return invocation;
  }

  @override
  ExpressionBuilder negate() => new _NegateExpression(this);

  @override
  ExpressionBuilder negative() => new _NegativeExpression(this);

  @override
  ExpressionBuilder notEquals(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $notEquals,
    );
  }

  @override
  ExpressionBuilder parentheses() => new _ParenthesesExpression(this);
}

/// Builds an [Expression] AST when [buildExpression] is invoked.
abstract class ExpressionBuilder
    implements AstBuilder, StatementBuilder, ValidParameterMember {
  /// Returns as an [ExpressionBuilder] multiplying by [other].
  ExpressionBuilder operator *(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] adding [other].
  ExpressionBuilder operator +(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] subtracting [other].
  ExpressionBuilder operator -(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] dividing by [other].
  ExpressionBuilder operator /(ExpressionBuilder other);

  /// Return as a [StatementBuilder] that `assert`s this expression.
  StatementBuilder asAssert();

  /// Returns as a [StatementBuilder] that assigns to an existing [variable].
  StatementBuilder asAssign(String variable);

  /// Returns as a [StatementBuilder] that assigns to a new `const` [variable].
  StatementBuilder asConst(String variable, [TypeBuilder type]);

  /// Returns as a [StatementBuilder] that assigns to a new `final` [variable].
  StatementBuilder asFinal(String variable, [TypeBuilder type]);

  /// Returns as a [StatementBuilder] that builds an `if` statement.
  /*If*/ StatementBuilder asIf();

  /// Returns as a [StatementBuilder] that `return`s this expression.
  StatementBuilder asReturn();

  /// Returns _explicitly_ as a [StatementBuilder].
  ///
  /// **NOTE**: [ExpressionBuilder] is _already_ usable as a [StatementBuilder]
  /// directly; this API exists in order force [buildAst] to return a
  /// [Statement] AST instead of an expression.
  StatementBuilder asStatement();

  /// Returns as a [StatementBuilder] that assigns to a new `var` [variable].
  ///
  /// If [type] is supplied, the resulting statement is `{type} {variable} =`.
  StatementBuilder asVar(String variable, [TypeBuilder type]);

  /// Returns an [Expression] AST representing the builder.
  Expression buildExpression([Scope scope]);

  /// Returns as an [InvocationBuilder] with arguments added.
  InvocationBuilder call(
    Iterable<ExpressionBuilder> positionalArguments, [
    Map<String, ExpressionBuilder> namedArguments,
  ]);

  /// Returns as an [ExpressionBuilder] comparing using `==` against [other].
  ExpressionBuilder equals(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] comparing using `identical`.
  ExpressionBuilder identical(ExpressionBuilder other);

  /// Returns as an [InvocationBuilder] on [method] of this expression.
  InvocationBuilder invoke(
    String method,
    Iterable<ExpressionBuilder> positionalArguments, [
    Map<String, ExpressionBuilder> namedArguments,
  ]);

  /// Returns as an [ExpressionBuilder] negating using the `!` operator.
  ExpressionBuilder negate();

  /// Returns as an [ExpressionBuilder] negating the value,
  ExpressionBuilder negative();

  /// Returns as an [ExpressionBuilder] comparing using `!=` against [other].
  ExpressionBuilder notEquals(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] wrapped in parentheses.
  ExpressionBuilder parentheses();
}

/// An [AstBuilder] that can add [ExpressionBuilder].
abstract class HasExpressions implements AstBuilder {
  final List<ExpressionBuilder> _expressions = <ExpressionBuilder>[];

  /// Adds [expression] to the builder.
  void addExpression(ExpressionBuilder expression) {
    _expressions.add(expression);
  }

  /// Adds [expressions] to the builder.
  void addExpressions(Iterable<ExpressionBuilder> expressions) {
    _expressions.addAll(expressions);
  }
}

/// Implements [HasExpressions].
abstract class HasExpressionsMixin extends HasExpressions {
  /// Returns a [List] of all built [Expression]s.
  List<Expression> buildExpressions([Scope scope]) => _expressions
      .map/*<Expression>*/((e) => e.buildExpression(scope))
      .toList();

  /// Clones all expressions to [clone].
  void cloneExpressionsTo(HasExpressions clone) {
    clone.addExpressions(_expressions);
  }
}

class _AsStatement implements StatementBuilder {
  final ExpressionBuilder _expression;

  _AsStatement(this._expression);

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return new ExpressionStatement(
      _expression.buildExpression(scope),
      $semicolon,
    );
  }
}

class _LiteralExpression extends Object with AbstractExpressionMixin {
  final Literal _literal;

  _LiteralExpression(this._literal);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([_]) => _literal;
}

class _ParenthesesExpression extends Object with AbstractExpressionMixin {
  final ExpressionBuilder _expression;

  _ParenthesesExpression(this._expression);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return new ParenthesizedExpression(
      $openParen,
      _expression.buildExpression(scope),
      $closeParen,
    );
  }
}
