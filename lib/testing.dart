// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/tokens.dart';
import 'package:dart_style/dart_style.dart';
import 'package:matcher/matcher.dart';

/// Returns a [Matcher] that checks an [AstBuilder] versus [source].
///
/// On failure, uses the default string matcher to show a detailed diff between
/// the expected and actual source code results.
///
/// **NOTE**: Runs `dartfmt` _and_ prints the source with additional formatting
/// over the default `Ast.toSource` implementation (i.e. adds new lines between
/// methods in classes, and more).
Matcher equalsSource(
    String source, {
    Scope scope: Scope.identity,
    }) {
  try {
    source = dartfmt(source);
  } on FormatterException catch (_) {}
  return new _EqualsSource(
      scope,
      source,
      );
}

/// Returns a [Matcher] that checks a [CodeBuilder versus [source].
///
/// On failure, uses the default string matcher to show a detailed diff between
/// the expected and actual source code results.
///
/// **NOTE**: Whitespace is ignored.
Matcher equalsUnformatted(
    String source, {
    Scope scope: Scope.identity,
    }) {
  return new _EqualsSource(
      scope,
      source,
      );
}

class _EqualsSource extends Matcher {
  final Scope _scope;
  final String _source;

  _EqualsSource(this._scope, this._source);

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
    if (item is AstBuilder) {
      var origin = _formatAst(item);
      return equalsIgnoringWhitespace(_source).describeMismatch(
          origin,
          mismatchDescription.addDescriptionOf(origin),
          matchState,
          verbose,
          );
    } else {
      return mismatchDescription.add('$item is not a CodeBuilder');
    }
  }

  @override
  bool matches(item, _) {
    if (item is AstBuilder) {
      return equalsIgnoringWhitespace(_formatAst(item)).matches(_source, {});
    }
    return false;
  }

  String _formatAst(AstBuilder builder) {
    var astNode = builder.buildAst(_scope);
    return prettyToSource(astNode);
  }
}
