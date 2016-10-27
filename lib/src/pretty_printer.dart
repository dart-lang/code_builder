// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:dart_style/dart_style.dart';

import 'analyzer_patch.dart';

final _dartFmt = new DartFormatter();

/// Returns [source] formatted by `dartfmt`.
String dartfmt(String source) {
  try {
    return _dartFmt.format(source);
  } on FormatterException catch (_) {
    return _dartFmt.formatStatement(source);
  }
}

/// Augments [AstNode.toSource] by adding some whitespace/line breaks.
///
/// The final result is run through `dartfmt`.
///
/// This is the _recommended_ output (but not required) when comparing ASTs
/// to expected golden files/text blobs.
String prettyToSource(AstNode astNode) {
  var buffer = new PrintBuffer();
  var visitor = new _PrettyToSourceVisitor(buffer);
  astNode.accept(visitor);
  var source = buffer.toString();
  try {
    return dartfmt(source);
  } on FormatterException catch (_) {
    return source;
  }
}

// https://github.com/dart-lang/code_builder/issues/16
class _PrettyToSourceVisitor extends ToSourceVisitor {
  final StringBuffer _buffer;

  _PrettyToSourceVisitor(PrintBuffer buffer)
      : _buffer = buffer,
        super(buffer);

  @override
  Object visitClassDeclaration(ClassDeclaration node) {
    _visitNodeListWithSeparatorAndSuffix(node.metadata, " ", " ");
    _visitTokenWithSuffix(node.abstractKeyword, " ");
    _buffer.write("class ");
    _visitNode(node.name);
    _visitNode(node.typeParameters);
    _visitNodeWithPrefix(" ", node.extendsClause);
    _visitNodeWithPrefix(" ", node.withClause);
    _visitNodeWithPrefix(" ", node.implementsClause);
    _buffer.write(" {");
    _visitNodeListWithSeparator(node.members, "\n\n");
    _buffer.write("}");
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
          _buffer.write(separator);
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
            _buffer.write(separator);
          }
          nodes[i].accept(this);
        }
        _buffer.write(suffix);
      }
    }
  }

  // Safely visit the given [node], writing the [prefix] before the node if it
  // is non-`null`.
  void _visitNodeWithPrefix(String prefix, AstNode node) {
    if (node != null) {
      _buffer.write(prefix);
      node.accept(this);
    }
  }

  // Safely visit the given [token], writing the [suffix] after the token if it
  // is non-`null`.
  void _visitTokenWithSuffix(Token token, String suffix) {
    if (token != null) {
      _buffer.write(token.lexeme);
      _buffer.write(suffix);
    }
  }
}
