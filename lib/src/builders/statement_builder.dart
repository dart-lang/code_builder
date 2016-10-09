// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds a [Statement] AST.
abstract class StatementBuilder implements CodeBuilder<Statement> {
  StatementBuilder._sealed();
}

/// Builds an `if` [Statement] AST.
class IfStatementBuilder implements CodeBuilder<Statement> {
  final ExpressionBuilder _condition;
  final List<StatementBuilder> _statements = <StatementBuilder> [];

  IfStatementBuilder._(this._condition);

  /// Lazily adds [statement] to the then-clause of this if statement.
  void addStatement(StatementBuilder statement) {
    _statements.add(statement);
  }

  @override
  Statement toAst([Scope scope = const Scope.identity()]) {
    return new IfStatement(
      $if,
      $openParen,
      _condition.toAst(scope),
      $closeParen,
      new Block(
        $openCurly,
        _statements.map/*<Statement>*/((s) => s.toAst(scope)),
        $closeCurly,
      ),
      null,
      null,
    );
  }
}

class _AssertionStatementBuilder implements StatementBuilder {
  final ExpressionBuilder _expression;

  _AssertionStatementBuilder(this._expression);

  @override
  Statement toAst([Scope scope = const Scope.identity()]) {
    return new AssertStatement(
      null,
      null,
      _expression.toAst(scope),
      null,
      null,
      null,
      null,
    );
  }
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

class _ReturnStatementBuilder implements StatementBuilder {
  final ExpressionBuilder _expression;

  _ReturnStatementBuilder(this._expression);

  @override
  Statement toAst([Scope scope = const Scope.identity()]) {
    return new ReturnStatement(
      $return,
      _expression.toAst(scope),
      $semicolon,
    );
  }
}
