// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.method;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/dartdoc.dart';
import '../mixins/generics.dart';
import '../visitors.dart';
import 'code.dart';
import 'reference.dart';
import 'type_reference.dart';

part 'method.g.dart';

@immutable
abstract class Method extends Object
    with HasGenerics, HasDartDocs
    implements Built<Method, MethodBuilder>, Reference, Spec {
  factory Method([void updates(MethodBuilder b)]) = _$Method;

  Method._();

  @override
  BuiltList<String> get docs;

  @override
  BuiltList<TypeReference> get types;

  /// Body of the method.
  @nullable
  Code get body;

  /// Whether the method should be prefixed with `external`.
  bool get external;

  /// Whether this method is a simple lambda expression.
  bool get lambda;

  /// Name of the method or function.
  String get name;

  @nullable
  TypeReference get returns;

  @override
  String get symbol => name;

  @override
  String get url => null;

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitMethod(this);

  @override
  TypeReference toType() => throw new UnsupportedError('');
}

abstract class MethodBuilder extends Object
    with HasGenericsBuilder, HasDartDocsBuilder
    implements Builder<Method, MethodBuilder> {
  factory MethodBuilder() = _$MethodBuilder;

  MethodBuilder._();

  @override
  ListBuilder<String> docs = new ListBuilder<String>();

  @override
  ListBuilder<TypeReference> types = new ListBuilder<TypeReference>();

  /// Body of the method.
  Code body;

  /// Whether the method should be prefixed with `external`.
  bool external = false;

  /// Whether this method is a simple lambda expression.
  bool lambda = false;

  /// Name of the method or function.
  String name;

  TypeReference returns;
}
