// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library code_builder.src.specs.class_;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/dartdoc.dart';
import '../visitors.dart';

part 'class.g.dart';

@immutable
abstract class Class extends Object
    with HasDartDocs
    implements Built<Class, ClassBuilder>, Spec {
  factory Class([void updates(ClassBuilder b)]) = _$Class;

  Class._();

  /// Whether the class is `abstract`.
  bool get abstract;

  @override
  BuiltList<String> get docs;

  /// Name of the class.
  String get name;

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitClass(this);
}

abstract class ClassBuilder extends Object
    with HasDartDocsBuilder
    implements Builder<Class, ClassBuilder> {
  factory ClassBuilder() = _$ClassBuilder;

  ClassBuilder._();

  /// Whether the class is `abstract`.
  bool abstract = false;

  @override
  ListBuilder<String> docs = new ListBuilder<String>();

  /// Name of the class.
  String name;
}
