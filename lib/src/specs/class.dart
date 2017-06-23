// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/src/base.dart';
import 'package:code_builder/src/visitor.dart';
import 'package:meta/meta.dart';

import '../assert.dart';
import '../base.dart';

/// Model for a `class` definition.
class ClassSpec extends Spec {
  final String name;

  const ClassSpec._({
    @required this.name,
  });

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitClassSpec(this);
}

/// Returns a builder for a `class` definition.
ClassSpecBuilder classBuilder(String name) =>
    new ClassSpecBuilder._(notNull(name, 'name'));

/// Builder for a `class` definition.
class ClassSpecBuilder extends SpecBuilder<ClassSpec> {
  /// Name of the `class`, i.e. `class {{name}}`.
  final String name;

  const ClassSpecBuilder._(this.name);

  @override
  ClassSpec build() => new ClassSpec._(name: name);
}
