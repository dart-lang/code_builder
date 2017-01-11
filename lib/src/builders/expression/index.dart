// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _IndexExpression extends AbstractExpressionMixin with TopLevelMixin {
  final ExpressionBuilder _target;
  final ExpressionBuilder _index;

  _IndexExpression(this._target, this._index);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.indexExpressionForTarget(
      _target.buildExpression(scope),
      $openBracket,
      _index.buildExpression(scope),
      $closeBracket,
    );
  }
}
