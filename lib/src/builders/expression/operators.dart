// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

class _BinaryExpression extends _ExpressionBase {
  final ExpressionBuilder _left;
  final ExpressionBuilder _right;
  final Token _operator;

  _OperatorExpression.equals(this._a, this._b) : _operator = $equals;

  _OperatorExpression.notEquals(this._a, this._b) : _operator = $notEquals;

  @override
  Expression toAst([Scope scope = const Scope.identity()]) {
    return new BinaryExpression(
      _left.toAst(scope),
      _operator,
      _right.toAst(scope),
    );
  }
}
