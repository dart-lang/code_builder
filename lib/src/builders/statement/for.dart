// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/tokens.dart';

abstract class ForStatementBuilder implements HasStatements, StatementBuilder {
  factory ForStatementBuilder(
    String identifier,
    ExpressionBuilder initializer,
    ExpressionBuilder condition,
    List<ExpressionBuilder> updaters,
  ) = _ForLoopStatementBuilder;

  factory ForStatementBuilder.forEach(
    String identifier,
    ExpressionBuilder iterable, {
    bool asAwait: false,
    bool asFinal: false,
  }) {
    return new _ForIteratorStatementBuilder(
      asAwait,
      asFinal,
      identifier,
      iterable,
    );
  }
}

class _ForIteratorStatementBuilder extends Object
    with HasStatementsMixin, TopLevelMixin
    implements ForStatementBuilder {
  final bool _asAwait;
  final bool _asFinal;
  final String _identifier;
  final ExpressionBuilder _iterable;

  _ForIteratorStatementBuilder(
    this._asAwait,
    this._asFinal,
    this._identifier,
    this._iterable,
  );

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return astFactory.forEachStatementWithDeclaration(
      _asAwait ? $await : null,
      $for,
      $openParen,
      astFactory.declaredIdentifier(
        null,
        null,
        _asFinal ? $final : $var,
        null,
        astFactory.simpleIdentifier(stringToken(_identifier)),
      ),
      $in,
      _iterable.buildExpression(scope),
      $closeParen,
      buildBlock(scope),
    );
  }
}

class _ForLoopStatementBuilder extends Object
    with HasStatementsMixin, TopLevelMixin
    implements ForStatementBuilder {
  final String _identifier;
  final ExpressionBuilder _initializer;
  final ExpressionBuilder _condition;
  final List<ExpressionBuilder> _updaters;

  _ForLoopStatementBuilder(
    this._identifier,
    this._initializer,
    this._condition,
    this._updaters,
  );

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return astFactory.forStatement(
      $for,
      $openParen,
      astFactory.variableDeclarationList(
        null,
        null,
        $var,
        null,
        [
          astFactory.variableDeclaration(
            astFactory.simpleIdentifier(
              stringToken(_identifier),
            ),
            $equals,
            _initializer.buildExpression(scope),
          ),
        ],
      ),
      null,
      $semicolon,
      _condition.buildExpression(scope),
      $semicolon,
      _updaters.map((e) => e.buildExpression(scope)).toList(),
      $closeParen,
      buildBlock(scope),
    );
  }
}
