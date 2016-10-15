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

export 'src/builders/annotation.dart' show annotation, AnnotationBuilder;
export 'src/builders/class.dart'
    show
        clazz,
        constructor,
        constructorNamed,
        initializer,
        ClassBuilder,
        ConstructorBuilder;
export 'src/builders/expression.dart' show ExpressionBuilder, literal;
export 'src/builders/parameter.dart' show parameter, ParameterBuilder;
export 'src/builders/reference.dart' show reference;
export 'src/builders/statement.dart' show StatementBuilder;
export 'src/builders/type.dart' show type, TypeBuilder;

part 'src/pretty_printer.dart';
part 'src/scope.dart';

final DartFormatter _dartfmt = new DartFormatter();

// Simplifies some of the builders by having a mutable node we clone from.
/// Returns [source] formatted by `dartfmt`.
@visibleForTesting
String dartfmt(String source) {
  try {
    return _dartfmt.format(source);
  } on FormatterException catch (_) {
    return _dartfmt.formatStatement(source);
  }
}

SimpleIdentifier _stringIdentifier(String s) =>
    new SimpleIdentifier(stringToken(s));

/// A builder that emits a _specific_ Dart language [AstNode].
abstract class AstBuilder {
  /// Returns a copy-safe [AstNode] representing the current builder state.
  ///
  /// Uses [scope] to output an AST re-written to use appropriate prefixes.
  AstNode buildAst([Scope scope = Scope.identity]);
}

/// Base class for building and emitting a Dart language [AstNode].
abstract class CodeBuilder<A extends AstNode> {
  /// Returns a copy-safe [AstNode] representing the current builder state.
  ///
  /// Uses [scope] to output an AST re-written to use appropriate prefixes.
  A build([Scope scope = Scope.identity]);
}
