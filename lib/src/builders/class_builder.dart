// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds a [ClassDeclaration] AST.
class ClassBuilder implements CodeBuilder<ClassDeclaration> {
  static Token _abstract = new KeywordToken(Keyword.ABSTRACT, 0);
  static Token _extends = new KeywordToken(Keyword.EXTENDS, 0);
  static Token _implements = new KeywordToken(Keyword.IMPLEMENTS, 0);
  static Token _with = new KeywordToken(Keyword.WITH, 0);

  final String _name;
  final bool _isAbstract;
  final TypeBuilder _extend;
  final Iterable<TypeBuilder> _implement;
  final Iterable<TypeBuilder> _mixin;

  final List<FieldBuilder> _fields = <FieldBuilder>[];
  final List<MethodBuilder> _methods = <MethodBuilder>[];
  final List<AnnotationBuilder> _metadata = <AnnotationBuilder>[];
  final List<ConstructorBuilder> _constructors = <ConstructorBuilder>[];

  /// Create a new builder for a `class` named [name].
  ///
  /// Optionally, define another class to [extend] or classes to either
  /// [implement] or [mixin]. You may also define a `class` as [abstract].
  factory ClassBuilder(
    String name, {
    TypeBuilder extend,
    Iterable<TypeBuilder> implement: const [],
    Iterable<TypeBuilder> mixin: const [],
  }) =>
      new ClassBuilder._(
        name,
        false,
        extend,
        new List<TypeBuilder>.unmodifiable(implement),
        new List<TypeBuilder>.unmodifiable(mixin),
      );

  factory ClassBuilder.asAbstract(String name,
          {TypeBuilder extend,
          Iterable<TypeBuilder> implement: const [],
          Iterable<TypeBuilder> mixin: const []}) =>
      new ClassBuilder._(
        name,
        true,
        extend,
        new List<TypeBuilder>.unmodifiable(implement),
        new List<TypeBuilder>.unmodifiable(mixin),
      );

  ClassBuilder._(
    this._name,
    this._isAbstract,
    this._extend,
    this._implement,
    this._mixin,
  );

  /// Adds an annotation [builder] as metadata.
  void addAnnotation(AnnotationBuilder builder) {
    _metadata.add(builder);
  }

  /// Adds a constructor [builder].
  void addConstructor(ConstructorBuilder builder) {
    _constructors.add(builder);
  }

  /// Adds a field [builder] as a member on the class.
  void addField(FieldBuilder builder) {
    _fields.add(builder);
  }

  /// Adds a method [builder] as a member on the class.
  void addMethod(MethodBuilder builder) {
    _methods.add(builder);
  }

  @override
  ClassDeclaration toAst([Scope scope = const Scope.identity()]) {
    var astNode = _emptyClassDeclaration()..name = _stringIdentifier(_name);
    if (_isAbstract) {
      astNode.abstractKeyword = _abstract;
    }
    if (_extend != null) {
      astNode.extendsClause = new ExtendsClause(_extends, _extend.toAst(scope));
    }
    if (_implement.isNotEmpty) {
      astNode.implementsClause = new ImplementsClause(_implements,
          _implement.map/*<TypeName>*/((i) => i.toAst(scope)).toList());
    }
    if (_mixin.isNotEmpty) {
      astNode.withClause = new WithClause(
          _with, _mixin.map/*<TypeName>*/((i) => i.toAst(scope)).toList());
    }
    astNode
      ..metadata.addAll(_metadata.map/*<Annotation>*/((a) => a.toAst(scope)));
    astNode
      ..members.addAll(_fields.map/*<ClassMember>*/((f) => f.toFieldAst(scope)))
      ..members.addAll(_constructors.map/*<ClassMember>*/(
          (c) => c.toAst(scope)..returnType = _stringIdentifier(_name)))
      ..members
          .addAll(_methods.map/*<ClassMember>*/((m) => m.toMethodAst(scope)));
    return astNode;
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
