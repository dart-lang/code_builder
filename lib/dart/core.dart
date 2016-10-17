// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Contains reference to the `dart:core` SDK for use in code generation.
///
/// This library is currently *experimental*, and is subject to change; it is
/// currently manually maintained but there might be a strong use case for this
/// to be automatically generated (at least partially) in the near future.
///
/// ## Usage
///
/// First import the library:
///     import 'package:code_builder/code_builder.dart';
///     import 'package:code_builder/dart/core.dart';
///
/// All references are _namespaced_ under [core]. Try it:
///     // Outputs: print('Hello World')
///     core.print.call([literal('Hello World')]);
///
/// If you are [missing a reference from `dart:core`](https://goo.gl/XbSfmT)
/// please send us a [pull request](https://goo.gl/2LvV7f) or
/// [file an issue](https://goo.gl/IooPfl).
library code_builder.dart.core;

import 'dart:core' as dart_core;

import 'package:code_builder/code_builder.dart';

/// A namespace for references in `dart:core`.
final DartCore core = new DartCore._();

/// References to the `dart:core` library for code generation. See [core].
class DartCore {
  /// References [dart_core.bool].
  final ReferenceBuilder bool = _ref('bool');

  /// References [dart_core.identical].
  final ReferenceBuilder identical = _ref('identical');

  /// References [dart_core.deprecated].
  final ReferenceBuilder deprecated = _ref('deprecated');

  /// References [dart_core.override].
  final ReferenceBuilder override = _ref('override');

  /// References [dart_core.print].
  final ReferenceBuilder print = _ref('print');

  /// References [dart_core.int].
  final ReferenceBuilder int = _ref('int');

  /// References [dart_core.Deprecated].
  final ReferenceBuilder Deprecated = _ref('Deprecated');

  /// References [dart_core.Iterable].
  final ReferenceBuilder Iterable = _ref('Iterable');

  /// References [dart_core.List].
  final ReferenceBuilder List = _ref('List');

  /// References [dart_core.Map].
  final ReferenceBuilder Map = _ref('Map');

  /// References [dart_core.Null].
  final ReferenceBuilder Null = _ref('Null');

  /// References [dart_core.Object].
  final ReferenceBuilder Object = _ref('Object');

  /// References [dart_core.String].
  final ReferenceBuilder String = _ref('String');

  /// References `void` type for returning nothing in a method.
  ///
  /// **NOTE**: As a language limitation, this cannot be named `void`.
  final TypeBuilder $void = new TypeBuilder('void');

  DartCore._();

  static ReferenceBuilder _ref(dart_core.String name) {
    return reference(name, 'dart:core');
  }
}
