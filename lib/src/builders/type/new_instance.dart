part of code_builder.src.builders.type;

/// Lazily builds an [InstanceCreationExpression] AST when built.
///
/// See [TypeBuilder]:
/// - [TypeBuilder.constInstance]
/// - [TypeBuilder.constInstanceWith]
/// - [TypeBuilder.newInstance]
/// - [TypeBuilder.newInstanceWith]
abstract class NewInstanceBuilder
    implements AnnotationBuilder, InvocationBuilder {
  factory NewInstanceBuilder._const(TypeBuilder type, [String name]) {
    return new _NewInvocationBuilderImpl(Keyword.CONST, type, name);
  }

  factory NewInstanceBuilder._new(TypeBuilder type, [String name]) {
    return new _NewInvocationBuilderImpl(Keyword.NEW, type, name);
  }
}

class _NewInvocationBuilderImpl extends Object
    with AbstractExpressionMixin, AbstractInvocationBuilderMixin
    implements NewInstanceBuilder {
  final String _name;
  final Keyword _keyword;
  final TypeBuilder _type;

  _NewInvocationBuilderImpl(this._keyword, this._type, [this._name]);

  @override
  Annotation buildAnnotation([Scope scope]) {
    return new Annotation(
      $at,
      _type.buildType(scope).name,
      $period,
      _name != null ? stringIdentifier(_name) : null,
      buildArgumentList(scope),
    );
  }

  @override
  Expression buildExpression([Scope scope]) {
    return new InstanceCreationExpression(
      new KeywordToken(_keyword, 0),
      new ConstructorName(
        _type.buildType(scope),
        _name != null ? $period : null,
        _name != null ? stringIdentifier(_name) : null,
      ),
      buildArgumentList(scope),
    );
  }
}
