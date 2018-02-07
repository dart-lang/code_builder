// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
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

part 'class.g.dart';

@immutable
abstract class Class extends Object
    with HasAnnotations, HasDartDocs, HasGenerics
    implements Built<Class, ClassBuilder>, Spec {
  factory Class([void updates(ClassBuilder b)]) = _$Class;

  Class._();

  /// Whether the class is `abstract`.
  bool get abstract;

  @override
  BuiltList<Expression> get annotations;

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
  R accept<R>(
    SpecVisitor<R> visitor, [
    R context,
  ]) =>
      visitor.visitClass(this, context);
}

abstract class ClassBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder, HasGenericsBuilder
    implements Builder<Class, ClassBuilder> {
  factory ClassBuilder() = _$ClassBuilder;

  ClassBuilder._();

  /// Whether the class is `abstract`.
  bool abstract = false;

  @override
  ListBuilder<Expression> annotations = new ListBuilder<Expression>();

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
}
