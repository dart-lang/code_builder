// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/tokens.dart';

/// Creates a reference called [name].
ReferenceBuilder reference(String name, [String importUri]) {
  return new ReferenceBuilder._(name);
}

/// An abstract way of representing other types of [AstBuilder].
class ReferenceBuilder implements AnnotationBuilder {
  final String _name;

  ReferenceBuilder._(this._name);

  @override
  Annotation buildAnnotation([Scope scope]) {
    return new Annotation(
      $at,
      stringIdentifier(_name),
      null,
      null,
      null,
    );
  }

  @override
  AstNode buildAst([Scope scope]) => throw new UnimplementedError();
}
