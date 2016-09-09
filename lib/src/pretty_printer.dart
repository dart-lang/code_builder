// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Augments [AstNode.toSource] by adding some whitespace/line breaks.
///
/// The final result is run through `dartfmt`.
///
/// This is the _recommended_ output (but not required) when comparing ASTs
/// to expected golden files/text blobs.
String prettyToSource(AstNode astNode) {
  var writer = new PrintStringWriter();
  var visitor = new _PrettyToSourceVisitor(writer);
  astNode.accept(visitor);
  return dartfmt(writer.toString());
}

// TODO(matanl): Remove copied-pasted methods when API becomes available.
// https://github.com/dart-lang/sdk/issues/27169
class _PrettyToSourceVisitor extends ToSourceVisitor {
  // Removed in a new version of the analyzer, but due to dartfmt it's not
  // possible to refer to the newest analyzer and use dartfmt.
  // https://github.com/dart-lang/sdk/issues/27301
  final PrintStringWriter _writer;

  _PrettyToSourceVisitor(PrintStringWriter writer)
      : _writer = writer,
        super(writer);

  @override
  Object visitClassDeclaration(ClassDeclaration node) {
    _visitNodeListWithSeparatorAndSuffix(node.metadata, " ", " ");
    _visitTokenWithSuffix(node.abstractKeyword, " ");
    _writer.print("class ");
    _visitNode(node.name);
    _visitNode(node.typeParameters);
    _visitNodeWithPrefix(" ", node.extendsClause);
    _visitNodeWithPrefix(" ", node.withClause);
    _visitNodeWithPrefix(" ", node.implementsClause);
    _writer.print(" {");
    _visitNodeListWithSeparator(node.members, "\n\n");
    _writer.print("}");
    return null;
  }

  // Safely visit the given [node].
  void _visitNode(AstNode node) {
    if (node != null) {
      node.accept(this);
    }
  }

  // Write a list of [nodes], separated by the given [separator].
  void _visitNodeListWithSeparator(NodeList<AstNode> nodes, String separator) {
    if (nodes != null) {
      int size = nodes.length;
      for (int i = 0; i < size; i++) {
        if (i > 0) {
          _writer.print(separator);
        }
        nodes[i].accept(this);
      }
    }
  }

  // Write a list of [nodes], separated by the given [separator], followed by
  // the given [suffix] if the list is not empty.
  void _visitNodeListWithSeparatorAndSuffix(
      NodeList<AstNode> nodes, String separator, String suffix) {
    if (nodes != null) {
      int size = nodes.length;
      if (size > 0) {
        for (int i = 0; i < size; i++) {
          if (i > 0) {
            _writer.print(separator);
          }
          nodes[i].accept(this);
        }
        _writer.print(suffix);
      }
    }
  }

  // Safely visit the given [node], writing the [prefix] before the node if it
  // is non-`null`.
  void _visitNodeWithPrefix(String prefix, AstNode node) {
    if (node != null) {
      _writer.print(prefix);
      node.accept(this);
    }
  }

  // Safely visit the given [token], writing the [suffix] after the token if it
  // is non-`null`.
  void _visitTokenWithSuffix(Token token, String suffix) {
    if (token != null) {
      _writer.print(token.lexeme);
      _writer.print(suffix);
    }
  }
}
