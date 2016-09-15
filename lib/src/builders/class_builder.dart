// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds a [ClassDeclaration] AST.
class ClassBuilder extends _AbstractCodeBuilder<ClassDeclaration> {
  static Token _abstract = new KeywordToken(Keyword.ABSTRACT, 0);
  static Token _extends = new KeywordToken(Keyword.EXTENDS, 0);
  static Token _implements = new KeywordToken(Keyword.IMPLEMENTS, 0);
  static Token _with = new KeywordToken(Keyword.WITH, 0);

  /// Create a new builder for a `class` named [name].
  ///
  /// Optionally, define another class to [extend] or classes to either
  /// [implement] or [mixin]. You may also define a `class` as [abstract].
  factory ClassBuilder(
    String name, {
    bool abstract: false,
    String extend,
    Iterable<String> implement: const [],
    Iterable<String> mixin: const [],
  }) {
    var astNode = _emptyClassDeclaration()..name = _stringId(name);
    if (abstract) {
      astNode.abstractKeyword = _abstract;
    }
    if (extend != null) {
      astNode.extendsClause = new ExtendsClause(
          _extends,
          new TypeName(
            _stringId(extend),
            null,
          ));
    }
    if (implement.isNotEmpty) {
      astNode.implementsClause = new ImplementsClause(
          _implements,
          implement
              .map/*<TypeName>*/((i) => new TypeName(_stringId(i), null))
              .toList());
    }
    if (mixin.isNotEmpty) {
      astNode.withClause = new WithClause(
          _with,
          mixin
              .map/*<TypeName>*/((i) => new TypeName(_stringId(i), null))
              .toList());
    }
    return new ClassBuilder._(astNode);
  }

  ClassBuilder._(ClassDeclaration astNode) : super._(astNode);

  /// Adds an annotation [builder] as metadata.
  void addAnnotation(AnnotationBuilder builder) {
    _astNode.metadata.add(builder.toAst());
  }

  /// Adds a constructor [builder].
  void addConstructor(ConstructorBuilder builder) {
    var astNode = builder.toAst();
    if (astNode.returnType == null) {
      astNode.returnType = _astNode.name;
    }
    _astNode.members.add(astNode);
  }

  /// Adds a field [builder] as a member on the class.
  void addField(FieldBuilder builder, {bool static: false}) {
    _astNode.members.add(builder.toFieldAst(static: static));
  }

  /// Adds a method [builder] as a member on the class.
  void addMethod(MethodBuilder builder, {bool static: false}) {
    _astNode.members.add(builder.toMethodAst(
      static: static,
      canBeAbstract: _astNode.abstractKeyword != null,
    ));
  }

  static ClassDeclaration _emptyClassDeclaration() => new ClassDeclaration(
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      );
}
