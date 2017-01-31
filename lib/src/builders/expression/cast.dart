// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _AsCast extends TopLevelMixin with AbstractExpressionMixin {
  final ExpressionBuilder _target;
  final TypeBuilder _type;

  _AsCast(this._target, this._type);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.asExpression(
      _target.buildExpression(scope),
      $as,
      _type.buildType(scope),
    );
  }
}
