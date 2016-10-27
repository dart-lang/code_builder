// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/pretty_printer.dart';
import 'package:dart_style/dart_style.dart';
import 'package:matcher/matcher.dart';

/// Returns a [Matcher] that checks an [AstBuilder] versus [source].
///
/// On failure, uses the default string matcher to show a detailed diff between
/// the expected and actual source code results.
///
/// If [pretty] is set, uses another `toSource` method that adds additional
/// line breaks to make the output more readable and idiomatic.
Matcher equalsSource(
  String source, {
  bool pretty: false,
  Scope scope: Scope.identity,
}) {
  var canParse = false;
  try {
    source = dartfmt(source);
    canParse = true;
  } on FormatterException catch (_) {}
  return new _EqualsSource(
    scope,
    source,
    canParse,
    pretty,
  );
}

class _EqualsSource extends Matcher {
  final Scope _scope;
  final String _source;
  final bool _canParse;
  final bool _pretty;

  _EqualsSource(this._scope, this._source, this._canParse, this._pretty);

  @override
  Description describe(Description description) {
    if (_canParse) {
      return equals(_source).describe(description);
    } else {
      return equalsIgnoringWhitespace(_source).describe(description);
    }
  }

  @override
  Description describeMismatch(
    item,
    Description mismatchDescription,
    Map matchState,
    bool verbose,
  ) {
    if (item is AstBuilder) {
      var origin = _formatAst(item);
      if (_canParse) {
        return equals(_source).describeMismatch(
          origin,
          mismatchDescription.addDescriptionOf(origin),
          matchState,
          verbose,
        );
      } else {
        return equalsIgnoringWhitespace(_source).describeMismatch(
          origin,
          mismatchDescription.addDescriptionOf(origin),
          matchState,
          verbose,
        );
      }
    } else {
      return mismatchDescription.add('$item is not a CodeBuilder');
    }
  }

  @override
  bool matches(item, _) {
    if (item is AstBuilder) {
      if (_canParse) {
        return equals(_formatAst(item)).matches(_source, {});
      } else {
        return equalsIgnoringWhitespace(_formatAst(item)).matches(_source, {});
      }
    }
    return false;
  }

  String _formatAst(AstBuilder builder) {
    var astNode = builder.buildAst(_scope);
    if (_canParse) {
      return dartfmt(_pretty ? prettyToSource(astNode) : astNode.toSource());
    }
    return astNode.toSource();
  }
}
