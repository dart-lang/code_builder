// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/class.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/parameter.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/builders/type.dart';
import 'package:code_builder/src/tokens.dart';

/// Short-hand for `new ConstructorBuilder(...)`.
ConstructorBuilder constructor([
  Iterable<ValidConstructorMember> members = const [],
]) {
  return _constructorImpl(members: members);
}

/// Short-hand for `new ConstructorBuilder(name)`.
ConstructorBuilder constructorNamed(
  String name, [
  Iterable<ValidConstructorMember> members = const [],
]) {
  return _constructorImpl(name: name, members: members);
}

/// Various types of modifiers for methods.
class MethodModifier implements ValidMethodMember {
  static const MethodModifier async = const MethodModifier._('async', false);
  static const MethodModifier asyncStar = const MethodModifier._('async', true);
  static const MethodModifier syncStar = const MethodModifier._('sync', true);

  final String _keyword;

  const MethodModifier._(this._keyword, this.isStar);

  @override
  buildAst([_]) => throw new UnsupportedError('Not an AST');

  final bool isStar;

  Token keyword() => new StringToken(TokenType.KEYWORD, _keyword, 0);
}

/// Short-hand for `new MethodBuilder.getter(...)`.
MethodBuilder getter(
  String name, {
  MethodModifier modifier,
  Iterable<StatementBuilder> statements,
  ExpressionBuilder returns,
  TypeBuilder returnType,
}) {
  if (returns != null) {
    return new MethodBuilder.getter(
      name,
      modifier: modifier,
      returnType: returnType,
      returns: returns,
    );
  } else {
    return new MethodBuilder.getter(
      name,
      modifier: modifier,
      returnType: returnType,
    )..addStatements(statements);
  }
}

/// A more short-hand way of constructing a Lambda [MethodBuilder].
MethodBuilder lambda(
  String name,
  ExpressionBuilder value, {
  MethodModifier modifier,
  TypeBuilder returnType,
}) {
  return new MethodBuilder(
    name,
    modifier: modifier,
    returns: value,
    returnType: returnType,
  );
}

/// A more short-hand way of constructing a [MethodBuilder].
MethodBuilder method(
  String name, [
  Iterable<ValidMethodMember> members = const [],
]) {
  final List<ParameterBuilder> positional = <ParameterBuilder>[];
  final List<_NamedParameterWrapper> named = <_NamedParameterWrapper>[];
  final List<StatementBuilder> statements = <StatementBuilder>[];
  MethodModifier modifier;
  TypeBuilder returnType;
  for (final member in members) {
    if (member is TypeBuilder) {
      returnType = member;
    } else if (member is ParameterBuilder) {
      positional.add(member);
    } else if (member is _NamedParameterWrapper) {
      named.add(member);
    } else if (member is StatementBuilder) {
      statements.add(member);
    } else if (member is MethodModifier) {
      modifier = member;
    } else {
      throw new StateError('Invalid AST type: ${member.runtimeType}');
    }
  }
  final method = new _MethodBuilderImpl(
    name,
    modifier: modifier,
    returns: returnType,
  );
  positional.forEach(method.addPositional);
  named.forEach((p) => method.addNamed(p._parameter));
  statements.forEach(method.addStatement);
  return method;
}

/// Returns a wrapper around [parameter] for use with [method].
_NamedParameterWrapper named(ParameterBuilder parameter) {
  return new _NamedParameterWrapper(parameter);
}

/// Short-hand for `new MethodBuilder.setter(...)`.
MethodBuilder setter(
  String name,
  ParameterBuilder value,
  Iterable<StatementBuilder> statements,
) {
  return new MethodBuilder.setter(name)
    ..addPositional(value)
    ..addStatements(statements);
}

/// Returns a wrapper around [parameter] for use with [constructor].
_FieldParameterWrapper thisField(Object parameter) {
  assert(parameter is ParameterBuilder || parameter is _NamedParameterWrapper);
  return new _FieldParameterWrapper(parameter);
}

ConstructorBuilder _constructorImpl({
  Iterable<ValidConstructorMember> members,
  String name,
}) {
  final List<_AddParameter> _addFunctions = <_AddParameter>[];
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
        _addFunctions
            .add((c) => c.addPositional(member._parameter, asField: true));
      }
    } else if (member is StatementBuilder) {
      _addFunctions.add((c) => c.addStatement(member));
    } else {
      throw new StateError('Invalid AST type: ${member.runtimeType}');
    }
  }
  final constructor = new ConstructorBuilder(name);
  _addFunctions.forEach((a) => a(constructor));
  return constructor;
}

typedef void _AddParameter(ConstructorBuilder constructor);

