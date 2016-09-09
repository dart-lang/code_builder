// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:matcher/matcher.dart';

/// Returns a [Matcher] that checks a [CodeBuilder] versus [source].
///
/// On failure, uses the default string matcher to show a detailed diff between
/// the expected and actual source code results.
///
/// **NOTE**: By default it both runs `dartfmt` _and_ prints the source with
/// additional formatting over the default `Ast.toSource` implementation (i.e.
/// adds new lines between methods in classes, and more).
///
/// If you have code that is not consider a valid compilation unit (like an
/// expression, you should flip [format] to `false`).
Matcher equalsSource(String source, {bool format: true}) {
  return new _EqualsSource(format ? dartfmt(source) : source, format);
}

// Delegates to the default matcher (which delegates further).
//
// Would be nice to just use more of package:matcher directly:
// https://github.com/dart-lang/matcher/issues/36
class _EqualsSource extends Matcher {
  final String _source;
  final bool _isFormatted;

  _EqualsSource(this._source, this._isFormatted);

  @override
  Description describe(Description description) {
    return equals(_source).describe(description);
  }

  @override
  Description describeMismatch(
    item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    if (item is CodeBuilder) {
      return equals(_source).describeMismatch(
        _formatAst(item),
        mismatchDescription,
        matchState,
        verbose,
      );
    } else {
      return mismatchDescription.add('$item is not a CodeBuilder');
    }
  }

  String _formatAst(CodeBuilder builder) {
    var ast = builder.toAst();
    if (_isFormatted) {
      return prettyToSource(ast);
    } else {
      return ast.toSource();
    }
  }

  @override
  bool matches(item, _) {
    if (item is CodeBuilder) {
      return _formatAst(item) == _source;
    }
    return false;
  }
}
