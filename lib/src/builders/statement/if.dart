import 'package:analyzer/dart/ast/ast.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/builders/statement/block.dart';
import 'package:code_builder/src/tokens.dart';

/// Denotes an [ifStmt] that should be added as an `else if` in [ifThen].
_IfStatementBuilderWrapper elseIf(IfStatementBuilder ifStmt) {
  return new _IfStatementBuilderWrapper(ifStmt, null);
}

/// Denotes a series of [statements] added to a final `else` in [ifThen].
_IfStatementBuilderWrapper elseThen(Iterable<StatementBuilder> statements) {
  return new _IfStatementBuilderWrapper(null, statements);
}

/// Short-hand syntax for `new IfStatementBuilder(...)`.
IfStatementBuilder ifThen(
  ExpressionBuilder condition, [
  Iterable<ValidIfStatementMember> members = const [],
]) {
  final ifStmt = new IfStatementBuilder(condition);
  IfStatementBuilder current = ifStmt;
  for (final member in members) {
    if (member is _IfStatementBuilderWrapper) {
      if (member._ifStmt != null) {
        current.setElse(member._ifStmt);
        current = member._ifStmt;
      } else {
        current.setElse(
            new BlockStatementBuilder()..addStatements(member._elseStmts));
        current = null;
      }
    } else if (member is StatementBuilder) {
      ifStmt.addStatement(member);
    } else {
      throw new UnsupportedError('Invalid type: ${member.runtimeType}');
    }
  }
  return ifStmt;
}

/// Builds an [IfStatement] AST.
abstract class IfStatementBuilder implements HasStatements, StatementBuilder {
  /// Returns a new [IfStatementBuilder] where `if (condition) {`.
  factory IfStatementBuilder(ExpressionBuilder condition) {
    return new _BlockIfStatementBuilder(condition);
  }

  /// Adds an `else` block that evaluates [statements].
  void setElse(StatementBuilder statements);
}

/// Marker interface for builders valid for use with [ifThen].
abstract class ValidIfStatementMember implements AstBuilder {}

class _BlockIfStatementBuilder extends HasStatementsMixin
    implements IfStatementBuilder {
  final ExpressionBuilder _condition;
  StatementBuilder _elseBlock;

  _BlockIfStatementBuilder(this._condition);

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return new IfStatement(
      $if,
      $openParen,
      _condition.buildExpression(scope),
      $closeParen,
      buildBlock(scope),
      _elseBlock != null ? $else : null,
      _elseBlock?.buildStatement(scope),
    );
  }

  @override
  void setElse(StatementBuilder statements) {
    _elseBlock = statements;
  }
}

class _IfStatementBuilderWrapper implements ValidIfStatementMember {
  final IfStatementBuilder _ifStmt;
  final Iterable<StatementBuilder> _elseStmts;

  _IfStatementBuilderWrapper(this._ifStmt, this._elseStmts);

  @override
  AstNode buildAst([_]) => throw new UnsupportedError('Use within ifThen.');
}
