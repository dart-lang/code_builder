// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/shared.dart';

/// Lazily builds an [Statement] AST when [buildStatement] is invoked.
abstract class StatementBuilder implements AstBuilder {
  /// Returns an [Statement] AST representing the builder.
  Statement buildStatement([Scope scope]);
}

/// An [AstBuilder] that can add [StatementBuilder].
abstract class HasStatements implements AstBuilder {
  final List<StatementBuilder> _statements = <StatementBuilder> [];

  /// Adds [statement] to the builder.
  void addStatement(StatementBuilder statement) {
    _statements.add(statement);
  }

  /// Adds [statements] to the builder.
  void addStatements(Iterable<StatementBuilder> statements) {
    _statements.addAll(statements);
  }
}

/// Implements [HasStatements].
abstract class HasStatementsMixin extends HasStatements {
  /// Clones all expressions to [clone].
  void cloneStatementsTo(HasStatements clone) {
    clone.addStatements(_statements);
  }

  /// Returns a [List] of all built [Statement]s.
  List<Statement> buildStatements([Scope scope]) => _statements.map/*<Statement>*/((e) => e.buildStatement(scope)).toList();
}
