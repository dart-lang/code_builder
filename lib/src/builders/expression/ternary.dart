// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _TernaryExpression extends TopLevelMixin with AbstractExpressionMixin {
  final ExpressionBuilder _target;
  final ExpressionBuilder _ifTrue;
  final ExpressionBuilder _ifFalse;

  _TernaryExpression(
    this._target,
    this._ifTrue,
    this._ifFalse,
  );

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.conditionalExpression(
      _target.buildExpression(scope),
      $question,
      _ifTrue.buildExpression(scope),
      $colon,
      _ifFalse.buildExpression(scope),
    );
  }
}
