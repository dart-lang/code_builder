// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../../code_builder.dart';
import '../mixins/annotations.dart';
import '../mixins/dartdoc.dart';
import '../mixins/generics.dart';
import '../visitors.dart';

part 'enum.g.dart';

@immutable
abstract class Enum extends Object
    with HasAnnotations, HasDartDocs, HasGenerics
    implements Built<Enum, EnumBuilder>, Spec {
  factory Enum([void Function(EnumBuilder) updates]) = _$Enum;

  Enum._();

  String get name;

  BuiltList<EnumValue> get values;

  @override
  BuiltList<Expression> get annotations;

  @override
  BuiltList<String> get docs;

  BuiltList<Reference> get implements;

  BuiltList<Reference> get mixins;

  @override
  BuiltList<Reference> get types;

  BuiltList<Constructor> get constructors;
  BuiltList<Method> get methods;
  BuiltList<Field> get fields;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R? context,
  ]) =>
      visitor.visitEnum(this, context);
}

abstract class EnumBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder, HasGenericsBuilder
    implements Builder<Enum, EnumBuilder> {
  factory EnumBuilder() = _$EnumBuilder;

  EnumBuilder._();

  String? name;

  ListBuilder<EnumValue> values = ListBuilder<EnumValue>();

  @override
  ListBuilder<Expression> annotations = ListBuilder<Expression>();

  @override
  ListBuilder<String> docs = ListBuilder<String>();

  ListBuilder<Reference> implements = ListBuilder<Reference>();
  ListBuilder<Reference> mixins = ListBuilder<Reference>();

  @override
  ListBuilder<Reference> types = ListBuilder<Reference>();

  ListBuilder<Constructor> constructors = ListBuilder<Constructor>();
  ListBuilder<Method> methods = ListBuilder<Method>();
  ListBuilder<Field> fields = ListBuilder<Field>();
}

@immutable
abstract class EnumValue extends Object
    with HasAnnotations, HasDartDocs, HasGenerics
    implements Built<EnumValue, EnumValueBuilder> {
  factory EnumValue([void Function(EnumValueBuilder) updates]) = _$EnumValue;

  EnumValue._();

  String get name;

  @override
  BuiltList<Expression> get annotations;

  @override
  BuiltList<String> get docs;

  /// The name of the constructor to target.
  ///
  /// If `null` uses the unnamed constructor.
  String? get constructorName;

  @override
  BuiltList<Reference> get types;

  /// Arguments to the constructor.
  BuiltList<Expression> get arguments;
}

abstract class EnumValueBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder, HasGenericsBuilder
    implements Builder<EnumValue, EnumValueBuilder> {
  factory EnumValueBuilder() = _$EnumValueBuilder;

  EnumValueBuilder._();

  String? name;

  @override
  ListBuilder<Expression> annotations = ListBuilder<Expression>();

  @override
  ListBuilder<String> docs = ListBuilder<String>();

  /// The name of the constructor to target.
  String? constructorName;

  @override
  ListBuilder<Reference> types = ListBuilder<Reference>();

  /// Arguments to the constructor.
  ListBuilder<Expression> arguments = ListBuilder();
}
