part of code_builder.src.builders.expression;

class _AsReturn implements StatementBuilder {
  final ExpressionBuilder _value;

  _AsReturn(this._value);

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return new ReturnStatement(
      $return,
      _value.buildExpression(),
      $semicolon,
    );
  }
}
