// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:matcher/matcher.dart';

final DartFormatter _dartfmt = DartFormatter();

String _dartFormatAttempt(String source) {
  try {
    return _dartfmt.format(source);
  } on FormatterException catch (_) {}

  try {
    return _dartfmt.formatStatement(source);
  } on FormatterException catch (_) {}

  return collapseWhitespace(source).trim();
}

/// Returns a matcher for [Spec] objects that emit code matching [source].
///
/// Both [source] and the result emitted from the compared [Spec] are formatted
/// with dart_style.
Matcher equalsDart(String source, [DartEmitter? emitter]) =>
    _EqualsDart._(_EqualsDart._format(source), emitter ?? DartEmitter());

/// Encodes [spec] as Dart source code.
String _dart(Spec spec, DartEmitter emitter) =>
    _EqualsDart._format(spec.accept<StringSink>(emitter).toString());

/// Implementation detail of using the [equalsDart] matcher.
class _EqualsDart extends Matcher {
  static String _format(String source) => _dartFormatAttempt(source).trim();

  final DartEmitter _emitter;
  final String _expectedSource;

  const _EqualsDart._(this._expectedSource, this._emitter);

  @override
  Description describe(Description description) =>
      description.add(_expectedSource);

  @override
  Description describeMismatch(
    covariant Spec item,
    Description mismatchDescription,
    Map<dynamic, dynamic> matchState,
    bool verbose,
  ) {
    final actualSource = _dart(item, _emitter);
    return equals(_expectedSource).describeMismatch(
      actualSource,
      mismatchDescription,
      matchState,
      verbose,
    );
  }

  @override
  bool matches(covariant Spec item, Object? matchState) =>
      _dart(item, _emitter) == _expectedSource;
}
