// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';
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
Matcher equalsSource(String source, {bool format: true, Scope scope}) {
  return new _EqualsSource(
    scope,
    format ? dartfmt(source) : source,
    format,
  );
}

Identifier _stringId(String s) {
  return new SimpleIdentifier(new StringToken(TokenType.STRING, s, 0));
}

/// Returns identifiers that are just the file name.
///
/// For example `getIdentifier('Foo', 'package:foo/foo.dart')` would return
/// the identifier "foo.Foo". This isn't safe enough for use in a actual
/// code-gen but makes it easy to debug issues in our tests.
const Scope simpleNameScope = const _SimpleNameScope();

class _SimpleNameScope implements Scope {
  const _SimpleNameScope();

  @override
  Identifier getIdentifier(String symbol, String importUri) {
    var fileWithoutExt =
        Uri.parse(importUri).pathSegments.last.split('.').first;
    return new PrefixedIdentifier(
      _stringId(fileWithoutExt),
      new Token(TokenType.PERIOD, 0),
      _stringId(symbol),
    );
  }

  @override
  Iterable<ImportBuilder> getImports() => const [];
}

// Delegates to the default matcher (which delegates further).
//
// Would be nice to just use more of package:matcher directly:
// https://github.com/dart-lang/matcher/issues/36
class _EqualsSource extends Matcher {
  final Scope _scope;
  final String _source;
  final bool _isFormatted;

  _EqualsSource(this._scope, this._source, this._isFormatted);

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
    AstNode astNode;
    if (_scope != null && builder is ScopeAware) {
      astNode = builder.toScopedAst(_scope);
    } else {
      astNode = builder.toAst();
    }
    if (_isFormatted) {
      return prettyToSource(astNode);
    } else {
      return astNode.toSource();
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
