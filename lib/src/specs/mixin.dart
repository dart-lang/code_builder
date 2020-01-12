// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
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
import 'expression.dart';
import 'method.dart';
import 'reference.dart';

part 'mixin.g.dart';

@immutable
abstract class Mixin extends Object
    with HasAnnotations, HasDartDocs, HasGenerics
    implements Built<Mixin, MixinBuilder>, Spec {
  factory Mixin([void updates(MixinBuilder b)]) = _$Mixin;

  Mixin._();

  @override
  BuiltList<Expression> get annotations;

  @override
  BuiltList<String> get docs;

  @nullable
  Reference get on;

  BuiltList<Reference> get implements;

  @override
  BuiltList<Reference> get types;

  BuiltList<Method> get methods;

  /// Name of the mixin.
  String get name;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R context,
  ]) {
    return visitor.visitMixin(this, context);
  }
}

abstract class MixinBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder, HasGenericsBuilder
    implements Builder<Mixin, MixinBuilder> {
  factory MixinBuilder() = _$MixinBuilder;

  MixinBuilder._();

  @override
  ListBuilder<Expression> annotations = ListBuilder<Expression>();

  @override
  ListBuilder<String> docs = ListBuilder<String>();

  Reference on;

  ListBuilder<Reference> implements = ListBuilder<Reference>();

  @override
  ListBuilder<Reference> types = ListBuilder<Reference>();

  ListBuilder<Method> methods = ListBuilder<Method>();

  /// Name of the mixin.
  String name;
}
