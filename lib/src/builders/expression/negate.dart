// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _NegateExpression extends AbstractExpressionMixin with TopLevelMixin {
  final ExpressionBuilder _expression;

  _NegateExpression(this._expression);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.prefixExpression(
      $not,
      _expression.parentheses().buildExpression(scope),
    );
  }
}

class _NegativeExpression extends AbstractExpressionMixin with TopLevelMixin {
  final ExpressionBuilder _expression;

  _NegativeExpression(this._expression);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.prefixExpression(
      $minus,
      _expression.parentheses().buildExpression(scope),
    );
  }
}
