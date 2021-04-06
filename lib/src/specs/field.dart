// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// @dart=2.12

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/annotations.dart';
import '../mixins/dartdoc.dart';
import '../visitors.dart';
import 'code.dart';
import 'expression.dart';
import 'reference.dart';

part 'field.g.dart';

@immutable
abstract class Field extends Object
    with HasAnnotations, HasDartDocs
    implements Built<Field, FieldBuilder>, Spec {
  factory Field([void Function(FieldBuilder) updates]) = _$Field;

  Field._();

  @override
  BuiltList<Expression> get annotations;

  @override
  BuiltList<String> get docs;

  /// Field assignment, if any.
  Code? get assignment;

  /// Whether this field should be prefixed with `static`.
  ///
  /// This is only valid within classes.
  bool get static;

  /// Whether this field should be prefixed with `abstract`.
  ///
  /// This is only valid within abstract classes.
  bool get abstract;

  /// Whether this field should be prefixed with `late`.
  ///
  /// This is only valid wit classes.
  bool get late;

  /// Name of the field.
  String get name;

  Reference? get type;

  FieldModifier get modifier;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R? context,
  ]) =>
      visitor.visitField(this, context);
}

enum FieldModifier {
  var$,
  final$,
  constant,
}

abstract class FieldBuilder extends Object
    with HasAnnotationsBuilder, HasDartDocsBuilder
    implements Builder<Field, FieldBuilder> {
  factory FieldBuilder() = _$FieldBuilder;

  FieldBuilder._() {
    if (abstract && late) {
      throw StateError('Fields can be abstract or late. Not both.');
    }
    if (abstract && static) {
      throw StateError('Abstract fields can not be static');
    }
  }

  @override
  ListBuilder<Expression> annotations = ListBuilder<Expression>();

  @override
  ListBuilder<String> docs = ListBuilder<String>();

  /// Field assignment, if any.
  Code? assignment;

  /// Whether this field should be prefixed with `static`.
  ///
  /// This is only valid within classes.
  bool static = false;

  /// Whether this field should be prefixed with `abstract`.
  ///
  /// This is only valid within abstract classes.
  bool abstract = false;

  /// Whether this field should be prefixed with `late`.
  ///
  /// This is only valid wit classes.
  bool late = false;

  /// Name of the field.
  late String name;

  Reference? type;

  FieldModifier modifier = FieldModifier.var$;
}
