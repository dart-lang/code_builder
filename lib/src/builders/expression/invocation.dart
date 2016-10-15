part of code_builder.src.builders.expression;

/// Builds an invocation expression AST.
class ExpressionSelfInvocationBuilder extends ExpressionBuilderMixin {
  final List<ExpressionBuilder> _positional;
  final Map<String, ExpressionBuilder> _named;
  final ExpressionBuilder _target;

  ExpressionSelfInvocationBuilder._(
    this._target, {
    Iterable<ExpressionBuilder> positional: const [],
    Map<String, ExpressionBuilder> named: const {},
  })
      : _positional = positional.toList(growable: false),
        _named = new Map<String, ExpressionBuilder>.from(named);

  ArgumentList _toArgumentList([Scope scope = Scope.identity]) {
    final expressions = <Expression>[];
    for (final arg in _positional) {
      expressions.add(arg.buildExpression(scope));
    }
    for (final name in _named.keys) {
      final arg = _named[name];
      expressions.add(new NamedExpression(
        new Label(
          new SimpleIdentifier(
            stringToken(name),
          ),
          $colon,
        ),
        arg.buildExpression(scope),
      ));
    }
    return new ArgumentList(
      $openParen,
      expressions,
      $closeParen,
    );
  }

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope = Scope.identity]) {
    return new FunctionExpressionInvocation(
      _target.buildExpression(scope),
      null,
      _toArgumentList(scope),
    );
  }
}

/// Builds an invocation expression AST.
class ExpressionInvocationBuilder extends ExpressionSelfInvocationBuilder {
  final String _method;

  ExpressionInvocationBuilder._(
    this._method,
    ExpressionBuilder target, {
    Map<String, ExpressionBuilder> named,
    Iterable<ExpressionBuilder> positional,
  })
      : super._(target, named: named, positional: positional);

  @override
  Expression buildExpression([Scope scope = Scope.identity]) {
    return new MethodInvocation(
      _target.buildExpression(scope),
      $period,
      new SimpleIdentifier(stringToken(_method)),
      null,
      _toArgumentList(scope),
    );
  }
}
