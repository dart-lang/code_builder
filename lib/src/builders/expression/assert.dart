// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _AsAssert implements StatementBuilder {
  final ExpressionBuilder _expression;

  _AsAssert(this._expression);

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return new AssertStatement(
      $assert,
      $openParen,
      _expression.buildExpression(scope),
      null,
      null,
      $closeParen,
      null,
    );
  }
}
