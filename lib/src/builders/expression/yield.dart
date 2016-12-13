// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _AsYield extends TopLevelMixin implements StatementBuilder {
  final ExpressionBuilder _expression;
  final bool _isStar;

  _AsYield(this._expression, this._isStar);

  @override
  Statement buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return new YieldStatement(
      $yield,
      _isStar ? $star : null,
      _expression.buildExpression(scope),
      $semicolon,
    );
  }
}
