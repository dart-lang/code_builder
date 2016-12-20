// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _AsAwait extends AbstractExpressionMixin with TopLevelMixin {
  final ExpressionBuilder _expression;

  _AsAwait(this._expression);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return new AwaitExpression(
      $await,
      _expression.buildExpression(scope),
    );
  }
}
