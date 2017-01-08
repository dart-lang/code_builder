// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/tokens.dart';

/// Short-hand syntax for `new SwitchCaseBuilder(...)`.
SwitchCaseBuilder switchCase(ExpressionBuilder condition,
        [Iterable<StatementBuilder> statements = const []]) =>
    new SwitchCaseBuilder(condition)..addStatements(statements ?? []);

/// Short-hand syntax for `new SwitchDefaultCaseBuilder(...)`.
SwitchDefaultCaseBuilder switchDefault(
        [Iterable<StatementBuilder> statements = const []]) =>
    new SwitchDefaultCaseBuilder()..addStatements(statements ?? []);

/// Short-hand syntax for `new SwitchStatementBuilder(...)`.
SwitchStatementBuilder switchStatement(ExpressionBuilder expression,
        {Iterable<SwitchCaseBuilder> cases: const [],
        SwitchDefaultCaseBuilder defaultCase}) =>
    new SwitchStatementBuilder(expression)
      ..setDefaultCase(defaultCase)
      ..addCases(cases ?? []);

/// Represents an [ExpressionBuilder] and a series of [SwitchCaseBuilder]s as a switch statement AST.
abstract class SwitchStatementBuilder implements StatementBuilder {
  /// Creates a new [SwitchStatementBuilder].
  factory SwitchStatementBuilder(ExpressionBuilder expression,
          [Iterable<ValidSwitchMember> members = const []]) =>
      new _SwitchStatementBuilder(expression, members);

  /// Adds a [switchCase] to the builder.
  void addCase(SwitchCaseBuilder switchCase);

  /// Adds a [switchCase]s to the builder.
  void addCases(Iterable<SwitchCaseBuilder> switchCases);

  /// Returns an [SwitchStatement] AST representing the builder.
  SwitchStatement buildSwitchStatement();

  /// Sets the `default` cases of the builder.
  void setDefaultCase(SwitchDefaultCaseBuilder defaultCase);
}

/// A marker interface for an AST that could be added to [SwitchStatementBuilder].
///
/// This can be either a [SwitchCaseBuilder] or a [SwitchDefaultCaseBuilder].
abstract class ValidSwitchMember {}

/// Represents an [ExpressionBuilder] and a series of [Statement]s as a switch case AST.
abstract class SwitchCaseBuilder implements HasStatements, ValidSwitchMember {
  /// Creates a new [SwitchCaseBuilder].
  factory SwitchCaseBuilder(ExpressionBuilder condition) =>
      new _SwitchCaseBuilder(condition);

  /// Returns an [SwitchMember] AST representing the builder.
  SwitchMember buildSwitchMember([Scope scope]);
}

/// Represents a series of [Statement]s as a default switch case AST.
abstract class SwitchDefaultCaseBuilder
    implements HasStatements, ValidSwitchMember {
  factory SwitchDefaultCaseBuilder() => new _SwitchDefaultCaseBuilder();

  /// Returns an [SwitchMember] AST representing the builder.
  SwitchMember buildSwitchMember([Scope scope]);
}

class _SwitchStatementBuilder extends Object
    with TopLevelMixin
    implements SwitchStatementBuilder {
  final ExpressionBuilder _expression;
  final List<SwitchCaseBuilder> _cases = [];
  SwitchDefaultCaseBuilder _defaultCase;

  _SwitchStatementBuilder(this._expression,
      [Iterable<ValidSwitchMember> members = const []]) {
    for (final member in members) {
      if (member is SwitchDefaultCaseBuilder)
        _defaultCase = member;
      else if (member is SwitchCaseBuilder) _cases.add(member);
    }
  }

  @override
  void addCase(SwitchCaseBuilder switchCase) => _cases.add(switchCase);

  @override
  void addCases(Iterable<SwitchCaseBuilder> switchCases) =>
      _cases.addAll(switchCases);

  void setDefaultCase(SwitchDefaultCaseBuilder defaultCase) {
    _defaultCase = defaultCase;
  }

  @override
  AstNode buildAst([Scope scope]) => buildStatement();

  @override
  SwitchStatement buildSwitchStatement([Scope scope]) {
    var members = _cases.map((c) => c.buildSwitchMember(scope)).toList();

    if (_defaultCase != null)
      members.add(_defaultCase.buildSwitchMember(scope));

    return astFactory.switchStatement(
        $switch,
        $openBracket,
        _expression.buildExpression(),
        $closeParen,
        $openBracket,
        members,
        $closeBracket);
  }

  @override
  Statement buildStatement([Scope scope]) => buildSwitchStatement(scope);
}

class _SwitchCaseBuilder extends Object
    with HasStatementsMixin
    implements SwitchCaseBuilder {
  final ExpressionBuilder _condition;

  _SwitchCaseBuilder(this._condition);

  @override
  AstNode buildAst([Scope scope]) => buildSwitchMember(scope);

  @override
  SwitchMember buildSwitchMember([Scope scope]) => astFactory.switchCase(null,
      $case, _condition.buildExpression(), $colon, buildStatements(scope));
}

class _SwitchDefaultCaseBuilder extends Object
    with HasStatementsMixin
    implements SwitchDefaultCaseBuilder {
  @override
  AstNode buildAst([Scope scope]) => buildSwitchMember(scope);

  @override
  SwitchMember buildSwitchMember([Scope scope]) =>
      astFactory.switchDefault(null, $default, $colon, buildStatements());
}
