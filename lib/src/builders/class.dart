import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/shared.dart';

/// A more short-hand way of constructing a [ClassBuilder].
ClassBuilder clazz(
  String name, [
  Iterable<ValidClassMember> members = const [],
]) {
  final clazz = new ClassBuilder(name);
  for (final member in members) {
    if (member is AnnotationBuilder) {
      clazz.addAnnotation(member);
    } else {
      throw new StateError('Invalid AST type: ${member.runtimeType}');
    }
  }
  return clazz;
}

/// Lazily builds an [ClassDeclaration] AST when [buildClass] is invoked.
abstract class ClassBuilder
    implements AstBuilder<ClassDeclaration>, HasAnnotations {
  /// Returns a new [ClassBuilder] with [name].
  factory ClassBuilder(String name) = _ClassBuilderImpl;

  /// Returns an [ClassDeclaration] AST representing the builder.
  ClassDeclaration buildClass([Scope scope]);
}

/// A marker interface for an AST that could be added to [ClassBuilder].
abstract class ValidClassMember implements AstBuilder {}

class _ClassBuilderImpl extends Object
    with HasAnnotationsMixin
    implements ClassBuilder {
  final String _name;

  _ClassBuilderImpl(this._name);

  @override
  ClassDeclaration buildAst([Scope scope]) => buildClass(scope);

  @override
  ClassDeclaration buildClass([Scope scope]) {
    return new ClassDeclaration(
      null,
      buildAnnotations(scope),
      null,
      null,
      stringIdentifier(_name),
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    );
  }
}
