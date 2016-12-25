// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library code_builder.src.builders.expression;

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:analyzer/src/dart/ast/token.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/src/builders/method.dart';
import 'package:code_builder/src/builders/parameter.dart';
import 'package:code_builder/src/builders/reference.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/builders/statement/if.dart';
import 'package:code_builder/src/builders/statement/while.dart';
import 'package:code_builder/src/builders/type.dart';
import 'package:code_builder/src/tokens.dart';

part 'expression/assert.dart';
part 'expression/assign.dart';
part 'expression/await.dart';
part 'expression/cascade.dart';
part 'expression/invocation.dart';
part 'expression/negate.dart';
part 'expression/operators.dart';
part 'expression/return.dart';
part 'expression/yield.dart';

final _false =
    astFactory.booleanLiteral(new KeywordToken(Keyword.FALSE, 0), true);

final _null = astFactory.nullLiteral(new KeywordToken(Keyword.NULL, 0));

final _true =
    astFactory.booleanLiteral(new KeywordToken(Keyword.TRUE, 0), true);

/// Returns a pre-defined literal expression of [value].
///
/// Only primitive values are allowed.
ExpressionBuilder literal(value) {
  if (value is List) {
    return list(value);
  }
  if (value is Map) {
    return map(value);
  }
  return new _LiteralExpression(_literal(value));
}

/// Returns a literal `List` expression from [values].
///
/// Optionally specify [asConst] or with a generic [type].
ExpressionBuilder list(
  Iterable values, {
  bool asConst: false,
  TypeBuilder type,
}) =>
    new _TypedListExpression(values, asConst: asConst, type: type);

/// Returns a literal `Map` expression from [values].
///
/// Optionally specify [asConst] or with a generic [keyType] or [valueType].
ExpressionBuilder map(
  Map values, {
  bool asConst: false,
  TypeBuilder keyType,
  TypeBuilder valueType,
}) =>
    new _TypedMapExpression(values,
        asConst: asConst, keyType: keyType, valueType: valueType);

Literal _literal(value) {
  if (value == null) {
    return _null;
  } else if (value is bool) {
    return value ? _true : _false;
  } else if (value is String) {
    return astFactory.simpleStringLiteral(stringToken("'$value'"), value);
  } else if (value is int) {
    return astFactory.integerLiteral(stringToken('$value'), value);
  } else if (value is double) {
    return astFactory.doubleLiteral(stringToken('$value'), value);
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
  ExpressionBuilder operator >(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $gt,
    );
  }

  @override
  ExpressionBuilder operator <(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $lt,
    );
  }

  @override
  ExpressionBuilder and(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $and,
    );
  }

  @override
  StatementBuilder asAssert() => new _AsAssert(this);

  @override
  StatementBuilder asAssign(
    String variable, {
    ExpressionBuilder target,
    bool nullAware: false,
  }) =>
      new _AsAssign(this, variable, nullAware, target);

  @override
  ExpressionBuilder asAwait() => new _AsAwait(this);

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
  StatementBuilder asYield() => new _AsYield(this, false);

  @override
  StatementBuilder asYieldStar() => new _AsYield(this, true);

  @override
  WhileStatementBuilder asWhile({bool asDo: false}) {
    return new WhileStatementBuilder(asDo, this);
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
  ExpressionBuilder cascade(
    Iterable<ExpressionBuilder> create(ExpressionBuilder self),
  ) {
    // Sorry for the huge hack. Need to think more clearly about this in future.
    return new _CascadeExpression(this, create(reference('.')));
  }

  @override
  ExpressionBuilder decrement() => new _DecrementExpression(this);

  @override
  ExpressionBuilder equals(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $equalsEquals,
    );
  }

  @override
  ExpressionBuilder increment([bool prefix = false]) {
    return new _IncrementExpression(this, prefix);
  }

  @override
  ExpressionBuilder identical(ExpressionBuilder other) {
    return lib$core.identical.call(<ExpressionBuilder> [
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
  ExpressionBuilder or(ExpressionBuilder other) {
    return new _AsBinaryExpression(
      this,
      other,
      $or,
    );
  }

  @override
  ExpressionBuilder parentheses() => new _ParenthesesExpression(this);

  @override
  ExpressionBuilder property(String name) => new _MemberExpression(this, name);
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

  /// Returns as an [ExpressionBuilder] `<` by [other].
  ExpressionBuilder operator <(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] `>` by [other].
  ExpressionBuilder operator >(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] `&&` [other].
  ExpressionBuilder and(ExpressionBuilder other);

  /// Return as a [StatementBuilder] that `assert`s this expression.
  StatementBuilder asAssert();

  /// Returns as a [StatementBuilder] that assigns to an existing [variable].
  ///
  /// If [target] is specified, determined to be `{target}.{variable}`.
  StatementBuilder asAssign(
    String variable, {
    ExpressionBuilder target,
    bool nullAware,
  });

  /// Returns as an expression `await`-ing this one.
  ExpressionBuilder asAwait() => new _AsAwait(this);

  /// Returns as a [StatementBuilder] that assigns to a new `const` [variable].
  StatementBuilder asConst(String variable, [TypeBuilder type]);

  /// Returns as a [StatementBuilder] that assigns to a new `final` [variable].
  StatementBuilder asFinal(String variable, [TypeBuilder type]);

  /// Returns as a [StatementBuilder] that builds an `if` statement.
  IfStatementBuilder asIf();

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

  /// Returns as a [StatementBuilder] yielding this one.
  StatementBuilder asYield();

  /// Returns as a [StatementBuilder] yielding this one.
  StatementBuilder asYieldStar();

  /// Returns as a [WhileStatementBuilder] with this as the condition.
  WhileStatementBuilder asWhile({bool asDo: false});

  /// Returns an [Expression] AST representing the builder.
  Expression buildExpression([Scope scope]);

  /// Returns as an [InvocationBuilder] with arguments added.
  InvocationBuilder call(
    Iterable<ExpressionBuilder> positionalArguments, [
    Map<String, ExpressionBuilder> namedArguments,
  ]);

  /// Return as an [ExpressionBuilder] with `..` appended.
  ExpressionBuilder cascade(
    Iterable<ExpressionBuilder> create(ExpressionBuilder self),
  );

  /// Returns as an [ExpressionBuilder] decrementing this expression.
  ExpressionBuilder decrement();

  /// Returns as an [ExpressionBuilder] comparing using `==` against [other].
  ExpressionBuilder equals(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] comparing using `identical`.
  ExpressionBuilder identical(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] incrementing this expression.
  ExpressionBuilder increment([bool prefix = false]);

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

  /// Returns as an [ExpressionBuilder] `||` [other].
  ExpressionBuilder or(ExpressionBuilder other);

  /// Returns as an [ExpressionBuilder] wrapped in parentheses.
  ExpressionBuilder parentheses();

  /// Returns {{this}}.{{name}}.
  ExpressionBuilder property(String name);
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

class _AsStatement extends TopLevelMixin implements StatementBuilder {
  final ExpressionBuilder _expression;

  _AsStatement(this._expression);

  @override
  Statement buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return astFactory.expressionStatement(
      _expression.buildExpression(scope),
      $semicolon,
    );
  }
}

class _MemberExpression extends Object
    with AbstractExpressionMixin, TopLevelMixin {
  final String _name;
  final ExpressionBuilder _target;

  _MemberExpression(this._target, this._name);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.propertyAccess(
      _target.buildExpression(scope),
      $period,
      stringIdentifier(_name),
    );
  }
}

class _LiteralExpression extends Object
    with AbstractExpressionMixin, TopLevelMixin {
  final Literal _literal;

  _LiteralExpression(this._literal);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([_]) => _literal;
}

class _ParenthesesExpression extends Object
    with AbstractExpressionMixin, TopLevelMixin {
  final ExpressionBuilder _expression;

  _ParenthesesExpression(this._expression);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.parenthesizedExpression(
      $openParen,
      _expression.buildExpression(scope),
      $closeParen,
    );
  }
}

