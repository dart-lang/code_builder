// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.method;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/annotations.dart';
import '../mixins/dartdoc.dart';
import '../mixins/generics.dart';
import '../visitors.dart';
import 'annotation.dart';
import 'code.dart';
import 'reference.dart';
import 'type_reference.dart';

part 'method.g.dart';

final TypeReference _$void = const Reference.localScope('void').toType();

@immutable
abstract class Method extends Object
    with HasAnnotations, HasGenerics, HasDartDocs
    implements Built<Method, MethodBuilder>, Reference, Spec {
  factory Method([void updates(MethodBuilder b)]) = _$Method;

  factory Method.returnsVoid([void updates(MethodBuilder b)]) {
    return new Method((b) {
      if (updates != null) {
        updates(b);
      }
      b.returns = _$void;
    });
  }

  Method._();

  @override
  BuiltList<Annotation> get annotations;

  @override
  BuiltList<String> get docs;

  @override
  BuiltList<TypeReference> get types;

  /// Optional parameters.
  BuiltList<Parameter> get optionalParameters;

  /// Required parameters.
  BuiltList<Parameter> get requiredParameters;

  /// Body of the method.
  @nullable
  Code get body;

  /// Whether the method should be prefixed with `external`.
  bool get external;

  /// Whether this method is a simple lambda expression.
  bool get lambda;

  /// Whether this method should be prefixed with `static`.
  ///
  /// This is only valid within classes.
  bool get static;

  /// Name of the method or function.
  String get name;

  /// Whether this is a getter or setter.
  @nullable
  MethodType get type;

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
    with HasAnnotationsBuilder, HasGenericsBuilder, HasDartDocsBuilder
    implements Builder<Method, MethodBuilder> {
  factory MethodBuilder() = _$MethodBuilder;

  MethodBuilder._();

  @override
  ListBuilder<Annotation> annotations = new ListBuilder<Annotation>();

  @override
  ListBuilder<String> docs = new ListBuilder<String>();

  @override
  ListBuilder<TypeReference> types = new ListBuilder<TypeReference>();

  /// Optional parameters.
  ListBuilder<Parameter> optionalParameters = new ListBuilder<Parameter>();

  /// Required parameters.
  ListBuilder<Parameter> requiredParameters = new ListBuilder<Parameter>();

  /// Body of the method.
  Code body;

  /// Whether the method should be prefixed with `external`.
  bool external = false;

  /// Whether this method is a simple lambda expression.
  bool lambda = false;

  /// Whether this method should be prefixed with `static`.
  ///
  /// This is only valid within classes.
  bool static = false;

  /// Name of the method or function.
  String name;

  /// Whether this is a getter or setter.
  MethodType type;

  TypeReference returns;
}

enum MethodType {
  getter,
  setter,
}

abstract class Parameter extends Object
    with HasAnnotations, HasGenerics, HasDartDocs
    implements Built<Parameter, ParameterBuilder> {
  factory Parameter([void updates(ParameterBuilder b)]) = _$Parameter;

  Parameter._();

  /// If not `null`, a default assignment if the parameter is optional.
  @nullable
  Code get defaultTo;

  /// Name of the parameter.
  String get name;

  /// Whether this parameter should be named, if optional.
  bool get named;

  /// Whether this parameter should be field formal (i.e. `this.`).
  ///
  /// This is only valid on constructors;
  bool get toThis;

  @override
  BuiltList<Annotation> get annotations;

  @override
  BuiltList<String> get docs;

  @override
  BuiltList<TypeReference> get types;

  /// Type of the parameter;
  @nullable
  TypeReference get type;
}

abstract class ParameterBuilder extends Object
    with HasAnnotationsBuilder, HasGenericsBuilder, HasDartDocsBuilder
    implements Builder<Parameter, ParameterBuilder> {
  factory ParameterBuilder() = _$ParameterBuilder;

  ParameterBuilder._();

  /// If not `null`, a default assignment if the parameter is optional.
  Code defaultTo;

  /// Name of the parameter.
  String name;

  /// Whether this parameter should be named, if optional.
  bool named = false;

  /// Whether this parameter should be field formal (i.e. `this.`).
  ///
  /// This is only valid on constructors;
  bool toThis = false;

  @override
  ListBuilder<Annotation> annotations = new ListBuilder<Annotation>();

  @override
  ListBuilder<String> docs = new ListBuilder<String>();

  @override
  ListBuilder<TypeReference> types = new ListBuilder<TypeReference>();

  /// Type of the parameter;
  TypeReference type;
}
