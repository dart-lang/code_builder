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

  /// References [dart_core.identityHashCode].
  final ReferenceBuilder identityHashCode = _ref('identityHashCode');

  /// References [dart_core.int].
  final ReferenceBuilder int = _ref('int');

  /// References [dart_core.AbstractClassInstantiationError].
  final ReferenceBuilder AbstractClassInstantiationError = _ref('AbstractClassInstantiationError');

  /// References [dart_core.ArgumentError].
  final ReferenceBuilder ArgumentError = _ref('ArgumentError');

  /// References [dart_core.AssertionError].
  final ReferenceBuilder AssertionError = _ref('AssertionError');

  /// References [dart_core.BidirectionalIterator].
  final ReferenceBuilder BidirectionalIterator = _ref('BidirectionalIterator');

  /// References [dart_core.CastError].
  final ReferenceBuilder CastError = _ref('CastError');

  /// References [dart_core.Comparable].
  final ReferenceBuilder Comparable = _ref('Comparable');

  /// References [dart_core.Comparator]
  final ReferenceBuilder Comparator = _ref('Comparator');

  /// References [dart_core.ConcurrentModificationError].
  final ReferenceBuilder ConcurrentModificationError = _ref('ConcurrentModificationError');

  /// References [dart_core.CyclicInitializationError].
  final ReferenceBuilder CyclicInitializationError = _ref('CyclicInitializationError');

  /// References [dart_core.DateTime].
  final ReferenceBuilder DateTime = _ref('DateTime');

  /// References [dart_core.Deprecated].
  final ReferenceBuilder Deprecated = _ref('Deprecated');

  /// References [dart_core.Duration].
  final ReferenceBuilder Duration = _ref('Duration');

  /// References [dart_core.Error].
  final ReferenceBuilder Error = _ref('Error');

  /// References [dart_core.Exception].
  final ReferenceBuilder Exception = _ref('Exception');

  /// References [dart_core.Expando].
  final ReferenceBuilder Expando = _ref('Expando');

  /// References [dart_core.FallThroughError].
  final ReferenceBuilder FallThroughError = _ref('FallThroughError');

  /// References [dart_core.FormatException].
  final ReferenceBuilder FormatException = _ref('FormatException');

  /// References [dart_core.Function].
  final ReferenceBuilder Function = _ref('Function');

  /// References [dart_core.IndexError].
  final ReferenceBuilder IndexError = _ref('IndexError');

  /// References [dart_core.IntegerDivisionByZeroException].
  final ReferenceBuilder IntegerDivisionByZeroException = _ref('IntegerDivisionByZeroException');

  /// References [dart_core.Invocation].
  final ReferenceBuilder Invocation = _ref('Invocation');

  /// References [dart_core.Iterable].
  final ReferenceBuilder Iterable = _ref('Iterable');

  /// References [dart_core.Iterator].
  final ReferenceBuilder Iterator = _ref('Iterator');

  /// References [dart_core.List].
  final ReferenceBuilder List = _ref('List');

  /// References [dart_core.Map].
  final ReferenceBuilder Map = _ref('Map');

  /// References [dart_core.Match].
  final ReferenceBuilder Match = _ref('Match');

  /// References [dart_core.NoSuchMethodError].
  final ReferenceBuilder NoSuchMethodError = _ref('NoSuchMethodError');

  /// References [dart_core.Null].
  final ReferenceBuilder Null = _ref('Null');

  /// References [dart_core.NullThrownError].
  final ReferenceBuilder NullThrownError = _ref('NullThrownError');

  /// References [dart_core.Object].
  final ReferenceBuilder Object = _ref('Object');

  /// References [dart_core.OutOfMemoryError].
  final ReferenceBuilder OutOfMemoryError = _ref('OutOfMemoryError');

  /// References [dart_core.Pattern].
  final ReferenceBuilder Pattern = _ref('Pattern');

  /// References [dart_core.RangeError].
  final ReferenceBuilder RangeError = _ref('RangeError');

  /// References [dart_core.RegExp].
  final ReferenceBuilder RegExp = _ref('RegExp');

  /// References [dart_core.RuneIterator].
  final ReferenceBuilder RuneIterator = _ref('RuneIterator');

  /// References [dart_core.Runes].
  final ReferenceBuilder Runes = _ref('Runes');

  /// References [dart_core.Set].
  final ReferenceBuilder Set = _ref('Set');

  /// References [dart_core.Sink].
  final ReferenceBuilder Sink = _ref('Sink');

  /// References [dart_core.StackOverflowError].
  final ReferenceBuilder StackOverflowError = _ref('StackOverflowError');

  /// References [dart_core.StackTrace].
  final ReferenceBuilder StackTrace = _ref('StackTrace');

  /// References [dart_core.StateError].
  final ReferenceBuilder StateError = _ref('StateError');

  /// References [dart_core.Stopwatch].
  final ReferenceBuilder Stopwatch = _ref('Stopwatch');

  /// References [dart_core.String].
  final ReferenceBuilder String = _ref('String');

  /// References [dart_core.StringBuffer].
  final ReferenceBuilder StringBuffer = _ref('StringBuffer');

  /// References [dart_core.StringSink].
  final ReferenceBuilder StringSink = _ref('StringSink');

  /// References [dart_core.Symbol].
  final ReferenceBuilder Symbol = _ref('Symbol');

  /// References [dart_core.Type].
  final ReferenceBuilder Type = _ref('Type');

  /// References [dart_core.TypeError].
  final ReferenceBuilder TypeError = _ref('TypeError');

  /// References [dart_core.UnimplementedError].
  final ReferenceBuilder UnimplementedError = _ref('UnimplementedError');

  /// References [dart_core.UnsupportedError].
  final ReferenceBuilder UnsupportedError = _ref('UnsupportedError');

  /// References [dart_core.Uri].
  final ReferenceBuilder Uri = _ref('Uri');

  /// References [dart_core.UriData].
  final ReferenceBuilder UriData = _ref('UriData');

  /// References `void` type for returning nothing in a method.
  ///
  /// **NOTE**: As a language limitation, this cannot be named `void`.
  final TypeBuilder $void = new TypeBuilder('void');

  DartCore._();

  static ReferenceBuilder _ref(dart_core.String name) {
    return reference(name, 'dart:core');
  }
}
