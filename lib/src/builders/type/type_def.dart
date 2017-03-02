// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.type;

TypeParameterList typeParameters(Scope scope, Map<String, TypeBuilder> types) {
  if (types.isEmpty) {
    return null;
  }
  return astFactory.typeParameterList(
    $openBracket,
    types.keys.map((name) {
      final type = types[name];
      return astFactory.typeParameter(
        null,
        null,
        stringIdentifier(name),
        type != null ? $extends : null,
        type?.buildType(scope),
      );
    }).toList(),
    $closeBracket,
  );
}

/// Lazily build a `typedef`, or [FunctionTypeAlias] AST.
///
///
class TypeDefBuilder extends AstBuilder<FunctionTypeAlias>
    with HasAnnotationsMixin, HasParametersMixin, TopLevelMixin {
  /// Optional generic type parameters.
  final Map<String, TypeBuilder> genericTypes;

  /// Name of the `typedef`.
  final String name;

  /// Return type; if `null` defaults to implicitly dynamic.
  final TypeBuilder returnType;

  TypeDefBuilder(
    this.name, {
    this.genericTypes: const {},
    this.returnType,
  });

  @override
  FunctionTypeAlias buildAst([Scope scope]) {
    return astFactory.functionTypeAlias(
      null,
      buildAnnotations(scope),
      null,
      returnType?.buildType(scope),
      stringIdentifier(name),
      typeParameters(scope, genericTypes),
      buildParameterList(scope),
      $semicolon,
    );
  }

  @override
  CompilationUnitMember buildTopLevelAst([Scope scope]) => buildAst(scope);
}
