// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../visitors.dart';
import 'expression.dart';
import 'reference.dart';

part 'type_record.g.dart';

@immutable
abstract class RecordType extends Expression
    implements Built<RecordType, RecordTypeBuilder>, Reference, Spec {
  factory RecordType([
    void Function(RecordTypeBuilder) updates,
  ]) = _$RecordType;

  RecordType._();

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R? context,
  ]) =>
      visitor.visitRecordType(this, context);

  BuiltList<Reference> get positionalFieldTypes;

  BuiltMap<String, Reference> get namedFieldTypes;

  @override
  String? get url => null;

  @override
  String? get symbol => null;

  @override
  Reference get type => this;

  /// Optional nullability.
  bool? get isNullable;

  @override
  Expression newInstance(
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) =>
      throw UnsupportedError('Cannot instantiate a record type.');

  @override
  Expression newInstanceNamed(
    String name,
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) =>
      throw UnsupportedError('Cannot instantiate a record type.');

  @override
  Expression constInstance(
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) =>
      throw UnsupportedError('Cannot "const" a record type.');

  @override
  Expression constInstanceNamed(
    String name,
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) =>
      throw UnsupportedError('Cannot "const" a record type.');
}

abstract class RecordTypeBuilder extends Object
    implements Builder<RecordType, RecordTypeBuilder> {
  factory RecordTypeBuilder() = _$RecordTypeBuilder;

  RecordTypeBuilder._();

  ListBuilder<Reference> positionalFieldTypes = ListBuilder<Reference>();

  MapBuilder<String, Reference> namedFieldTypes =
      MapBuilder<String, Reference>();

  bool? isNullable;

  String? url;

  String? symbol;
}
