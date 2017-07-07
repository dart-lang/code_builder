// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'specs/reference.dart';

/// Collects references and automatically allocates prefixes and imports.
///
/// `Allocator` takes out the manual work of deciding whether a symbol will
/// clash with other imports in your generated code, or what imports are needed
/// to resolve all symbols in your generated code.
abstract class Allocator {
  /// Returns a reference string given a [reference] object.
  ///
  /// For example, a no-op implementation:
  /// ```dart
  /// allocate(const Reference('List', 'dart:core')); // Outputs 'List'.
  /// ```
  ///
  /// Where-as an implementation that prefixes imports might output:
  /// ```dart
  /// allocate(const Reference('Foo', 'package:foo')); // Outputs '_i1.Foo'.
  /// ```
  String allocate(Reference reference);
}
