part of code_builder.src.builders.expression;

/// Creates a new builder for creating an `if` statement.
class IfStatementBuilder implements StatementBuilder {
  final ExpressionBuilder _condition;
  final List<StatementBuilder> _statements = <StatementBuilder>[];

  IfStatementBuilder._(this._condition);

  /// Lazily adds a [statement] builder.
  void addStatement(StatementBuilder statement) {
    _statements.add(statement);
  }

  /// Returns as a builder with `else` added.
  ElseStatementBuilder andElse([ExpressionBuilder condition]) {
    return new ElseStatementBuilder._(this, condition);
  }

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope = Scope.identity]) =>
      _buildElse([this], scope);

  static Statement _buildElse(
    List<IfStatementBuilder> stack, [
    Scope scope = Scope.identity,
  ]) {
    final pop = stack.removeLast();
    return new IfStatement(
      $if,
      $openParen,
      pop._condition.buildExpression(scope),
      $closeParen,
      new Block(
        $openCurly,
        pop._statements
            .map/*<Statement>*/((s) => s.buildStatement(scope))
            .toList(),
        $closeCurly,
      ),
      stack.isNotEmpty ? $else : null,
      stack.isEmpty
          ? null
          : stack.length > 1 || stack.last._condition != null
              ? _buildElse(stack, scope)
              : new Block(
                  $openCurly,
                  stack.last._statements
                      .map/*<Statement>*/((s) => s.buildStatement(scope))
                      .toList(),
                  $closeCurly,
                ),
    );
  }

  /// Parent if-statement, if any.
  IfStatementBuilder get parent => null;

  @override
  String toString() => '$runtimeType {$_condition}';
}

/// Creates a new builder for creating an `else` statement.
class ElseStatementBuilder extends IfStatementBuilder {
  final IfStatementBuilder _parent;

  ElseStatementBuilder._(this._parent, [ExpressionBuilder condition])
      : super._(condition);

  @override
  Statement buildStatement([Scope scope = Scope.identity]) {
    return IfStatementBuilder._buildElse(
      _getChain().toList(),
      scope,
    );
  }

  Iterable<IfStatementBuilder> _getChain() sync* {
    var builder = this;
    while (builder != null) {
      yield builder;
      builder = builder.parent;
    }
  }

  @override
  IfStatementBuilder get parent => _parent;
}
