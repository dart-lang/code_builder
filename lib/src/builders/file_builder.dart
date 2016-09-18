// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

CompilationUnit _emptyCompilationUnit() => new CompilationUnit(
      null,
      null,
      null,
      null,
      null,
    );

/// An `export` directive in a [LibraryBuilder].
class ExportBuilder implements CodeBuilder<ExportDirective> {
  final String _uri;

  /// Create a new `export` directive exporting [uri].
  factory ExportBuilder(String uri) = ExportBuilder._;

  const ExportBuilder._(this._uri);

  @override
  ExportDirective toAst([_]) {
    return _createExportDirective()..uri = _stringLiteral("'$_uri'");
  }

  static ExportDirective _createExportDirective() => new ExportDirective(
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      );
}

/// Builds files of Dart source code.
///
/// See [LibraryBuilder] and [PartBuilder] for concrete implementations.
abstract class FileBuilder implements CodeBuilder<CompilationUnit> {
  final List<CodeBuilder<Declaration>> _declarations =
      <CodeBuilder<Declaration>>[];

  FileBuilder._();

  /// Adds [declaration]'s resulting AST to the source.
  void addDeclaration(CodeBuilder<Declaration> declaration) {
    _declarations.add(declaration);
  }

  @override
  @mustCallSuper
  CompilationUnit toAst([Scope scope = const Scope.identity()]) =>
      _emptyCompilationUnit()
        ..declarations
            .addAll(_declarations.map/*<Declaration>*/((d) => d.toAst(scope)));
}

/// An `import` directive in a [FileBuilder].
class ImportBuilder implements CodeBuilder<ImportDirective> {
  final String _uri;
  final String _prefix;

  /// Create a new `import` directive importing [uri].
  ///
  /// Optionally prefix [as].
  const factory ImportBuilder(String uri, {String as}) = ImportBuilder._;

  const ImportBuilder._(this._uri, {String as}) : _prefix = as;

  @override
  ImportDirective toAst([_]) => _createImportDirective()
    ..uri = _stringLiteral("'$_uri'")
    ..prefix = _prefix != null ? _stringIdentifier(_prefix) : null;

  static ImportDirective _createImportDirective() => new ImportDirective(
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      );
}

/// Builds a standalone Dart library [CompilationUnit] AST.
class LibraryBuilder extends FileBuilder {
  static final Token _library = new KeywordToken(Keyword.LIBRARY, 0);

  final String _name;
  final Scope _scope;

  final List<CodeBuilder<Directive>> _directives = <CodeBuilder<Directive>>[];

  /// Create a new standalone Dart library, optionally with a [name].
  factory LibraryBuilder([String name]) {
    return new LibraryBuilder._(name, const Scope.identity());
  }

  /// Create a new standalone Dart library, optionally with a [name].
  ///
  /// As references are added in the library that implements [ScopeAware]
  /// they are re-written to avoid collisions and the imports are automatically
  /// included at the top with optional prefixes.
  factory LibraryBuilder.scope({String name, Scope scope}) {
    return new LibraryBuilder._(name, scope ?? new Scope());
  }

  LibraryBuilder._(this._name, this._scope) : super._();

  /// Adds [directive]'s resulting AST to the source.
  void addDirective(CodeBuilder<Directive> directive) {
    _directives.add(directive);
  }

  @override
  CompilationUnit toAst([_]) {
    var originalAst = super.toAst(_scope);
    if (_name != null) {
      originalAst.directives.add(
        new LibraryDirective(
          null,
          null,
          _library,
          new LibraryIdentifier([_stringIdentifier(_name)]),
          null,
        ),
      );
    }
    originalAst.directives..addAll(_directives.map((d) => d.toAst()));
    originalAst.directives..addAll(_scope.getImports().map((i) => i.toAst()));
    return originalAst;
  }
}

/// Builds a `part of` [CompilationUnit] AST for an existing Dart library.
class PartBuilder extends FileBuilder {
  static final Token _part = new KeywordToken(Keyword.PART, 0);
  static final Token _of = new StringToken(TokenType.KEYWORD, 'of', 0);

  final String _name;

  /// Create a new `part of` source file.
  factory PartBuilder(String name) = PartBuilder._;

  PartBuilder._(this._name) : super._();

  @override
  CompilationUnit toAst([Scope scope = const Scope.identity()]) {
    var originalAst = super.toAst();
    originalAst.directives.add(new PartOfDirective(
      null,
      null,
      _part,
      _of,
      new LibraryIdentifier([_stringIdentifier(_name)]),
      null,
    ));
    return originalAst;
  }
}
