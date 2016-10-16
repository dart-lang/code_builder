// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';
import 'package:code_builder/src/builders/parameter.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/tokens.dart';

/// Lazily builds an [Expression] AST when [buildExpression] is invoked.
abstract class ExpressionBuilder implements AstBuilder, ValidParameterMember {
  /// Returns an [Expression] AST representing the builder.
  Expression buildExpression([Scope scope]);
}

/// Implements much of [ExpressionBuilder].
abstract class AbstractExpression implements ExpressionBuilder {}

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
  /// Clones all expressions to [clone].
  void cloneExpressionsTo(HasExpressions clone) {
    clone.addExpressions(_expressions);
  }

  /// Returns a [List] of all built [Expression]s.
  List<Expression> buildExpressions([Scope scope]) => _expressions
      .map/*<Expression>*/((e) => e.buildExpression(scope))
      .toList();
}

final _null = new NullLiteral(new KeywordToken(Keyword.NULL, 0));
final _true = new BooleanLiteral(new KeywordToken(Keyword.TRUE, 0), true);
final _false = new BooleanLiteral(new KeywordToken(Keyword.FALSE, 0), true);

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

class _LiteralExpression extends Object with AbstractExpression {
  final Literal _literal;

  _LiteralExpression(this._literal);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([_]) => _literal;
}
