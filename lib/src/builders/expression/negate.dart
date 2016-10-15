part of code_builder.src.builders.expression;

class _NegateExpression extends ExpressionBuilderMixin {
  final ExpressionBuilder _expression;

  _NegateExpression(this._expression);

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope = Scope.identity]) {
    return new PrefixExpression(
      $not,
      _expression.buildExpression(scope),
    );
  }
}
