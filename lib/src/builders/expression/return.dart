// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _AsReturn extends TopLevelMixin implements StatementBuilder {
  final ExpressionBuilder _value;

  _AsReturn(this._value);

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return new ReturnStatement(
      $return,
      _value.buildExpression(),
      $semicolon,
    );
  }
}
