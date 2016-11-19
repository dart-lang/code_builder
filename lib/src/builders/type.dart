// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.builders.type;

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/method.dart';
import 'package:code_builder/src/builders/parameter.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/tokens.dart';

part 'type/new_instance.dart';

/// Implements the `new` and `const` constructor calls.
abstract class AbstractTypeBuilderMixin {
  /// Invokes `const` on this type.
  NewInstanceBuilder constInstance(
    Iterable<ExpressionBuilder> positional, [
    Map<String, ExpressionBuilder> named = const {},
  ]) {
    final builder = new NewInstanceBuilder._const(this);
    _addArguments(builder, positional, named);
    return builder;
  }

  /// Invokes `const` on this type with a [name]d constructor.
  NewInstanceBuilder namedConstInstance(
    String name,
    Iterable<ExpressionBuilder> positional, [
    Map<String, ExpressionBuilder> named = const {},
  ]) {
    final builder = new NewInstanceBuilder._const(this, name);
    _addArguments(builder, positional, named);
    return builder;
  }

  /// Invokes `new` on this type.
  NewInstanceBuilder newInstance(
    Iterable<ExpressionBuilder> positional, [
    Map<String, ExpressionBuilder> named = const {},
  ]) {
    final builder = new NewInstanceBuilder._new(this);
    _addArguments(builder, positional, named);
    return builder;
  }

  /// Invokes `new` on this type with a [name]d constructor.
  NewInstanceBuilder namedNewInstance(
    String name,
    Iterable<ExpressionBuilder> positional, [
    Map<String, ExpressionBuilder> named = const {},
  ]) {
    final builder = new NewInstanceBuilder._new(this, name);
    _addArguments(builder, positional, named);
    return builder;
  }

  static void _addArguments(
    NewInstanceBuilder builder,
    Iterable<ExpressionBuilder> positional,
    Map<String, ExpressionBuilder> named,
  ) {
    positional.forEach(builder.addPositionalArgument);
    named.forEach(builder.addNamedArgument);
  }
}

/// Lazily builds an [TypeName] AST when [buildType] is invoked.
class TypeBuilder extends Object
    with AbstractTypeBuilderMixin
    implements AstBuilder, ValidMethodMember, ValidParameterMember {
  final List<TypeBuilder> _generics;
  final String _importFrom;
  final String _name;

  /// Creates a new [TypeBuilder].
  ///
  /// Can be made generic by passing one or more [genericTypes].
  ///
  /// Optionally specify the source to [importFrom] to resolve this type.
  factory TypeBuilder(
    String name, {
    Iterable<TypeBuilder> genericTypes: const [],
    String importFrom,
  }) {
    return new TypeBuilder._(
      name,
      importFrom,
      genericTypes.toList(growable: false),
    );
  }

  TypeBuilder._(
    this._name,
    this._importFrom,
    this._generics,
  );

  @override
  AstNode buildAst([Scope scope]) => buildType(scope);

  /// Returns an [TypeName] AST representing the builder.
  TypeName buildType([Scope scope]) {
    return new TypeName(
      identifier(
        scope,
        _name,
        _importFrom,
      ),
      _generics.isEmpty
          ? null
          : new TypeArgumentList(
              $openBracket,
              _generics.map((t) => t.buildType(scope)).toList(),
              $closeBracket,
            ),
    );
  }
}
