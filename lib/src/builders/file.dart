// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/tokens.dart';

/// Builds a file of Dart source code.
///
/// See [LibraryBuilder] and [PartBuilder] for concrete implementations.
abstract class FileBuilder implements AstBuilder<CompilationUnit> {
  final List<AstBuilder<CompilationUnitMember>> _members =
      <AstBuilder<CompilationUnitMember>>[];

  FileBuilder._();

  /// Adds a top-level field or class [member].
  void addMember(AstBuilder<CompilationUnitMember> member) {
    _members.add(member);
  }

  /// Adds top-level field or class [members].
  void addMembers(Iterable<AstBuilder<CompilationUnitMember>> members) {
    _members.addAll(members);
  }
}

/// Builds a standalone file (library) of Dart source code.
class LibraryBuilder extends FileBuilder {
  final List<AstBuilder<Directive>> _directives = <AstBuilder<Directive>>[];
  final Scope _scope;

  /// Creates a new standalone Dart library, optionally with [name].
  factory LibraryBuilder([String name]) =>
      new LibraryBuilder._(name, Scope.identity);

  /// Creates a new standalone Dart library, optionally with [name].
  ///
  /// Uses the default [Scope] implementation unless [scope] is set.
  factory LibraryBuilder.scope({String name, Scope scope}) {
    return new LibraryBuilder._(name, scope ?? new Scope());
  }

  LibraryBuilder._(String name, this._scope) : super._() {
    if (name != null) {
      _directives.add(new _LibraryDirectiveBuilder(name));
    }
  }

  /// Adds a file [directive].
  void addDirective(AstBuilder<Directive> directive) {
    _directives.add(directive);
  }

  /// Add file [directives].
  void addDirectives(Iterable<AstBuilder<Directive>> directives) {
    _directives.addAll(directives);
  }

  @override
  CompilationUnit buildAst([_]) {
    var members = _members.map((m) => m.buildAst(_scope)).toList();
    var directives = <Directive>[]
      ..addAll(_scope.toImports().map((d) => d.buildAst()))
      ..addAll(_directives.map((d) => d.buildAst()));
    return new CompilationUnit(
      null,
      null,
      directives,
      members,
      null,
    );
  }
}

/// Lazily builds a partial file (part of) Dart source code.
class PartBuilder extends FileBuilder {
  final String _name;

  /// Creates a partial Dart file.
  factory PartBuilder(String name) = PartBuilder._;

  PartBuilder._(this._name) : super._();

  @override
  CompilationUnit buildAst([_]) {
    return new CompilationUnit(
      null,
      null,
      [
        new PartOfDirective(
          null,
          null,
          $part,
          $of,
          new LibraryIdentifier([
            new SimpleIdentifier(stringToken(_name)),
          ]),
          $semicolon,
        )
      ],
      _members.map((m) => m.buildAst()).toList(),
      null,
    );
  }
}

class _LibraryDirectiveBuilder implements AstBuilder<LibraryDirective> {
  final String _name;

  _LibraryDirectiveBuilder(this._name);

  @override
  LibraryDirective buildAst([_]) {
    return new LibraryDirective(
      null,
      null,
      $library,
      new LibraryIdentifier([
        new SimpleIdentifier(
          stringToken(_name),
        ),
      ]),
      $semicolon,
    );
  }
}

/// Lazily builds an [ImportDirective] AST when built.
class ImportBuilder implements AstBuilder<ImportDirective> {
  final String _prefix;
  final String _uri;

  factory ImportBuilder(String path, {String prefix}) {
    return new ImportBuilder._(path, prefix);
  }

  ImportBuilder._(this._uri, this._prefix);

  @override
  ImportDirective buildAst([_]) {
    return new ImportDirective(
      null,
      null,
      null,
      new SimpleStringLiteral(stringToken("'$_uri'"), _uri),
      null,
      null,
      _prefix != null ? $as : null,
      _prefix != null ? stringIdentifier(_prefix) : null,
      null,
      $semicolon,
    );
  }
}
