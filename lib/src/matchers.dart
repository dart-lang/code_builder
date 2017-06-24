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
String _dart(Spec spec) =>
    _dartfmt(spec.accept<StringSink>(const DartEmitter()).toString());

/// Returns a matcher for Dart source code.
Matcher equalsDart(String source) => new _EqualsDart(_dartfmt(source));

class _EqualsDart extends Matcher {
  final String _source;

  const _EqualsDart(this._source);

  @override
  Description describe(Description description) => description.add(_source);

  @override
  Description describeMismatch(
    covariant Spec item,
    Description mismatchDescription,
    _,
    __,
  ) =>
      mismatchDescription.add(_dart(item));

  @override
  bool matches(covariant Spec item, _) => _dart(item) == _source;
}
