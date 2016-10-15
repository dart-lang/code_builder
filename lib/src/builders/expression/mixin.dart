part of code_builder.src.builders.expression;

/// A partial implementation of [ExpressionBuilder] suitable as a mixin.
abstract class ExpressionBuilderMixin implements ExpressionBuilder {
  @override
  StatementBuilder asAssert() => new _AsAssert(this);

  @override
  ExpressionBuilder assign(String variable) => new _AsAssign(this, variable);

  @override
  StatementBuilder asConst(String variable, [TypeBuilder type]) =>
      new _AsAssignStatement(this, variable,
          keyword: _AsAssignType.asConst, type: type);

  @override
  StatementBuilder asFinal(String variable, [TypeBuilder type]) =>
      new _AsAssignStatement(this, variable,
          keyword: _AsAssignType.asFinal, type: type);

  @override
  StatementBuilder asVar(String variable, [TypeBuilder type]) =>
      new _AsAssignStatement(this, variable,
          keyword: _AsAssignType.asVar, type: type);

  @override
  StatementBuilder asStatement() => new _AsStatement(this);

  @override
  ConstructorInitializerBuilder asInitializer(String field) =>
      initializer(field, this);

  @override
  Statement buildStatement([Scope scope = Scope.identity]) {
    return new ExpressionStatement(
      buildExpression(scope),
      $semicolon,
    );
  }

  @override
  IfStatementBuilder asIf() => new IfStatementBuilder._(this);

  @override
  StatementBuilder asReturn() => new _AsReturn(this);

  @override
  ExpressionSelfInvocationBuilder call([
    Iterable<ExpressionBuilder> arguments,
  ]) =>
      new ExpressionSelfInvocationBuilder._(this, positional: arguments);

  @override
  ExpressionSelfInvocationBuilder callWith({
    Map<String, ExpressionBuilder> named,
    Iterable<ExpressionBuilder> positional,
  }) =>
      new ExpressionSelfInvocationBuilder._(
        this,
        positional: positional,
        named: named,
      );

  @override
  ExpressionInvocationBuilder invoke(
    String method, [
    Iterable<ExpressionBuilder> arguments,
  ]) =>
      new ExpressionInvocationBuilder._(method, this, positional: arguments);

  @override
  ExpressionInvocationBuilder invokeWith(
    String name, {
    Map<String, ExpressionBuilder> named,
    Iterable<ExpressionBuilder> positional,
  }) =>
      new ExpressionInvocationBuilder._(
        name,
        this,
        positional: positional,
        named: named,
      );

  @override
  ExpressionBuilder equals(ExpressionBuilder other) {
    return new _BinaryExpression(this, other, $equalsEquals);
  }

  @override
  ExpressionBuilder notEquals(ExpressionBuilder other) {
    return new _BinaryExpression(this, other, $notEquals);
  }

  @override
  ExpressionBuilder not() => new _NegateExpression(this);

  @override
  ExpressionBuilder parentheses() => new _ParenthesesExpression(this);

  @override
  ExpressionBuilder operator +(ExpressionBuilder other) {
    return new _BinaryExpression(
      this,
      other,
      $plus,
    );
  }
}

class _AsStatement extends StatementBuilder {
  final ExpressionBuilder _expression;

  _AsStatement(this._expression);

  @override
  Statement buildStatement([Scope scope = Scope.identity]) =>
      _expression.buildStatement(scope);
}
