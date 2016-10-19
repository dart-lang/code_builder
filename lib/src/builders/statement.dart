// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/method.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement/if.dart';
import 'package:code_builder/src/tokens.dart';

export 'package:code_builder/src/builders/statement/if.dart'
    show IfStatementBuilder, elseIf, elseThen, ifThen;

/// An [AstBuilder] that can add [StatementBuilder].
abstract class HasStatements implements AstBuilder {
  /// Adds [statement] to the builder.
  void addStatement(StatementBuilder statement);

  /// Adds [statements] to the builder.
  void addStatements(Iterable<StatementBuilder> statements);
}

/// Implements [HasStatements].
abstract class HasStatementsMixin implements HasStatements {
  final List<StatementBuilder> _statements = <StatementBuilder>[];

  @override
  void addStatement(StatementBuilder statement) {
    _statements.add(statement);
  }

  @override
  void addStatements(Iterable<StatementBuilder> statements) {
    _statements.addAll(statements);
  }

  /// Returns a [Block] statement.
  Block buildBlock([Scope scope]) {
    return new Block(
      $openCurly,
      buildStatements(scope),
      $closeCurly,
    );
  }

  /// Returns a [List] of all built [Statement]s.
  List<Statement> buildStatements([Scope scope]) {
    return _statements
        .map/*<Statement>*/((e) => e.buildStatement(scope))
        .toList();
  }

  /// Clones all expressions to [clone].
  void cloneStatementsTo(HasStatements clone) {
    clone.addStatements(_statements);
  }

  /// Whether at least one statement was added.
  bool get hasStatements => _statements.isNotEmpty;
}

/// Lazily builds an [Statement] AST when [buildStatement] is invoked.
abstract class StatementBuilder
    implements
        AstBuilder,
        ValidIfStatementMember,
        ValidConstructorMember,
        ValidMethodMember {
  /// Returns an [Statement] AST representing the builder.
  Statement buildStatement([Scope scope]);
}
