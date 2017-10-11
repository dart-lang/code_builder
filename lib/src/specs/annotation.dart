// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.annotation;

import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../visitors.dart';
import 'code.dart';

part 'annotation.g.dart';

@immutable
abstract class Annotation
    implements Built<Annotation, AnnotationBuilder>, Spec {
  factory Annotation([void updates(AnnotationBuilder b)]) = _$Annotation;

  Annotation._();

  /// Part after the `@` in annotation.
  Code get code;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R context,
  ]) =>
      visitor.visitAnnotation(this, context);
}

abstract class AnnotationBuilder
    implements Builder<Annotation, AnnotationBuilder> {
  factory AnnotationBuilder() = _$AnnotationBuilder;

  AnnotationBuilder._();

  Code code;
}
