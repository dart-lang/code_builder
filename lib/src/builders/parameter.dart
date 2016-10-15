import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/tokens.dart';

/// Create a new parameter [name], optionally with [members].
ParameterBuilder parameter(
  String name, [
  Iterable<ValidParameterMember> members = const [],
]) {
  var parameter = new ParameterBuilder(
    name,
    members.firstWhere(
      (p) => p is TypeBuilder,
      orElse: () => null,
    ) as TypeBuilder,
  );
  final expression = members.firstWhere(
    (p) => p is ExpressionBuilder,
    orElse: () => null,
  );
  for (final member in members) {
    if (member is AnnotationBuilder) {
      parameter.addAnnotation(member);
    }
  }
  if (expression != null) {
    parameter = parameter.toDefault(expression);
  }
  return parameter;
}

/// Builds a [FormalParameter] AST.
abstract class ParameterBuilder
    implements AstBuilder, HasAnnotations, ValidConstructorMember {
  /// Create a new parameter [name], optionally with [type].
  factory ParameterBuilder(String name, [TypeBuilder type]) =
      _SimpleParameterBuilder;

  /// Returns a new [FormalParameter] AST as a named parameter.
  FormalParameter buildNamed([Scope scope = Scope.identity]);

  /// Returns a new [FormalParameter] AST as a positional parameter.
  FormalParameter buildPositional([Scope scope = Scope.identity]);

  /// Returns as a new [ParameterBuilder] with a default [expression] value.
  ParameterBuilder toDefault([ExpressionBuilder expression]);

  /// Returns as a new [ParameterBuilder] that assigns to `this.{name}`.
  ParameterBuilder toField();
}

abstract class _AbstractParameterBuilder extends Object
    with HasAnnotationsMixin
    implements ParameterBuilder {
  final String _name;
  final TypeBuilder _type;

  _AbstractParameterBuilder(this._name, this._type);

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildPositional(scope);

  @override
  ParameterBuilder toDefault([ExpressionBuilder expression]) {
    return new _DefaultParameterBuilder(
      this,
      expression,
    );
  }

  @override
  ParameterBuilder toField() {
    final field = new _FieldParameterBuilder(_name, _type);
    field.addAnnotations(getAnnotations());
    return field;
  }
}

class _DefaultParameterBuilder implements ParameterBuilder {
  final _AbstractParameterBuilder _builder;
  final ExpressionBuilder _expression;

  _DefaultParameterBuilder(this._builder, this._expression);

  @override
  void addAnnotation(AnnotationBuilder annotation) {
    _builder.addAnnotation(annotation);
  }

  @override
  void addAnnotations(Iterable<AnnotationBuilder> annotations) {
    _builder.addAnnotations(annotations);
  }

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildPositional(scope);

  @override
  FormalParameter buildNamed([Scope scope = Scope.identity]) {
    return new DefaultFormalParameter(
      _builder.buildPositional(scope),
      ParameterKind.NAMED,
      _expression != null ? $colon : null,
      _expression?.buildExpression(scope),
    );
  }

  @override
  FormalParameter buildPositional([Scope scope = Scope.identity]) {
    return new DefaultFormalParameter(
      _builder.buildPositional(scope),
      ParameterKind.POSITIONAL,
      _expression != null ? $equals : null,
      _expression?.buildExpression(scope),
    );
  }

  @override
  ParameterBuilder toDefault([ExpressionBuilder expression]) {
    return new _DefaultParameterBuilder(_builder, expression);
  }

  @override
  ParameterBuilder toField() {
    return new _DefaultParameterBuilder(_builder.toField(), _expression);
  }
}

class _SimpleParameterBuilder extends _AbstractParameterBuilder {
  _SimpleParameterBuilder(String name, [TypeBuilder type]) : super(name, type);

  @override
  FormalParameter buildPositional([Scope scope = Scope.identity]) {
    return new SimpleFormalParameter(
      null,
      toAnnotationAsts(scope),
      null,
      _type?.buildType(scope),
      new SimpleIdentifier(stringToken(_name)),
    );
  }

  @override
  FormalParameter buildNamed([Scope scope = Scope.identity]) {
    return new DefaultFormalParameter(
      buildPositional(scope),
      ParameterKind.NAMED,
      null,
      null,
    );
  }
}

class _FieldParameterBuilder extends _AbstractParameterBuilder {
  _FieldParameterBuilder(String name, [TypeBuilder type]) : super(name, type);

  @override
  FormalParameter buildPositional([Scope scope = Scope.identity]) {
    return new FieldFormalParameter(
      null,
      toAnnotationAsts(scope),
      null,
      _type?.buildType(scope),
      $this,
      $period,
      new SimpleIdentifier(stringToken(_name)),
      null,
      null,
    );
  }

  @override
  FormalParameter buildNamed([Scope scope = Scope.identity]) {
    return new DefaultFormalParameter(
      buildPositional(scope),
      ParameterKind.NAMED,
      null,
      null,
    );
  }

  @override
  ParameterBuilder toField() {
    final field = new _FieldParameterBuilder(_name, _type);
    field.addAnnotations(getAnnotations());
    return field;
  }
}
