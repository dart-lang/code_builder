// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';

import 'builders/file.dart';
import 'tokens.dart';

/// Returns an identifier for [name], using [scope] to enforce prefixing.
///
/// It is _required_ within `code_builder` to use this API instead of creating
/// identifeirs manually in places where an obvious API collision could occur
/// (i.e. imported references).
///
/// If [scope] is null, no prefixing is applied.
///
/// ## Example
///     // May output `hello.Hello`.
///     identifier(scope, 'Hello', 'pacakge:hello/hello.dart')
Identifier identifier(Scope scope, String name, [String importFrom]) {
  return (scope ?? Scope.identity).identifier(name, importFrom);
}

/// Maintains an imported reference scope to avoid conflicts in generated code.
///
/// ## Example
///     void useContext(Scope scope) {
///       // May print 'i1.Foo'.
///       print(scope.identifier('Foo', 'package:foo/foo.dart'));
///
///       // May print 'i1.Bar'.
///       print(scope.identifier('Bar', 'package:foo/foo.dart'));
///
///       // May print 'i2.Bar'.
///       print(scope.getIdentifier('Baz', 'package:bar/bar.dart'));
///     }
abstract class Scope {
  /// A no-op [Scope]. Ideal for use for tests or example cases.
  ///
  /// **WARNING**: Does not collect import statements. This is only really
  /// advisable for use in tests but not production code. To use import
  /// collection but not prefixing, see [Scope.dedupe].
  static const Scope identity = const _IdentityScope();

  /// Create a new scoping context.
  ///
  /// Actual implementation of [Scope] is _not_ guaranteed, only that all
  /// import prefixes will be unique in a given scope.
  factory Scope() = _IncrementingScope;

  /// Create a context that just collects and de-duplicates imports.
  ///
  /// Prefixing is _not_ applied.
  factory Scope.dedupe() => new _DeduplicatingScope();

  /// Given a [name] and and import path, returns an [Identifier].
  Identifier identifier(String name, [String importFrom]);

  /// Return a list of import statements.
  List<ImportBuilder> toImports();
}

class _DeduplicatingScope extends _IdentityScope {
  final Set<String> _imports = new Set<String>();

  @override
  Identifier identifier(String name, [String importFrom]) {
    if (importFrom != null) {
      _imports.add(importFrom);
    }
    return super.identifier(name);
  }

  @override
  List<ImportBuilder> toImports() =>
      _imports.map((uri) => new ImportBuilder(uri)).toList();
}

class _IdentityScope implements Scope {
  const _IdentityScope();

  @override
  Identifier identifier(String name, [_]) {
    return astFactory.simpleIdentifier(stringToken(name));
  }

  @override
  List<ImportBuilder> toImports() => const [];
}

class _IncrementingScope extends _IdentityScope {
  final Map<String, int> _imports = <String, int>{};

  int _counter = 1;

  @override
  Identifier identifier(String name, [String importFrom]) {
    if (importFrom == null) {
      return super.identifier(name);
    }
    var newId = _imports.putIfAbsent(importFrom, () => _counter++);
    return astFactory.prefixedIdentifier(
      super.identifier('_i$newId'),
      $period,
      super.identifier(name),
    );
  }

  @override
  List<ImportBuilder> toImports() {
    return _imports.keys.map((uri) {
      return new ImportBuilder(uri, prefix: '_i${_imports[uri]}');
    }).toList();
  }
}
