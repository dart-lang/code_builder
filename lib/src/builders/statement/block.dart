import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/tokens.dart';

/// Represents a series of [StatementBuilder]s as a block statement AST.
abstract class BlockStatementBuilder implements
    HasStatements,
    StatementBuilder {
  /// Creates a new [BlockStatementBuilder].
  factory BlockStatementBuilder() = _BlockStatementBuilder;
}

class _BlockStatementBuilder
    extends Object
    with HasStatementsMixin
    implements BlockStatementBuilder {
  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return new Block(
      $openCurly,
      buildStatements(scope),
      $closeCurly,
    );
  }
}
