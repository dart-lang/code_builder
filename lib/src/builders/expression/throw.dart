// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _ThrowExpression extends AbstractExpressionMixin with TopLevelMixin {
  final ExpressionBuilder _value;

  _ThrowExpression(this._value);

  @override
  ExpressionBuilder asThrow() => this;

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.throwExpression($throw, _value.buildExpression(scope));
  }
}
