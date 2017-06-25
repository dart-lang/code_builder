// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.class_;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/dartdoc.dart';
import '../mixins/generics.dart';
import '../visitors.dart';
import 'constructor.dart';
import 'method.dart';
import 'type_reference.dart';

part 'class.g.dart';

@immutable
abstract class Class extends Object
    with HasDartDocs, HasGenerics
    implements Built<Class, ClassBuilder>, TypeReference, Spec {
  factory Class([void updates(ClassBuilder b)]) = _$Class;

  Class._();

  /// Whether the class is `abstract`.
  bool get abstract;

  @override
  BuiltList<String> get docs;

  @nullable
  TypeReference get extend;

  BuiltList<TypeReference> get implements;

  BuiltList<TypeReference> get mixins;

  @override
  BuiltList<TypeReference> get types;

  BuiltList<Constructor> get constructors;

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
    with HasDartDocsBuilder, HasGenericsBuilder
    implements Builder<Class, ClassBuilder>, TypeReferenceBuilder {
  factory ClassBuilder() = _$ClassBuilder;

  ClassBuilder._();

  /// Whether the class is `abstract`.
  bool abstract = false;

  @override
  ListBuilder<String> docs = new ListBuilder<String>();

  TypeReference extend;

  ListBuilder<TypeReference> implements = new ListBuilder<TypeReference>();
  ListBuilder<TypeReference> mixins = new ListBuilder<TypeReference>();

  @override
  ListBuilder<TypeReference> types = new ListBuilder<TypeReference>();

  ListBuilder<Constructor> constructors = new ListBuilder<Constructor>();
  ListBuilder<Method> methods = new ListBuilder<Method>();

  /// Name of the class.
  String name;

  @override
  TypeReference get bound => null;

  @override
  set bound(TypeReference bound) => throw new UnsupportedError('');

  @override
  String get url => null;

  @override
  set url(String url) => throw new UnsupportedError('');

  @override
  set symbol(String symbol) => name = symbol;

  @override
  String get symbol => name;
}
