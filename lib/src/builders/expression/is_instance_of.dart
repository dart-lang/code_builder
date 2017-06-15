// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _IsInstanceOfExpression extends AbstractExpressionMixin
    with TopLevelMixin {
  final ExpressionBuilder _expression;
  final TypeBuilder _type;

  _IsInstanceOfExpression(this._expression, this._type);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.isExpression(
        _expression.buildExpression(scope), $is, null, _type.buildType(scope));
  }
}
