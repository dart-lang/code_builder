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
import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';

import 'src/analyzer_patch.dart';
import 'src/tokens.dart';

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
part 'src/scope.dart';

final DartFormatter _dartfmt = new DartFormatter();

// Simplifies some of the builders by having a mutable node we clone from.
/// Returns [source] formatted by `dartfmt`.
@visibleForTesting
String dartfmt(String source) => _dartfmt.format(source);

SimpleIdentifier _stringIdentifier(String s) =>
    new SimpleIdentifier(stringToken(s));

Literal _stringLiteral(String s) => new SimpleStringLiteral(stringToken(s), s);

/// Base class for building and emitting a Dart language [AstNode].
abstract class CodeBuilder<A extends AstNode> {
  /// Returns a copy-safe [AstNode] representing the current builder state.
  ///
  /// Uses [scope] to output an AST re-written to use appropriate prefixes.
  A toAst([Scope scope = const Scope.identity()]);
}
