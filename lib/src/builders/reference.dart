import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart' show Scope;
import 'package:code_builder/src/tokens.dart';

import 'annotation.dart';
import 'expression.dart';
import 'type.dart';

/// Create a reference to [identifier], optionally where to [importFrom].
ReferenceBuilder reference(String identifier, [String importFrom]) {
  return new ReferenceBuilder._(identifier, importFrom);
}

/// A reference to a type, field, variable, etc.
///
/// [ReferenceBuilder] does _not_ emit an AST itself, but rather is a
/// convenience builder for creating other forms of ASTs.
class ReferenceBuilder extends ExpressionBuilderMixin
    implements AnnotationBuilder, TypeBuilder {
  final String _identifier;
  final String _importFrom;

  ReferenceBuilder._(this._identifier, [this._importFrom]);

  @override
  void addGeneric(TypeBuilder type) {
    throw new UnsupportedError('Use type() to be able to add generics');
  }

  @override
  Annotation buildAnnotation([Scope scope = Scope.identity]) {
    return new Annotation(
      $at,
      buildExpression(scope),
      null,
      null,
      null,
    );
  }

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope = Scope.identity]) {
    return scope.getIdentifier(_identifier, _importFrom);
  }

  @override
  TypeName buildType([Scope scope = Scope.identity]) {
    return generic().buildType(scope);
  }

  /// Returns converted to a [TypeBuilder].
  TypeBuilder generic([Iterable<TypeBuilder> generics = const []]) {
    final type = new TypeBuilder(_identifier, importFrom: _importFrom);
    generics.forEach(type.addGeneric);
    return type;
  }
}
