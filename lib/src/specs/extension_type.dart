// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/annotations.dart';
import '../mixins/dartdoc.dart';
import '../mixins/generics.dart';
import '../visitors.dart';
import 'constructor.dart';
import 'expression.dart';
import 'field.dart';
import 'method.dart';
import 'reference.dart';

part 'extension_type.g.dart';

@immutable
abstract class ExtensionType extends Object
    with HasAnnotations, HasDartDocs, HasGenerics
    implements Built<ExtensionType, ExtensionTypeBuilder>, Spec {
  factory ExtensionType([void Function(ExtensionTypeBuilder)? updates]) =
      _$ExtensionType;

  ExtensionType._();

  @override
  BuiltList<Expression> get annotations;

  @override
  BuiltList<String> get docs;

  /// Whether this extension type is declared as `const`.
  bool get constant;

  String get name;

  @override
  BuiltList<Reference> get types;

  /// Name of the extension type's primary constructor. An empty string
  /// will make it unnamed.
  String get primaryConstructorName;

  RepresentationDeclaration get representationDeclaration;

  BuiltList<Reference> get implements;

  BuiltList<Constructor> get constructors;

  BuiltList<Field> get fields;

  BuiltList<Method> get methods;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R? context,
  ]) =>
      visitor.visitExtensionType(this, context);
}

abstract class ExtensionTypeBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder, HasGenericsBuilder
    implements Builder<ExtensionType, ExtensionTypeBuilder> {
  factory ExtensionTypeBuilder() = _$ExtensionTypeBuilder;

  ExtensionTypeBuilder._();

  @override
  void update(void Function(ExtensionTypeBuilder)? updates) {
    updates?.call(this);
  }

  @override
  ListBuilder<Expression> annotations = ListBuilder<Expression>();

  @override
  ListBuilder<String> docs = ListBuilder<String>();

  /// Whether this extension type is declared as `const`.
  bool constant = false;

  String? name;

  @override
  ListBuilder<Reference> types = ListBuilder<Reference>();

  /// Name of the extension type's primary constructor. An empty string
  /// will make it unnamed.
  String primaryConstructorName = '';

  RepresentationDeclaration? representationDeclaration;

  ListBuilder<Reference> implements = ListBuilder<Reference>();

  ListBuilder<Constructor> constructors = ListBuilder<Constructor>();

  ListBuilder<Field> fields = ListBuilder<Field>();

  ListBuilder<Method> methods = ListBuilder<Method>();
}

abstract class RepresentationDeclaration extends Object
    with HasAnnotations, HasDartDocs
    implements
        Built<RepresentationDeclaration, RepresentationDeclarationBuilder> {
  factory RepresentationDeclaration(
          [void Function(RepresentationDeclarationBuilder)? updates]) =
      _$RepresentationDeclaration;

  RepresentationDeclaration._();

  @override
  BuiltList<Expression> get annotations;

  @override
  BuiltList<String> get docs;

  Reference get declaredRepresentationType;

  String get name;
}

abstract class RepresentationDeclarationBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder
    implements
        Builder<RepresentationDeclaration, RepresentationDeclarationBuilder> {
  factory RepresentationDeclarationBuilder() =
      _$RepresentationDeclarationBuilder;

  RepresentationDeclarationBuilder._();

  @override
  void update(void Function(RepresentationDeclarationBuilder)? updates) {
    updates?.call(this);
  }

  @override
  ListBuilder<Expression> annotations = ListBuilder<Expression>();

  @override
  ListBuilder<String> docs = ListBuilder<String>();

  Reference? declaredRepresentationType;

  String? name;
}
