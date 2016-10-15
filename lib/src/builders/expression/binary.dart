part of code_builder.src.builders.expression;

class _BinaryExpression extends ExpressionBuilderMixin {
  final ExpressionBuilder _a;
  final ExpressionBuilder _b;
  final Token _operator;

  _BinaryExpression(this._a, this._b, this._operator);

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope = Scope.identity]) {
    return new BinaryExpression(
      _a.buildExpression(scope),
      _operator,
      _b.buildExpression(scope),
    );
  }
}
