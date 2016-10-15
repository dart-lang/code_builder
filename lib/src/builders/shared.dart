// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';

/// Lazily builds an analyzer [AstNode] when [buildAst] is invoked.
///
/// Most builders should also have specific typed methods for returning their
/// type of AST node, such as `buildExpression` for returning an `Expression`
/// AST.
abstract class AstBuilder<T extends AstNode> {
  /// Returns an [AstNode] representing the state of the current builder.
  ///
  /// If [scope] is provided then identifiers are automatically prefixed and
  /// imports are collected in order to emit a final File AST that does not
  /// have conflicting or missing imports.
  T buildAst([Scope scope]);
}

/// Maintains a scope to prevent conflicting or missing imports in a file.
abstract class Scope {
  /// A [Scope] that does not apply any prefixing.
  static const Scope identity = const _IdentityScope();

  /// Returns an [Identifier] for [name].
  ///
  /// Optionally, specify the [importFrom] URI.
  Identifier getIdentifier(String name, [Uri importFrom]);
}

class _IdentityScope implements Scope {
  const _IdentityScope();

  @override
  Identifier getIdentifier(String name, [_]) => stringIdentifier(name);
}

/// Returns a string [Literal] from [value].
Identifier stringIdentifier(String value) => new SimpleIdentifier(
  stringToken(value),
);

/// Returns a string [Token] from [value].
Token stringToken(String value) => new StringToken(TokenType.STRING, value, 0);

/// Returns an [Identifier] for [name] via [scope].
///
/// If [scope] is `null`, automatically uses [Scope.identity].
Identifier getIdentifier(Scope scope, String name, [Uri importFrom]) {
  return (scope ?? Scope.identity).getIdentifier(name, importFrom);
}