/// Lazily builds an [ConstructorBuilder] AST when built.
abstract class ConstructorBuilder
    implements
        AstBuilder<ConstructorDeclaration>,
        HasParameters,
        HasStatements,
        ValidClassMember {
  /// Create a new [ConstructorBuilder], optionally with a [name].
  factory ConstructorBuilder([String name]) = _NormalConstructorBuilder;

  @override
  void addNamed(ParameterBuilder parameter, {bool asField: false});

  @override
  void addPositional(ParameterBuilder parameter, {bool asField: false});

  /// Returns an [ConstructorDeclaration] AST representing the builder.
  ConstructorDeclaration buildConstructor(
    TypeBuilder returnType, [
    Scope scope,
  ]);
}

/// Lazily builds a method/function AST when the builder is invoked.
abstract class MethodBuilder
    implements
        ExpressionBuilder,
        HasAnnotations,
        HasParameters,
        HasStatements,
        ValidClassMember {
  /// Creates a new [MethodBuilder].
  factory MethodBuilder(
    String name, {
    MethodModifier modifier,
    ExpressionBuilder returns,
    TypeBuilder returnType,
  }) {
    if (returns != null) {
      return new _LambdaMethodBuilder(
        name,
        returns,
        returnType,
        null,
        modifier,
      );
    } else {
      return new _MethodBuilderImpl(
        name,
        modifier: modifier,
        returns: returnType,
      );
    }
  }

  /// Creates a new [MethodBuilder] that returns an anonymous closure.
  factory MethodBuilder.closure({
    MethodModifier modifier,
    ExpressionBuilder returns,
    TypeBuilder returnType,
  }) {
    if (returns != null) {
      return new _LambdaMethodBuilder(
        null,
        returns,
        returnType,
        null,
        modifier,
      );
    } else {
      return new _MethodBuilderImpl(
        null,
        modifier: modifier,
        returns: returnType,
      );
    }
  }

  /// Creates a getter.
  factory MethodBuilder.getter(
    String name, {
    MethodModifier modifier,
    TypeBuilder returnType,
    ExpressionBuilder returns,
  }) {
    if (returns == null) {
      return new _MethodBuilderImpl(
        name,
        modifier: modifier,
        returns: returnType,
        property: Keyword.GET,
      );
    } else {
      return new _LambdaMethodBuilder(
        name,
        returns,
        returnType,
        Keyword.GET,
        modifier,
      );
    }
  }

  /// Creates a new [MethodBuilder] that returns `void`.
  factory MethodBuilder.returnVoid(String name, {ExpressionBuilder returns}) {
    if (returns == null) {
      return new _MethodBuilderImpl(name, returns: lib$core.$void);
    }
    return new _LambdaMethodBuilder(
      name,
      returns,
      lib$core.$void,
      null,
      null,
    );
  }

  /// Creates a setter.
  factory MethodBuilder.setter(
    String name, {
    ExpressionBuilder returns,
  }) {
    if (returns == null) {
      return new _MethodBuilderImpl(
        name,
        property: Keyword.SET,
      );
    } else {
      return new _LambdaMethodBuilder(
        name,
        returns,
        null,
        Keyword.SET,
        null,
      );
    }
  }

  /// Returns a [FunctionDeclaration] AST representing the builder.
  FunctionDeclaration buildFunction([Scope scope]);

  /// Returns an [MethodDeclaration] AST representing the builder.
  MethodDeclaration buildMethod(bool static, [Scope scope]);
}

/// A marker interface for an AST that could be added to [ConstructorBuilder].
abstract class ValidConstructorMember implements ValidMethodMember {}

/// A marker interface for an AST that could be added to [MethodBuilder].
abstract class ValidMethodMember implements AstBuilder {}

class _FieldParameterWrapper
    implements ValidConstructorMember, ValidMethodMember {
  final Object /*ParameterBuilder|_NamedParameterWrapper*/ _parameter;

  _FieldParameterWrapper(this._parameter);

  @override
  AstNode buildAst([_]) => throw new UnsupportedError('Use within method');
}

