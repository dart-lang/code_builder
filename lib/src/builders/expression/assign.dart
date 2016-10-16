part of code_builder.src.builders.expression;

class _AsAssign extends AbstractExpressionMixin {
  final ExpressionBuilder _value;
  final String _name;

  _AsAssign(this._value, this._name);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return new AssignmentExpression(
      stringIdentifier(_name),
      $equals,
      _value.buildExpression(scope),
    );
  }
}

class _AsAssignNew implements StatementBuilder {
  final ExpressionBuilder _value;
  final String _name;
  final TypeBuilder _type;
  final Token _modifier;

  _AsAssignNew(this._value, this._name, this._type, this._modifier);

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return new VariableDeclarationStatement(
      new VariableDeclarationList(
        null,
        null,
        _type == null || _modifier != $var ? _modifier : null,
        _type?.buildType(scope),
        [
          new VariableDeclaration(
            stringIdentifier(_name),
            $equals,
            _value.buildExpression(scope),
          ),
        ],
      ),
      $semicolon,
    );
  }
}
