// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/class.dart';
import 'package:code_builder/src/builders/parameter.dart';
import 'package:code_builder/src/builders/shared.dart';

/// Builds an [Annotation] AST when [buildAnnotation] is invoked.
abstract class AnnotationBuilder
    implements ValidClassMember, ValidParameterMember {
  /// Returns an [Annotation] AST representing the builder.
  Annotation buildAnnotation([Scope scope]);
}

/// An [AstBuilder] that can be annotated with [AnnotationBuilder].
abstract class HasAnnotations implements AstBuilder {
  /// Adds [annotation] to the builder.
  void addAnnotation(AnnotationBuilder annotation);

  /// Adds [annotations] to the builder.
  void addAnnotations(Iterable<AnnotationBuilder> annotations);
}

/// Implements [HasAnnotations].
abstract class HasAnnotationsMixin implements HasAnnotations {
  final List<AnnotationBuilder> _annotations = <AnnotationBuilder>[];

  @override
  void addAnnotation(AnnotationBuilder annotation) {
    _annotations.add(annotation);
  }

  @override
  void addAnnotations(Iterable<AnnotationBuilder> annotations) {
    _annotations.addAll(annotations);
  }

  /// Returns a [List] of all built [Annotation]s.
  List<Annotation> buildAnnotations([Scope scope]) => _annotations
      .map/*<Annotation>*/((a) => a.buildAnnotation(scope))
      .toList();

  /// Clones all annotations to [clone].
  void copyAnnotationsTo(HasAnnotations clone) {
    clone.addAnnotations(_annotations);
  }
}
