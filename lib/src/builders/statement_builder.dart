// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds a [Statement] AST.
abstract class StatementBuilder implements CodeBuilder<Statement> {
  StatementBuilder._sealed();
}

class _ExpressionStatementBuilder implements StatementBuilder {
  final ExpressionBuilder _expression;

  _ExpressionStatementBuilder(this._expression);

  @override
  Statement toAst([Scope scope = const Scope.identity()]) {
    return new ExpressionStatement(
      _expression.toAst(scope),
      $semicolon,
    );
  }
}
