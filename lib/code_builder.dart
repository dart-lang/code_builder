// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Code builder is a fluent Dart API for generating valid Dart source code.
///
/// Generally speaking, code generation usually is done through a series of
/// string concatenation which results in messy and sometimes invalid code that
/// is not easily readable.
///
/// Code builder uses the `analyzer` package to create real Dart language ASTs,
/// which, while not guaranteed to be correct, always follows the analyzer's
/// own understood format.
///
/// Code builder also adds a more narrow and user-friendly API. For example
/// creating a class with a method is an easy affair:
///     new ClassBuilder('Animal', extends: 'Organism')
///       ..addMethod(new MethodBuilder.returnVoid('eat')
///         ..setExpression(new ExpressionBuilder.invoke('print',
///           positional: [new LiteralString('Yum!')])));
///
/// Outputs:
///     class Animal extends Organism {
///       void eat() => print('Yum!');
///     }
///
/// This package is in development and APIs are subject to frequent change. See
/// the `README.md` and `CONTRIBUTING.md` for more information.
library code_builder;

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';
import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';

part 'src/builders/annotation_builder.dart';
part 'src/builders/class_builder.dart';
part 'src/builders/constructor_builder.dart';
part 'src/builders/expression_builder.dart';
part 'src/builders/field_builder.dart';
part 'src/builders/file_builder.dart';
part 'src/builders/method_builder.dart';
part 'src/builders/parameter_builder.dart';
part 'src/builders/statement_builder.dart';
part 'src/builders/type_builder.dart';

part 'src/pretty_printer.dart';
part 'src/scope_controller.dart';

/// Base class for building and emitting a Dart language [AstNode].
abstract class CodeBuilder<A extends AstNode> {
  /// Returns a copy-safe [AstNode] representing the current builder state.
  A toAst();
}

// Simplifies some of the builders by having a mutable node we clone from.
abstract class _AbstractCodeBuilder<A extends AstNode> extends CodeBuilder<A> {
  final A _astNode;

  _AbstractCodeBuilder._(this._astNode);

  /// Returns a copy-safe [AstNode] representing the current builder state.
  @override
  A toAst() => _cloneAst/*<A>*/(_astNode);

  @override
  String toString() => '$runtimeType: ${_astNode.toSource()}';
}

/// Marker interface for builders that need an import to work.
///
/// **NOTE**: This currently (as of 0.2.0) has no effect. It is planned that
/// the [FileBuilder] will be able to act as a scope 'resolver' and subtly
/// rewrite the AST tree to use prefixing if required (or requested).
abstract class RequiresImport<A extends AstNode> implements CodeBuilder<A> {
  /// Imports that are required for this AST to work.
  List<String> get requiredImports;

  /// Creates a copy-safe [AstNode] representing the current builder state.
  ///
  /// Uses [scope] to output an AST re-written to use appropriate prefixes.
  A toScopedAst(FileBuilder scope) => throw new UnimplementedError();
}

// Creates a defensive copy of an AST node.
AstNode/*=E*/ _cloneAst/*<E extends AstNode>*/(AstNode/*=E*/ astNode) {
  return new AstCloner().cloneNode/*<E>*/(astNode);
}

final DartFormatter _dartfmt = new DartFormatter();

/// Returns [source] formatted by `dartfmt`.
@visibleForTesting
String dartfmt(String source) => _dartfmt.format(source);

Literal _stringLit(String s) {
  return new SimpleStringLiteral(new StringToken(TokenType.STRING, s, 0), s);
}

Identifier _stringId(String s) {
  return new SimpleIdentifier(new StringToken(TokenType.STRING, s, 0));
}
