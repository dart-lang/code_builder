// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _CascadeExpression extends TopLevelMixin with AbstractExpressionMixin {
  final List<ExpressionBuilder> _cascades;
  final ExpressionBuilder _target;

  _CascadeExpression(this._target, this._cascades);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.cascadeExpression(
      _target.buildExpression(scope),
      _cascades.map((e) => e.buildExpression(scope)).toList(),
    );
  }
}
