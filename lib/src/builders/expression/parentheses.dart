part of code_builder.src.builders.expression;

class _ParenthesesExpression extends ExpressionBuilderMixin {
  final ExpressionBuilder _expression;

  _ParenthesesExpression(this._expression);

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope = Scope.identity]) {
    return new ParenthesizedExpression(
      $openParen,
      _expression.buildExpression(scope),
      $closeParen,
    );
  }
}
