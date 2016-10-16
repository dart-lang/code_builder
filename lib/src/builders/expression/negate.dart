part of code_builder.src.builders.expression;

class _NegateExpression extends AbstractExpressionMixin {
  final ExpressionBuilder _expression;

  _NegateExpression(this._expression);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return new PrefixExpression(
      $not,
      _expression.parentheses().buildExpression(scope),
    );
  }
}
