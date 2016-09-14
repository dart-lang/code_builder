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

/// Builds files of Dart source code.
///
/// See [LibraryBuilder] and [PartBuilder] for concrete implementations.
abstract class FileBuilder extends _AbstractCodeBuilder<CompilationUnit> {
  FileBuilder._(CompilationUnit astNode) : super._(astNode);

  /// Adds [declaration]'s resulting AST to the source.
  void addDeclaration(CodeBuilder<Declaration> declaration) {
    _astNode.declarations.add(declaration.toAst());
  }

  /// Adds [directive]'s resulting AST to the source.
  void addDirective(CodeBuilder<Directive> directive) {
    _astNode.directives.add(directive.toAst());
  }
}

/// Builds a standalone Dart library [CompilationUnit] AST.
class LibraryBuilder extends FileBuilder {
  static final Token _library = new KeywordToken(Keyword.LIBRARY, 0);

  /// Create a new standalone Dart library, optionally with a [name].
  factory LibraryBuilder([String name]) {
    var astNode = _emptyCompilationUnit();
    if (name != null) {
      astNode.directives.add(new LibraryDirective(
          null,
          null,
          _library,
          new LibraryIdentifier([_stringId(name)]),
          null,));
    }
    return new LibraryBuilder._(astNode);
  }

  LibraryBuilder._(CompilationUnit astNode) : super._(astNode);
}

/// Builds a `part of` [CompilationUnit] AST for an existing Dart library.
class PartBuilder extends FileBuilder {
  static final Token _part = new KeywordToken(Keyword.PART, 0);
  static final Token _of = new StringToken(TokenType.KEYWORD, 'of', 0);

  /// Create a new `part of` source file.
  factory PartBuilder(String name) {
    var astNode = _emptyCompilationUnit();
    astNode.directives.add(new PartOfDirective(
        null,
        null,
        _part,
        _of,
        new LibraryIdentifier([_stringId(name)]),
        null,
        ));
    return new PartBuilder._(astNode);
  }

  PartBuilder._(CompilationUnit astNode) : super._(astNode);
}
/// An `export` directive in a [LibraryBuilder].
class ExportBuilder extends _AbstractCodeBuilder<ExportDirective> {
  /// Create a new `export` directive exporting [uri].
  factory ExportBuilder(String uri) {
    var astNode = _createExportDirective()..uri = _stringLit("'$uri'");
    return new ExportBuilder._(astNode);
  }

  ExportBuilder._(ExportDirective astNode) : super._(astNode);

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

/// An `import` directive in a [FileBuilder].
class ImportBuilder extends _AbstractCodeBuilder<ImportDirective> {
  static Token _as = new KeywordToken(Keyword.AS, 0);

  /// Create a new `import` directive importing [uri].
  ///
  /// Optionally prefix [as].
  factory ImportBuilder(String uri, {String as}) {
    var astNode = _createImportDirective()..uri = _stringLit("'$uri'");
    if (as != null) {
      astNode
        ..asKeyword = _as
        ..prefix = _stringId(as);
    }
    return new ImportBuilder._(astNode);
  }

  ImportBuilder._(ImportDirective astNode) : super._(astNode);

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
