// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
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
import 'reference.dart';

part 'typedef.g.dart';

@immutable
abstract class TypeDef extends Object
    with HasAnnotations, HasDartDocs, HasGenerics
    implements Built<TypeDef, TypeDefBuilder>, Spec {
  factory TypeDef([void Function(TypeDefBuilder)? updates]) = _$TypeDef;

  TypeDef._();

  /// Name of the typedef.
  String get name;

  /// The right hand side of the typedef.
  ///
  /// Typically a reference to a type, or a Function type.
  Expression get definition;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R? context,
  ]) =>
      visitor.visitTypeDef(this, context);
}

abstract class TypeDefBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder, HasGenericsBuilder
    implements Builder<TypeDef, TypeDefBuilder> {
  factory TypeDefBuilder() = _$TypeDefBuilder;

  TypeDefBuilder._();

  @override
  ListBuilder<Expression> annotations = ListBuilder<Expression>();

  @override
  ListBuilder<String> docs = ListBuilder<String>();

  @override
  ListBuilder<Reference> types = ListBuilder<Reference>();

  String? name;

  Expression? definition;
}