ExpressionBuilder _expressionify(v) {
  if (v == null || v is bool || v is String || v is int || v is double) {
    return new _LiteralExpression(_literal(v));
  }
  if (v is ExpressionBuilder) {
    return v;
  }
  throw new ArgumentError('Could not expressionify $v');
}

class _TypedListExpression extends Object
    with AbstractExpressionMixin, TopLevelMixin {
  static List<ExpressionBuilder> _toExpression(Iterable values) {
    return values.map(_expressionify).toList();
  }

  final bool _asConst;
  final TypeBuilder _type;
  final List<ExpressionBuilder> _values;

  _TypedListExpression(Iterable values, {bool asConst, TypeBuilder type})
      : _values = _toExpression(values),
        _asConst = asConst,
        _type = type;

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.listLiteral(
      _asConst ? $const : null,
      _type != null
          ? astFactory.typeArgumentList(
              $openBracket,
              [_type.buildType(scope)],
              $closeBracket,
            )
          : null,
      $openBracket,
      _values.map((v) => v.buildExpression(scope)).toList(),
      $closeBracket,
    );
  }
}

class _TypedMapExpression extends Object
    with AbstractExpressionMixin, TopLevelMixin {
  static Map<ExpressionBuilder, ExpressionBuilder> _toExpression(Map values) {
    return new Map<ExpressionBuilder, ExpressionBuilder>.fromIterable(
      values.keys,
      key: (k) => _expressionify(k),
      value: (k) => _expressionify(values[k]),
    );
  }

  final bool _asConst;
  final TypeBuilder _keyType;
  final TypeBuilder _valueType;
  final Map<ExpressionBuilder, ExpressionBuilder> _values;

  _TypedMapExpression(Map values,
      {bool asConst, TypeBuilder keyType, TypeBuilder valueType})
      : _values = _toExpression(values),
        _asConst = asConst,
        _keyType = keyType != null
            ? keyType
            : valueType != null ? lib$core.$dynamic : null,
        _valueType = valueType != null
            ? valueType
            : keyType != null ? lib$core.$dynamic : null;

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.mapLiteral(
      _asConst ? $const : null,
      _keyType != null
          ? astFactory.typeArgumentList(
              $openBracket,
              [
                _keyType.buildType(scope),
                _valueType.buildType(scope),
              ],
              $closeBracket,
            )
          : null,
      $openBracket,
      _values.keys.map((k) {
        return astFactory.mapLiteralEntry(
          k.buildExpression(scope),
          $colon,
          _values[k].buildExpression(scope),
        );
      }).toList(),
      $closeBracket,
    );
  }
}
