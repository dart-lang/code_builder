// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/tokens.dart';

class WhileStatementBuilder extends HasStatementsMixin
    with TopLevelMixin
    implements StatementBuilder {
  final bool _asDo;
  final ExpressionBuilder _condition;

  WhileStatementBuilder(this._asDo, this._condition);

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    if (_asDo) {
      return astFactory.doStatement(
        $do,
        buildBlock(scope),
        $while,
        $openParen,
        _condition.buildExpression(scope),
        $closeParen,
        $semicolon,
      );
    }
    return astFactory.whileStatement(
      $while,
      $openParen,
      _condition.buildExpression(scope),
      $closeParen,
      buildBlock(scope),
    );
  }
}
