// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.class_;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/annotations.dart';
import '../mixins/dartdoc.dart';
import '../mixins/generics.dart';
import '../visitors.dart';
import 'annotation.dart';
import 'constructor.dart';
import 'field.dart';
import 'method.dart';
import 'reference.dart';
import 'type_reference.dart';

part 'class.g.dart';

@immutable
abstract class Class extends Object
    with HasAnnotations, HasDartDocs, HasGenerics
    implements Built<Class, ClassBuilder>, TypeReference, Spec {
  factory Class([void updates(ClassBuilder b)]) = _$Class;

  Class._();

  /// Whether the class is `abstract`.
  bool get abstract;

  @override
  BuiltList<Annotation> get annotations;

  @override
  BuiltList<String> get docs;

  @nullable
  Reference get extend;

  BuiltList<Reference> get implements;

  BuiltList<Reference> get mixins;

  @override
  BuiltList<Reference> get types;

  BuiltList<Constructor> get constructors;
  BuiltList<Method> get methods;
  BuiltList<Field> get fields;

  /// Name of the class.
  String get name;

  @override
  TypeReference get bound => null;

  @override
  String get url => null;

  @override
  String get symbol => name;

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitClass(this);

  @override
  TypeReference toType() => this;
}

abstract class ClassBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder, HasGenericsBuilder
    implements Builder<Class, ClassBuilder>, TypeReferenceBuilder {
  factory ClassBuilder() = _$ClassBuilder;

  ClassBuilder._();

  /// Whether the class is `abstract`.
  bool abstract = false;

  @override
  ListBuilder<Annotation> annotations = new ListBuilder<Annotation>();

  @override
  ListBuilder<String> docs = new ListBuilder<String>();

  Reference extend;

  ListBuilder<Reference> implements = new ListBuilder<Reference>();
  ListBuilder<Reference> mixins = new ListBuilder<Reference>();

  @override
  ListBuilder<Reference> types = new ListBuilder<Reference>();

  ListBuilder<Constructor> constructors = new ListBuilder<Constructor>();
  ListBuilder<Method> methods = new ListBuilder<Method>();
  ListBuilder<Field> fields = new ListBuilder<Field>();

  /// Name of the class.
  String name;

  @override
  Reference get bound => null;

  @override
  set bound(Reference bound) => throw new UnsupportedError('');

  @override
  String get url => null;

  @override
  set url(String url) => throw new UnsupportedError('');

  @override
  set symbol(String symbol) => name = symbol;

  @override
  String get symbol => name;
}
