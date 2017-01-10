// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/tokens.dart';

/// Represents a break statement AST.
const breakStatement = const _BreakStatementBuilder();

class _BreakStatementBuilder extends Object implements StatementBuilder {
  const _BreakStatementBuilder();

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) => buildBreakStatement(scope);

  BreakStatement buildBreakStatement([Scope scope]) =>
      astFactory.breakStatement($break, null, $semicolon);

  @override
  CompilationUnitMember buildTopLevelAst([Scope scope]) {
    throw new UnsupportedError('$runtimeType does not work in the top-level');
  }
}
