part of code_builder.src.builders.expression;

class _LiteralExpression extends ExpressionBuilderMixin {
  final Literal _literal;

  _LiteralExpression(this._literal);

  @override
  AstNode buildAst([_]) => buildExpression();

  @override
  Expression buildExpression([_]) => _literal;
}

final Literal _null = new NullLiteral($null);
final Literal _true = new BooleanLiteral($true, true);
final Literal _false = new BooleanLiteral($false, false);

final ExpressionBuilder _literalNull = new _LiteralExpression(_null);
final ExpressionBuilder _literalTrue = new _LiteralExpression(_true);
final ExpressionBuilder _literalFalse = new _LiteralExpression(_false);

/// Return a literal [value].
///
/// Must either be `null` or a primitive type.
///
/// __Example use__:
///   literal(null);
///   literal('Hello World');
///   literal(5);
///   literal(false);
///
/// **NOTE**: A string literal is automatically wrapped in single-quotes.
///
/// TODO(matanl): Add support for literal [List] and [Map] of other literals.
ExpressionBuilder literal(value) {
  if (value == null) {
    return _literalNull;
  }
  if (value is bool) {
    return value ? _literalTrue : _literalFalse;
  }
  if (value is String) {
    return new _LiteralExpression(new SimpleStringLiteral(
      stringToken("'$value'"),
      value,
    ));
  }
  if (value is int) {
    return new _LiteralExpression(new IntegerLiteral(
      stringToken(value.toString()),
      value,
    ));
  }
  throw new ArgumentError('Invalid type: ${value.runtimeType}');
}
