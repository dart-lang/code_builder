part of code_builder.src.builders.expression;

class _AsReturn implements StatementBuilder {
  final ExpressionBuilder _expression;

  _AsReturn(this._expression);

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope = Scope.identity]) {
    return new ReturnStatement(
      $return,
      _expression.buildExpression(scope),
      $semicolon,
    );
  }
}
