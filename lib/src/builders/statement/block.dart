// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/tokens.dart';

/// Represents a series of [StatementBuilder]s as a block statement AST.
abstract class BlockStatementBuilder
    implements HasStatements, StatementBuilder {
  /// Creates a new [BlockStatementBuilder].
  factory BlockStatementBuilder() = _BlockStatementBuilder;
}

class _BlockStatementBuilder extends Object
    with HasStatementsMixin, TopLevelMixin
    implements BlockStatementBuilder {
  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return astFactory.block(
      $openCurly,
      buildStatements(scope),
      $closeCurly,
    );
  }
}
