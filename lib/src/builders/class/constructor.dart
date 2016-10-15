part of code_builder.src.builders.clazz;

void _addMembers(
  ConstructorBuilder constructor,
  Iterable<ValidConstructorMember> members,
) {
  for (final member in members) {
    if (member is StatementBuilder) {
      constructor.addStatement(member);
    } else if (member is ConstructorInitializerBuilder) {
      constructor.addInitializer(member);
    } else if (member is ParameterBuilder) {
      constructor.addPositionalParameter(member);
    }
  }
}

/// Returns a new unnamed constructor with [members].
ConstructorBuilder constructor([
  Iterable<ValidConstructorMember> members = const [],
]) {
  final constructor = new _ConstructorBuilderImpl._detached(null);
  _addMembers(constructor, members);
  return constructor;
}

/// Returns a new named constructor with [members].
ConstructorBuilder constructorNamed(
  String name, [
  Iterable<ValidConstructorMember> members = const [],
]) {
  final constructor = new _ConstructorBuilderImpl._detached(name);
  _addMembers(constructor, members);
  return constructor;
}

/// Return a new initializer of [field] to [expression].
ConstructorInitializerBuilder initializer(
    String field, ExpressionBuilder expression) {
  return new ConstructorInitializerBuilder._(field, expression);
}

/// A detached initializer statement for a [ConstructorBuilder].
///
/// See [initializer] and [ExpressionBuilder.asInitializer].
class ConstructorInitializerBuilder implements ValidConstructorMember {
  final String _field;
  final ExpressionBuilder _initializeTo;

  ConstructorInitializerBuilder._(this._field, this._initializeTo);

  /// Returns a new [ConstructorInitializer] AST.
  ConstructorInitializer buildConstructorInitializer(
          [Scope scope = Scope.identity]) =>
      buildAst(scope);

  @override
  AstNode buildAst([Scope scope = Scope.identity]) {
    return new ConstructorFieldInitializer(
      $this,
      $period,
      new SimpleIdentifier(stringToken(_field)),
      $equals,
      _initializeTo.buildExpression(scope),
    );
  }
}

/// Builds a [ConstructorDeclaration] AST.
abstract class ConstructorBuilder
    implements AstBuilder, HasAnnotations, HasParameters, HasStatements {
  /// Create a new [ConstructorBuilder] for a `class`, optionally named.
  factory ConstructorBuilder(ClassBuilder clazz, [String name]) =
      _ConstructorBuilderImpl;

  /// Adds an [initializer].
  void addInitializer(ConstructorInitializerBuilder initializer);

  /// Returns a new [ConstructorBuilder] attached to [clazz].
  ConstructorBuilder attachTo(ClassBuilder clazz);
}

/// Builds a [ConstructorDeclaration] AST.
class _ConstructorBuilderImpl extends Object
    with HasAnnotationsMixin, HasParametersMixin, HasStatementsMixin
    implements ConstructorBuilder {
  final ClassBuilder _clazz;
  final List<ConstructorInitializerBuilder> _initializers =
      <ConstructorInitializerBuilder>[];
  final String _name;

  _ConstructorBuilderImpl(this._clazz, [this._name]);

  // Internal: Allows using the constructor() factory inside of clazz().
  _ConstructorBuilderImpl._detached([this._name]) : this._clazz = null;

  @override
  ConstructorBuilder attachTo(ClassBuilder clazz) {
    final constructor = new ConstructorBuilder(clazz, _name);
    _initializers.forEach(constructor.addInitializer);
    cloneStatementsTo(constructor);
    cloneParametersTo(constructor);
    return constructor;
  }

  @override
  void addInitializer(ConstructorInitializerBuilder initializer) {
    _initializers.add(initializer);
  }

  @override
  AstNode buildAst([Scope scope = Scope.identity]) {
    return new ConstructorDeclaration(
      null,
      toAnnotationAsts(scope),
      null,
      null,
      null,
      new SimpleIdentifier(stringToken(_clazz._name)),
      _name != null ? $period : null,
      _name != null ? new SimpleIdentifier(stringToken(_name)) : null,
      toFormalParameterList(scope),
      null,
      _initializers
          .map/*<ConstructorInitializer>*/(
              (i) => i.buildConstructorInitializer(scope))
          .toList(),
      null,
      !hasStatements
          ? new EmptyFunctionBody($semicolon)
          : new BlockFunctionBody(
              null,
              null,
              new Block(
                $openCurly,
                toStatementAsts(scope),
                $closeCurly,
              )),
    );
  }
}
