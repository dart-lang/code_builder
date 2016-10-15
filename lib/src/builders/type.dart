import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/tokens.dart';

/// Returns a new [TypeBuilder].
///
/// Shorthand for `new TypeBuilder` for more functional aficionados.
TypeBuilder type(String identifier, [String importFrom]) {
  return new TypeBuilder(identifier, importFrom: importFrom);
}

/// Builds an [TypeName] AST.
class TypeBuilder implements AstBuilder, ValidParameterMember {
  final List<TypeBuilder> _generics = <TypeBuilder>[];
  final String _identifier;
  final String _importFrom;

  /// Create a new [TypeBuilder] from an identifier.
  ///
  /// Optionally specify where the reference should be [importFrom].
  TypeBuilder(
    this._identifier, {
    String importFrom,
  })
      : _importFrom = importFrom;

  /// Adds a generic [type] parameter.
  void addGeneric(TypeBuilder type) {
    _generics.add(type);
  }

  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildType(scope);

  /// Returns a new [TypeName] AST.
  TypeName buildType([Scope scope = Scope.identity]) {
    return new TypeName(
      scope.getIdentifier(_identifier, _importFrom),
      _generics.isEmpty
          ? null
          : new TypeArgumentList(
              $lt,
              _generics.map/*<TypeName>*/((g) => g.buildType(scope)).toList(),
              $gt,
            ),
    );
  }
}
