// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _AsBinaryExpression extends Object with AbstractExpressionMixin {
  final ExpressionBuilder _left;
  final ExpressionBuilder _right;
  final Token _operator;

  _AsBinaryExpression(this._left, this._right, this._operator);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return new BinaryExpression(
      _left.buildExpression(scope),
      _operator,
      _right.buildExpression(scope),
    );
  }
}
