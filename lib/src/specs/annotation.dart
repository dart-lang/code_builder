// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.annotation;

import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../visitors.dart';
import 'code.dart';
import 'expression.dart';

part 'annotation.g.dart';

@Deprecated('Use an Expression node instead. Will be removed in 3.0.0.')
@immutable
abstract class Annotation extends Expression
    implements Built<Annotation, AnnotationBuilder>, Spec {
  factory Annotation([void updates(AnnotationBuilder b)]) = _$Annotation;

  Annotation._();

  /// Part after the `@` in annotation.
  @override
  Code get code => codeForAnnotation;

  /// Use [code] instead.
  ///
  /// This property exists in order to keep compatibility with having a concrete
  /// [Annotation] class, but also allow migrating to using [Expression] instead
  /// to add annotations.
  Code get codeForAnnotation;

  @override
  R accept<R>(SpecVisitor<R> visitor, [R context]) {
    return visitor.visitAnnotation(this, context);
  }
}

abstract class AnnotationBuilder
    // ignore: deprecated_member_use
    implements
        Builder<Annotation, AnnotationBuilder> {
  factory AnnotationBuilder() = _$AnnotationBuilder;

  AnnotationBuilder._();

  Code get code => codeForAnnotation;
  set code(Code code) => codeForAnnotation = code;

  Code codeForAnnotation;
}
