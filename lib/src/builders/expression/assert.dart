part of code_builder.src.builders.expression;

class _AsAssert extends StatementBuilder {
  final ExpressionBuilder _expression;

  _AsAssert(this._expression);

  @override
  Statement buildStatement([Scope scope = Scope.identity]) {
    return new AssertStatement(
      $assert,
      $openParen,
      _expression.buildExpression(scope),
      null,
      null,
      $closeParen,
      $semicolon,
    );
  }
}
