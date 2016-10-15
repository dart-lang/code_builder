import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/shared.dart';

/// Creates a reference called [name].
ReferenceBuilder reference(String name, [String importUri]) {
  return new ReferenceBuilder._(name);
}

/// An abstract way of representing other types of [AstBuilder].
class ReferenceBuilder implements AnnotationBuilder {
  final String _name;

  ReferenceBuilder._(this._name);

  @override
  Annotation buildAnnotation([Scope scope]) {
    return new Annotation(

    );
  }

  @override
  AstNode buildAst([Scope scope]) => throw new UnimplementedError();
}
