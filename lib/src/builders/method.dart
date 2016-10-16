// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/class.dart';
import 'package:code_builder/src/builders/parameter.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/type.dart';
import 'package:code_builder/src/tokens.dart';

/// A more short-hand way of constructing a [MethodBuilder].
MethodBuilder method(
  String name, [
  Iterable<ValidMethodMember> members = const [],
]) {
  final List<ParameterBuilder> positional = <ParameterBuilder>[];
  final List<_NamedParameterWrapper> named = <_NamedParameterWrapper>[];
  TypeBuilder returnType;
  for (final member in members) {
    if (member is TypeBuilder) {
      returnType = member;
    } else if (member is ParameterBuilder) {
      positional.add(member);
    } else if (member is _NamedParameterWrapper) {
      named.add(member);
    } else {
      throw new StateError('Invalid AST type: ${member.runtimeType}');
    }
  }
  final method = new _MethodBuilderImpl(
    name,
    returns: returnType,
  );
  positional.forEach(method.addPositional);
  named.forEach((p) => method.addNamed(p._parameter));
  return method;
}

/// Returns a wrapper around [parameter] for use with [method].
_NamedParameterWrapper named(ParameterBuilder parameter) {
  return new _NamedParameterWrapper(parameter);
}

class _NamedParameterWrapper implements ValidConstructorMember, ValidMethodMember {
  final ParameterBuilder _parameter;

  _NamedParameterWrapper(this._parameter);

  @override
  AstNode buildAst([_]) => throw new UnsupportedError('Use within method');
}

/// Lazily builds a method/function AST when the builder is invoked.
abstract class MethodBuilder implements HasAnnotations, HasParameters {
  /// Creates a new [MethodBuilder].
  factory MethodBuilder(String name) = _MethodBuilderImpl;

  /// Creates a new [MethodBuilder] that returns `void`.
  factory MethodBuilder.returnVoid(String name) {
    return new _MethodBuilderImpl(name, returns: core.$void);
  }

  /// Returns a [FunctionDeclaration] AST representing the builder.
  FunctionDeclaration buildFunction([Scope scope]);

  /// Returns an [MethodDeclaration] AST representing the builder.
  MethodDeclaration buildMethod([Scope scope]);
}

/// A marker interface for an AST that could be added to [MethodBuilder].
abstract class ValidMethodMember implements AstBuilder {}

class _MethodBuilderImpl extends Object
    with HasAnnotationsMixin, HasParametersMixin
    implements MethodBuilder {
  final String _name;
  final TypeBuilder _returnType;

  _MethodBuilderImpl(this._name, {TypeBuilder returns}) : _returnType = returns;

  @override
  AstNode buildAst([Scope scope]) => buildFunction(scope);

  @override
  FunctionDeclaration buildFunction([Scope scope]) {
    return new FunctionDeclaration(
      null,
      buildAnnotations(scope),
      null,
      _returnType?.buildType(scope),
      null,
      getIdentifier(scope, _name),
      new FunctionExpression(
        null,
        buildParameterList(scope),
        new EmptyFunctionBody($semicolon),
      ),
    );
  }

  @override
  MethodDeclaration buildMethod([Scope scope]) {
    return new MethodDeclaration(
      null,
      buildAnnotations(scope),
      null,
      null,
      _returnType?.buildType(scope),
      null,
      null,
      getIdentifier(scope, _name),
      null,
      buildParameterList(scope),
      new EmptyFunctionBody($semicolon),
    );
  }
}

/// Returns a wrapper around [parameter] for use with [constructor].
_FieldParameterWrapper fieldFormal(Object parameter) {
  assert(parameter is ParameterBuilder || parameter is _NamedParameterWrapper);
  return new _FieldParameterWrapper(parameter);
}

class _FieldParameterWrapper implements ValidConstructorMember, ValidMethodMember {
  final Object /*ParameterBuilder|_NamedParameterWrapper*/ _parameter;

  _FieldParameterWrapper(this._parameter);

  @override
  AstNode buildAst([_]) => throw new UnsupportedError('Use within method');
}

/// Short-hand for `new ConstructorBuilder(...)`.
ConstructorBuilder constructor([Iterable<ValidConstructorMember> members = const []]) {
  return _constructorImpl(members: members);
}

/// Short-hand for `new ConstructorBuilder(name)`.
ConstructorBuilder constructorNamed(String name, [Iterable<ValidConstructorMember> members = const []]) {
  return _constructorImpl(name: name, members: members);
}

typedef void _AddParameter(ConstructorBuilder constructor);

ConstructorBuilder _constructorImpl({
  Iterable<ValidConstructorMember> members,
  String name,
}) {

  final List<_AddParameter> _addFunctions = <_AddParameter> [];
  for (final member in members) {
    if (member is ParameterBuilder) {
      _addFunctions.add((c) => c.addPositional(member));
    } else if (member is _NamedParameterWrapper) {
      _addFunctions.add((c) => c.addNamed(member._parameter));
    } else if (member is _FieldParameterWrapper) {
      if (member._parameter is _NamedParameterWrapper) {
        _NamedParameterWrapper p = member._parameter;
        _addFunctions.add((c) => c.addNamed(p._parameter, asField: true));
      } else if (member._parameter is ParameterBuilder) {
        _addFunctions.add((c) => c.addPositional(member._parameter, asField: true));
      }
    } else {
      throw new StateError('Invalid AST type: ${member.runtimeType}');
    }
  }
  final constructor = new ConstructorBuilder(name);
  _addFunctions.forEach((a) => a(constructor));
  return constructor;
}

/// A marker interface for an AST that could be added to [ConstructorBuilder].
abstract class ValidConstructorMember implements ValidMethodMember {}

/// Lazily builds an [ConstructorBuilder] AST when built.
abstract class ConstructorBuilder
    implements
        AstBuilder<ConstructorDeclaration>,
        HasParameters,
        ValidClassMember {
  /// Create a new [ConstructorBuilder], optionally with a [name].
  factory ConstructorBuilder([String name]) = _NormalConstructorBuilder;

  @override
  void addNamed(ParameterBuilder parameter, {bool asField: false});

  @override
  void addPositional(ParameterBuilder parameter, {bool asField: false});

  /// Returns an [ConstructorDeclaration] AST representing the builder.
  ConstructorDeclaration buildConstructor(TypeBuilder returnType, [Scope scope]);
}

class _NormalConstructorBuilder
    extends Object
    with HasAnnotationsMixin, HasParametersMixin
    implements ConstructorBuilder {
  final String _name;

  _NormalConstructorBuilder([this._name]);

  @override
  ConstructorDeclaration buildAst([Scope scope]) {
    throw new UnsupportedError('Can only be built as part of a class.');
  }

  @override
  ConstructorDeclaration buildConstructor(TypeBuilder returnType, [Scope scope]) {
    return new ConstructorDeclaration(
      null,
      buildAnnotations(scope),
      null,
      null,
      null,
      returnType.buildType().name,
      _name != null ? $period : null,
      _name != null ? stringIdentifier(_name) : null,
      buildParameterList(scope),
      null,
      null,
      null,
      new EmptyFunctionBody($semicolon),
    );
  }
}
