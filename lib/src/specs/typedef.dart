// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/annotations.dart';
import '../mixins/dartdoc.dart';
import '../visitors.dart';
import 'expression.dart';

part 'typedef.g.dart';

@immutable
abstract class TypeDef extends Object
    with HasAnnotations, HasDartDocs
    implements Built<TypeDef, TypeDefBuilder>, Spec {
  factory TypeDef([void Function(TypeDefBuilder)? updates]) = _$TypeDef;

  TypeDef._();

  /// Name of the typedef.
  String get name;

  Expression get definition;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R? context,
  ]) =>
      visitor.visitTypeDef(this, context);
}

abstract class TypeDefBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder
    implements Builder<TypeDef, TypeDefBuilder> {
  factory TypeDefBuilder() = _$TypeDefBuilder;

  TypeDefBuilder._();

  @override
  ListBuilder<Expression> annotations = ListBuilder<Expression>();

  @override
  ListBuilder<String> docs = ListBuilder<String>();

  /// Name of the field.
  String? name;

  Expression? definition;
}
