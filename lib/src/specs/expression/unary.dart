part of code_builder.src.specs.expression;

/// Represents an [operator] and expression [target].
class UnaryExpression extends Expression {
  final Expression target;
  final String operator;
  final bool addSpace;
  final bool isConst;

  const UnaryExpression._(
    this.target,
    this.operator, {
    this.addSpace = false,
    this.isConst = false,
  });

  @override
  R accept<R>(ExpressionVisitor<R> visitor, [R context]) {
    return visitor.visitUnaryExpression(this, context);
  }
}
