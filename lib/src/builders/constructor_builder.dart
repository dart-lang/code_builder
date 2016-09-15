// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds a [ConstructorDeclaration] AST.
///
/// Similar to [MethodBuilder] but adds constructor-only features.
///
/// Use [ConstructorBuilder.initializeFields] to create something like:
///     class Foo {
///       final _one;
///       final _two;
///
///       Foo(this._one, this._two);
///     }
class ConstructorBuilder extends _AbstractCodeBuilder<ConstructorDeclaration> {
  static final Token _const = new KeywordToken(Keyword.CONST, 0);
  static final Token _this = new KeywordToken(Keyword.THIS, 0);

  /// Create a simple [ConstructorBuilder] that initializes class fields.
  ///
  /// May optionally be [constant] compatible, or have a [name].
  factory ConstructorBuilder.initializeFields(
      {bool constant: false,
      String name,
      Iterable<String> positionalArguments: const [],
      Iterable<String> optionalArguments: const [],
      Iterable<String> namedArguments: const []}) {
    var parameters = <FormalParameter>[];
    for (var a in positionalArguments) {
      parameters.add(new ParameterBuilder(a, field: true).toAst());
    }
    for (var a in optionalArguments) {
      parameters.add(new ParameterBuilder.optional(a, field: true).toAst());
    }
    for (var a in namedArguments) {
      parameters.add(new ParameterBuilder.named(a, field: true).toAst());
    }
    var astNode = new ConstructorDeclaration(
      null,
      null,
      null,
      null,
      constant ? _const : null,
      null,
      null,
      name != null ? _stringId(name) : null,
      MethodBuilder._emptyParameters()..parameters.addAll(parameters),
      null,
      null,
      null,
      new EmptyFunctionBody(MethodBuilder._semicolon),
    );
    return new ConstructorBuilder._(astNode);
  }

  ConstructorBuilder._(ConstructorDeclaration astNode) : super._(astNode);
}
