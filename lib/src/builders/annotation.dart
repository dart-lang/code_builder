import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/builders/shared.dart';

/// Returns a new [AnnotationBuilder] referencing [identifier].
AnnotationBuilder annotation(String identifier, [String importFrom]) {
  return reference(identifier, importFrom);
}

/// Builds an [Annotation] AST.
abstract class AnnotationBuilder implements AstBuilder, ValidParameterMember {
  /// Returns as an [Annotation] AST.
  Annotation buildAnnotation([Scope scope = Scope.identity]);
}
