part of code_builder.src.builders.expression;

class _AsAssign extends ExpressionBuilderMixin {
  final ExpressionBuilder _expression;
  final String _name;

  _AsAssign(this._expression, this._name);

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope = Scope.identity]) {
    final name = new SimpleIdentifier(stringToken(_name));
    return new AssignmentExpression(
      name,
      $equals,
      _expression.buildExpression(scope),
    );
  }
}

enum _AsAssignType {
  asConst,
  asFinal,
  asVar,
}

class _AsAssignStatement extends StatementBuilder {
  final ExpressionBuilder _expression;
  final String _name;
  final _AsAssignType _keyword;
  final TypeBuilder _type;

  _AsAssignStatement(
    this._expression,
    this._name, {
    _AsAssignType keyword,
    TypeBuilder type,
  })
      : _keyword = keyword,
        _type = type;

  @override
  Statement buildStatement([Scope scope = Scope.identity]) {
    final name = new SimpleIdentifier(stringToken(_name));
    Token token;
    switch (_keyword) {
      case _AsAssignType.asConst:
        token = $const;
        break;
      case _AsAssignType.asFinal:
        token = $final;
        break;
      case _AsAssignType.asVar:
        token = $var;
        break;
    }
    return new VariableDeclarationStatement(
      new VariableDeclarationList(
        null,
        null,
        token,
        _type?.buildType(scope),
        [
          new VariableDeclaration(
            name,
            $equals,
            _expression.buildExpression(scope),
          )
        ],
      ),
      $semicolon,
    );
  }
}
