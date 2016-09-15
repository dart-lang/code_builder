// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds a [Statement] AST.
abstract class StatementBuilder implements CodeBuilder<Statement> {
  /// Returns a new [StatementBuilder] from the result of [ExpressionBuilder].
  factory StatementBuilder.fromExpression(ExpressionBuilder builder) {
    return new _ExpressionStatementBuilder(new ExpressionStatement(
      builder.toAst(),
      _semicolon,
    ));
  }
}

class _ExpressionStatementBuilder
    extends _AbstractCodeBuilder<ExpressionStatement>
    implements StatementBuilder {
  _ExpressionStatementBuilder(ExpressionStatement astNode) : super._(astNode);
}