class _LambdaMethodBuilder extends Object
    with
        AbstractExpressionMixin,
        HasAnnotationsMixin,
        HasParametersMixin,
        TopLevelMixin
    implements MethodBuilder {
  final ExpressionBuilder _expression;
  final MethodModifier _modifier;
  final String _name;
  final TypeBuilder _returnType;
  final Keyword _property;

  _LambdaMethodBuilder(
    this._name,
    this._expression,
    this._returnType,
    this._property,
    this._modifier,
  );

  @override
  void addStatement(StatementBuilder statement) {
    throw new UnsupportedError('Cannot add statement on a Lambda method');
  }

  @override
  void addStatements(Iterable<StatementBuilder> statements) {
    throw new UnsupportedError('Cannot add statement on a Lambda method');
  }

  @override
  AstNode buildAst([Scope scope]) {
    if (_name != null) {
      return buildFunction(scope);
    }
    return buildExpression(scope);
  }

  @override
  Expression buildExpression([Scope scope]) {
    return _buildExpression(scope, isStatement: false);
  }

  FunctionExpression _buildExpression(Scope scope, {bool isStatement}) {
    return new FunctionExpression(
      null,
      _property != Keyword.GET ? buildParameterList(scope) : null,
      new ExpressionFunctionBody(
        _modifier?.keyword(),
        null,
        _expression.buildExpression(scope),
        isStatement ? $semicolon : null,
      ),
    );
  }

  @override
  FunctionDeclaration buildFunction([Scope scope]) {
    return new FunctionDeclaration(
      null,
      buildAnnotations(scope),
      null,
      _returnType?.buildType(scope),
      _property != null ? new KeywordToken(_property, 0) : null,
      stringIdentifier(_name),
      _buildExpression(scope, isStatement: true),
    );
  }

  @override
  MethodDeclaration buildMethod(bool static, [Scope scope]) {
    return new MethodDeclaration(
      null,
      buildAnnotations(scope),
      null,
      static ? $static : null,
      _returnType?.buildType(scope),
      _property != null ? new KeywordToken(_property, 0) : null,
      null,
      stringIdentifier(_name),
      null,
      _property != Keyword.GET ? buildParameterList(scope) : null,
      new ExpressionFunctionBody(
        _modifier?.keyword(),
        null,
        _expression.buildExpression(scope),
        $semicolon,
      ),
    );
  }

  @override
  CompilationUnitMember buildTopLevelAst([Scope scope]) => buildFunction(scope);
}

class _MethodBuilderImpl extends Object
    with
        AbstractExpressionMixin,
        HasAnnotationsMixin,
        HasParametersMixin,
        HasStatementsMixin,
        TopLevelMixin
    implements MethodBuilder {
  final MethodModifier _modifier;
  final String _name;
  final TypeBuilder _returnType;
  final Keyword _property;

  _MethodBuilderImpl(
    this._name, {
    MethodModifier modifier,
    TypeBuilder returns,
    Keyword property,
  })
      : _modifier = modifier,
        _returnType = returns,
        _property = property;

  @override
  AstNode buildAst([Scope scope]) {
    if (_name != null) {
      return buildFunction(scope);
    }
    return buildExpression(scope);
  }

  @override
  Expression buildExpression([Scope scope]) {
    return new FunctionExpression(
      null,
      _property != Keyword.GET ? buildParameterList(scope) : null,
      new BlockFunctionBody(
        _modifier?.keyword(),
        _modifier?.isStar == true ? $star : null,
        buildBlock(scope),
      ),
    );
  }

  @override
  FunctionDeclaration buildFunction([Scope scope]) {
    return new FunctionDeclaration(
      null,
      buildAnnotations(scope),
      null,
      _returnType?.buildType(scope),
      _property != null ? new KeywordToken(_property, 0) : null,
      stringIdentifier(_name),
      buildExpression(scope),
    );
  }

  @override
  MethodDeclaration buildMethod(bool static, [Scope scope]) {
    return new MethodDeclaration(
      null,
      buildAnnotations(scope),
      null,
      static ? $static : null,
      _returnType?.buildType(scope),
      _property != null ? new KeywordToken(_property, 0) : null,
      null,
      identifier(scope, _name),
      null,
      _property != Keyword.GET ? buildParameterList(scope) : null,
      new BlockFunctionBody(
        _modifier?.keyword(),
        _modifier?.isStar == true ? $star : null,
        buildBlock(scope),
      ),
    );
  }

  @override
  CompilationUnitMember buildTopLevelAst([Scope scope]) => buildFunction(scope);
}

class _NamedParameterWrapper
    implements ValidConstructorMember, ValidMethodMember {
  final ParameterBuilder _parameter;

  _NamedParameterWrapper(this._parameter);

  @override
  AstNode buildAst([_]) => throw new UnsupportedError('Use within method');
}

class _NormalConstructorBuilder extends Object
    with HasAnnotationsMixin, HasParametersMixin, HasStatementsMixin
    implements ConstructorBuilder {
  final String _name;

  _NormalConstructorBuilder([this._name]);

  @override
  ConstructorDeclaration buildAst([Scope scope]) {
    throw new UnsupportedError('Can only be built as part of a class.');
  }

  @override
  ConstructorDeclaration buildConstructor(TypeBuilder returnType,
      [Scope scope]) {
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
      !hasStatements
          ? new EmptyFunctionBody($semicolon)
          : new BlockFunctionBody(
              null,
              null,
              buildBlock(scope),
            ),
    );
  }
}
