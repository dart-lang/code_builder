import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/tokens.dart';

/// Represents a break statement AST.
abstract class BreakStatementBuilder implements StatementBuilder {
  factory BreakStatementBuilder() => new _BreakStatementBuilder();

  /// Returns a [BreakStatement] AST representing the builder.
  BreakStatement buildBreakStatement([Scope scope]);
}

class _BreakStatementBuilder extends Object
    with TopLevelMixin
    implements BreakStatementBuilder {
  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) => buildBreakStatement(scope);

  @override
  BreakStatement buildBreakStatement([Scope scope]) =>
      astFactory.breakStatement($break, null, $semicolon);
}