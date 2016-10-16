part of code_builder.src.builders.expression;

class _AsAssert implements StatementBuilder {
  final ExpressionBuilder _expression;

  _AsAssert(this._expression);

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return new AssertStatement(
      $assert,
      $openParen,
      _expression.buildExpression(scope),
      null,
      null,
      $closeParen,
      null,
    );
  }
}
