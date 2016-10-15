library code_builder.src.builders.clazz;

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/tokens.dart';

part 'class/constructor.dart';

/// Returns a new [ClassBuilder].
///
/// Shorthand for `new ClassBuilder` for more functional aficionados.
ClassBuilder clazz(String name, [Iterable<AstBuilder> members = const []]) {
  final clazz = new ClassBuilder(name);
  for (final member in members) {
    if (member is AnnotationBuilder) {
      clazz.addAnnotation(member);
    }
  }
  return clazz;
}

/// Builds a [ClassDeclaration] AST.
class ClassBuilder implements AstBuilder {
  final List<AnnotationBuilder> _annotations = <AnnotationBuilder>[];
  final String _name;

  /// Create a new `class`.
  ClassBuilder(this._name);

  /// Adds [annotation].
  void addAnnotation(AnnotationBuilder annotation) {
    _annotations.add(annotation);
  }

  @override
  AstNode buildAst([Scope scope = Scope.identity]) {
    return new ClassDeclaration(
      null,
      _annotations
          .map/*<Annotation>*/((a) => a.buildAnnotation(scope))
          .toList(),
      null,
      $class,
      new SimpleIdentifier(stringToken(_name)),
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
