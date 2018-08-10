// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:matcher/matcher.dart';

import 'base.dart';
import 'emitter.dart';

/// Encodes [spec] as Dart source code.
String _dart(Spec spec, DartEmitter emitter) =>
    EqualsDart._format(spec.accept<StringSink>(emitter).toString());

/// Returns a matcher for Dart source code.
Matcher equalsDart(
  String source, [
  DartEmitter emitter,
]) =>
    EqualsDart._(EqualsDart._format(source), emitter ?? DartEmitter());

/// Implementation detail of using the [equalsDart] matcher.
///
/// See [EqualsDart.format] to specify the default source code formatter.
class EqualsDart extends Matcher {
  /// May override to provide a function to format Dart on [equalsDart].
  ///
  /// By default, uses [collapseWhitespace], but it is recommended to instead
  /// use `dart_style` (dartfmt) where possible. See `test/common.dart` for an
  /// example.
  static String Function(String) format = (String source) {
    return collapseWhitespace(source);
  };

  static String _format(String source) {
    try {
      return format(source).trim();
    } catch (_) {
      // Ignored on purpose, probably not exactly valid Dart code.
      return collapseWhitespace(source).trim();
    }
  }

  final DartEmitter _emitter;
  final String _source;

  const EqualsDart._(this._source, this._emitter);

  @override
  Description describe(Description description) => description.add(_source);

  @override
  Description describeMismatch(
    covariant Spec item,
    Description mismatchDescription,
    state,
    verbose,
  ) {
    final result = _dart(item, _emitter);
    return equals(result).describeMismatch(
      _source,
      mismatchDescription.add(result),
      state,
      verbose,
    );
  }

  @override
  bool matches(covariant Spec item, _) => _dart(item, _emitter) == _source;
}
