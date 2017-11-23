// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_style/dart_style.dart';
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
    new EqualsDart._(EqualsDart._format(source), emitter ?? new DartEmitter());

/// Implementation detail of using the [equalsDart] matcher.
///
/// See [EqualsDart.format] to specify the default source code formatter.
class EqualsDart extends Matcher {
  // TODO: Remove in 3.0.0.
  static final _formatter = new DartFormatter();

  /// May override to provide a function to format Dart on [equalsDart].
  ///
  /// As of `2.x.x`, this defaults to using `dartfmt`, but in an upcoming
  /// release (`3.x.x`) it will default to [collapseWhitespace]. This is in
  /// order to avoid a dependency on specific versions of `dartfmt` and the
  /// `analyzer` package.
  ///
  /// To future proof, see an example in code_builder's `test/common.dart`.
  static String Function(String) format = (String source) {
    try {
      return _formatter.format(source);
    } on FormatException catch (_) {
      return _formatter.formatStatement(source);
    }
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
