// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_style/dart_style.dart';
import 'package:matcher/matcher.dart';

import 'base.dart';
import 'emitter.dart';

final _formatter = new DartFormatter();

/// Runs dartfmt.
String _dartfmt(String source) {
  try {
    return _formatter.format(source);
  } on FormatException catch (_) {
    return _formatter.formatStatement(source);
  } catch (_) {
    return source.replaceAll('  ', ' ').replaceAll('\n', '').trim();
  }
}

/// Encodes [spec] as Dart source code.
String _dart(Spec spec, DartEmitter emitter) =>
    _dartfmt(spec.accept<StringSink>(emitter).toString()).trim();

/// Returns a matcher for Dart source code.
Matcher equalsDart(
  String source, [
  DartEmitter emitter = const DartEmitter(),
]) =>
    new _EqualsDart(_dartfmt(source).trim(), emitter);

class _EqualsDart extends Matcher {
  final DartEmitter _emitter;
  final String _source;

  const _EqualsDart(this._source, this._emitter);

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
      mismatchDescription,
      state,
      verbose,
    );
  }

  @override
  bool matches(covariant Spec item, _) => _dart(item, _emitter) == _source;
}
