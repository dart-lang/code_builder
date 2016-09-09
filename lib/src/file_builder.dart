// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds files of Dart source code.
///
/// Files may either be a standalone library or `part of` another library.
class FileBuilder extends _AbstractCodeBuilder<CompilationUnit> {
  static Token _library = new KeywordToken(Keyword.LIBRARY, 0);
  static Token _part = new KeywordToken(Keyword.PART, 0);
  static Token _of = new StringToken(TokenType.KEYWORD, 'of', 0);

  /// Create a new standalone Dart library, optionally with a [name].
  factory FileBuilder([String name]) {
    var astNode = _emptyCompilationUnit();
    if (name != null) {
      astNode.directives.add(new LibraryDirective(
        null,
        null,
        _library,
        new LibraryIdentifier([_stringId(name)]),
        null,
      ));
    }
    return new FileBuilder._(astNode);
  }

  /// Create a new `part of` the dart library with [name].
  factory FileBuilder.partOf(String name) {
    var astNode = _emptyCompilationUnit();
    astNode.directives.add(new PartOfDirective(
      null,
      null,
      _part,
      _of,
      new LibraryIdentifier([_stringId(name)]),
      null,
    ));
    return new FileBuilder._(astNode);
  }

  FileBuilder._(CompilationUnit astNode) : super._(astNode);

  /// Add a copy of [clazz] as a declaration in this file.
  void addClass(ClassBuilder clazz) {
    _astNode.declarations.add(clazz.toAst());
  }

  /// Adds an `import` or `export` [directive].
  void addDirective(CodeBuilder<Directive> directive) {
    if (isPartOf) {
      throw const DartPartFileException._();
    }
    _astNode.directives.add(directive.toAst());
  }

  static CompilationUnit _emptyCompilationUnit() => new CompilationUnit(
        null,
        null,
        null,
        null,
        null,
      );

  static bool _isPartOf(Directive d) => d is PartOfDirective;

  /// Whether the file is `part of` another.
  bool get isPartOf => _astNode.directives.contains(_isPartOf);
}

/// An `export` directive in a [FileBuilder].
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

/// Thrown when an invalid operation is attempted on a [FileBuilder] instance.
class DartPartFileException implements Exception {
  const DartPartFileException._();

  @override
  String toString() => 'Not a valid operation for a `part of` file.';
}
