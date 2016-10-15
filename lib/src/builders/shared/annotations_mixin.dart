import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';

/// A builder that supports adding annotations as metadata.
abstract class HasAnnotations {
  /// Lazily adds [annotation] as a builder.
  ///
  /// When the AST is built, [AnnotationBuilder.buildAnnotation] is invoked.
  void addAnnotation(AnnotationBuilder annotation);

  /// Lazily adds [annotations] as builders.
  ///
  /// When the AST is built, [AnnotationBuilder.buildAnnotation] is invoked.
  void addAnnotations(Iterable<AnnotationBuilder> annotations);
}

/// A mixin to add [addAnnotation] and [getAnnotations] to a builder.
abstract class HasAnnotationsMixin implements HasAnnotations {
  final List<AnnotationBuilder> _annotations = <AnnotationBuilder>[];

  @override
  void addAnnotation(AnnotationBuilder annotation) {
    _annotations.add(annotation);
  }

  @override
  void addAnnotations(Iterable<AnnotationBuilder> annotations) {
    _annotations.addAll(annotations);
  }

  /// Returns all annotations added by [addAnnotation].
  List<AnnotationBuilder> getAnnotations() {
    return new List<AnnotationBuilder>.unmodifiable(_annotations);
  }

  /// Returns a built list of [Annotation] ASTs.
  List<Annotation> toAnnotationAsts([Scope scope = Scope.identity]) {
    return _annotations
        .map/*<Annotation>*/((a) => a.buildAnnotation(scope))
        .toList();
  }
}
