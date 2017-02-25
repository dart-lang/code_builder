// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/tokens.dart';

/// Builds a file of Dart source code.
///
/// See [LibraryBuilder] and [PartOfBuilder] for concrete implementations.
abstract class FileBuilder implements AstBuilder<CompilationUnit> {
  final List<AstBuilder> _members = <AstBuilder>[];

  FileBuilder._();

  /// Adds a top-level field or class [member].
  void addMember(AstBuilder member) {
    _members.add(member);
  }

  /// Adds top-level field or class [members].
  void addMembers(Iterable<AstBuilder> members) {
    _members.addAll(members);
  }
}

/// Builds a standalone file (library) of Dart source code.
class LibraryBuilder extends FileBuilder with HasAnnotationsMixin {
  final List<AstBuilder<Directive>> _directives = <AstBuilder<Directive>>[];
  final String _name;
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

  LibraryBuilder._(this._name, this._scope) : super._();

  /// Adds a file [directive].
  void addDirective(AstBuilder<Directive> directive) {
    _directives.add(directive);
  }

  /// Add file [directives].
  void addDirectives(Iterable<AstBuilder<Directive>> directives) {
    _directives.addAll(directives);
  }

  @override
  CompilationUnit buildAst([Scope scope]) {
    var members = _members.map((m) {
      if (m is TopLevelMixin) {
        return (m as TopLevelMixin).buildTopLevelAst(_scope);
      }
      return m.buildAst(_scope);
    }).toList();
    var directives = <Directive>[];
    if (_name != null) {
      directives.add(new _LibraryDirectiveBuilder(_name, this).buildAst(scope));
    }
    directives
      ..addAll(_scope.toImports().map((d) => d.buildAst()))
      ..addAll(_directives.map((d) => d.buildAst()));
    return astFactory.compilationUnit(
      null,
      null,
      directives,
      members,
      null,
    );
  }
}

/// Lazily builds a partial file (part of) Dart source code.
class PartOfBuilder extends FileBuilder with HasAnnotationsMixin {
  final String _uri;
  final Scope _scope;

  /// Creates a partial Dart file.
  factory PartOfBuilder(String uri, [Scope scope]) = PartOfBuilder._;

  PartOfBuilder._(this._uri, [this._scope]) : super._();

  @override
  CompilationUnit buildAst([Scope scope]) {
    scope ??= _scope;
    return astFactory.compilationUnit(
      null,
      null,
      [
        astFactory.partOfDirective(
          null,
          buildAnnotations(scope),
          $part,
          $of,
          null,
          astFactory.libraryIdentifier([
            astFactory.simpleIdentifier(stringToken("'$_uri'")),
          ]),
          $semicolon,
        )
      ],
      _members.map((m) {
        if (m is TopLevelMixin) {
          return (m as TopLevelMixin).buildTopLevelAst();
        }
        return m.buildAst();
      }).toList(),
      null,
    );
  }
}

class _LibraryDirectiveBuilder implements AstBuilder<LibraryDirective> {
  final LibraryBuilder _library;
  final String _name;

  _LibraryDirectiveBuilder(this._name, this._library);

  @override
  LibraryDirective buildAst([Scope scope]) {
    return astFactory.libraryDirective(
      null,
      _library.buildAnnotations(scope),
      $library,
      astFactory.libraryIdentifier([
        astFactory.simpleIdentifier(
          stringToken(_name),
        ),
      ]),
      $semicolon,
    );
  }
}

/// Lazily builds a [PartDirective] AST when built.
class PartBuilder extends Object
    with HasAnnotationsMixin
    implements AstBuilder<PartDirective> {
  final String _uri;

  factory PartBuilder(String uri) = PartBuilder._;
  PartBuilder._(this._uri);

  @override
  PartDirective buildAst([Scope scope]) {
    return astFactory.partDirective(
      null,
      buildAnnotations(scope),
      $part,
      astFactory.simpleStringLiteral(stringToken("'$_uri'"), _uri),
      $semicolon,
    );
  }
}

/// Lazily builds an [ImportDirective] AST when built.
class ImportBuilder extends Object
    with HasAnnotationsMixin
    implements AstBuilder<ImportDirective> {
  final String _prefix;
  final String _uri;
  final bool _deferred;

  final Set<String> _show = new Set<String>();
  final Set<String> _hide = new Set<String>();

  factory ImportBuilder(String path, {bool deferred: false, String prefix}) {
    return new ImportBuilder._(path, prefix, deferred);
  }

  ImportBuilder._(this._uri, this._prefix, this._deferred);

  void hide(String identifier) {
    _hide.add(identifier);
  }

  void hideAll(Iterable<String> identifiers) {
    _hide.addAll(identifiers);
  }

  void show(String identifier) {
    _show.add(identifier);
  }

  void showAll(Iterable<String> identifier) {
    _show.addAll(identifier);
  }

  @override
  ImportDirective buildAst([Scope scope]) {
    var combinators = <Combinator>[];
    if (_show.isNotEmpty) {
      combinators.add(
        astFactory.showCombinator(
          $show,
          _show.map(stringIdentifier).toList(),
        ),
      );
    }
    if (_hide.isNotEmpty) {
      combinators.add(
        astFactory.hideCombinator(
          $hide,
          _hide.map(stringIdentifier).toList(),
        ),
      );
    }
    return astFactory.importDirective(
      null,
      buildAnnotations(scope),
      null,
      astFactory.simpleStringLiteral(stringToken("'$_uri'"), _uri),
      null,
      _deferred ? $deferred : null,
      _prefix != null ? $as : null,
      _prefix != null ? stringIdentifier(_prefix) : null,
      combinators,
      $semicolon,
    );
  }
}

/// Lazily builds an [ExportDirective] AST when built.
class ExportBuilder extends Object
    with HasAnnotationsMixin
    implements AstBuilder<ExportDirective> {
  final String _uri;

  final Set<String> _show = new Set<String>();
  final Set<String> _hide = new Set<String>();

  factory ExportBuilder(String path) = ExportBuilder._;

  ExportBuilder._(this._uri);

  void hide(String identifier) {
    _hide.add(identifier);
  }

  void hideAll(Iterable<String> identifiers) {
    _hide.addAll(identifiers);
  }

  void show(String identifier) {
    _show.add(identifier);
  }

  void showAll(Iterable<String> identifier) {
    _show.addAll(identifier);
  }

  @override
  ExportDirective buildAst([Scope scope]) {
    var combinators = <Combinator>[];
    if (_show.isNotEmpty) {
      combinators.add(
        astFactory.showCombinator(
          $show,
          _show.map(stringIdentifier).toList(),
        ),
      );
    }
    if (_hide.isNotEmpty) {
      combinators.add(
        astFactory.hideCombinator(
          $hide,
          _hide.map(stringIdentifier).toList(),
        ),
      );
    }
    return astFactory.exportDirective(
      null,
      buildAnnotations(scope),
      null,
      astFactory.simpleStringLiteral(stringToken("'$_uri'"), _uri),
      null,
      combinators,
      $semicolon,
    );
  }
}
