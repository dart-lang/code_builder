// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds either a [MethodDeclaration] or a [FunctionDeclaration].
///
/// While the API is the same, you may specifically ask for either a method
/// AST (for class members) via [toMethodAst] or a function AST (used both at
/// the top level and within other methods) via [toFunctionAst].
///
/// To return nothing (`void`), use [MethodBuilder.returnVoid].
class MethodBuilder implements CodeBuilder<Declaration> {
  static Token _abstract = new KeywordToken(Keyword.ABSTRACT, 0);
  static Token _semicolon = new Token(TokenType.SEMICOLON, 0);
  static Token _static = new KeywordToken(Keyword.STATIC, 0);

  // Void is a "type" that is only valid as a return type on a method.
  static const TypeBuilder _typeVoid = const TypeBuilder('void');

  final List<AnnotationBuilder> _annotations = <AnnotationBuilder>[];
  final String _name;
  final List<ParameterBuilder> _parameters = <ParameterBuilder>[];
  final List<StatementBuilder> _statements = <StatementBuilder>[];

  final bool _isAbstract;
  final bool _isStatic;

  ExpressionBuilder _returnExpression;
  TypeBuilder _returnType;

  /// Create a new method builder,
  ///
  /// Optionally set a [returns] type.
  factory MethodBuilder({
    String name,
    TypeBuilder returns,
    bool abstract: false,
    bool static: false,
  }) {
    return new MethodBuilder._(name, returns, static, abstract);
  }

  /// Creates a `void`-returning MethodBuilder with [name].
  factory MethodBuilder.returnVoid({
    String name,
    bool abstract: false,
    bool static: false,
  }) {
    return new MethodBuilder._(name, _typeVoid, static, abstract);
  }

  MethodBuilder._(
    this._name,
    this._returnType,
    this._isStatic,
    this._isAbstract,
  );

  /// Lazily adds [annotation].
  ///
  /// When the method is emitted as an AST, [AnnotationBuilder.toAst] is used.
  void addAnnotation(AnnotationBuilder annotation) {
    _annotations.add(annotation);
  }

  /// Lazily adds [parameter].
  ///
  /// When the method is emitted as an AST, [ParameterBuilder.toAst] is used.
  void addParameter(ParameterBuilder parameter) {
    _parameters.add(parameter);
  }

  /// Lazily adds [statement].
  ///
  /// When the method is emitted as an AST, [StatementBuilder.toAst] is used.
  void addStatement(StatementBuilder statement) {
    _statements.add(statement);
  }

  /// Lazily sets [expression] as the lambda result of this method invocation.
  ///
  /// When the method is emitted as an AST, [ExpressionBuilder.toAst] is used.
  void setExpression(ExpressionBuilder expression) {
    _returnExpression = expression;
  }

  /// Returns a copy-safe [AstNode] representing the current builder state.
  ///
  /// **NOTE**: This method exists primarily for testing and compatibility with
  /// the [CodeBuilder] ADT. When possible, invoke [toFunctionAst] or
  /// [toMethodAst].
  @override
  @visibleForTesting
  Declaration toAst([Scope scope = const Scope.identity()]) =>
      toFunctionAst(scope);

  /// Returns a copy-safe [FunctionDeclaration] AST representing current state.
  FunctionDeclaration toFunctionAst([Scope scope = const Scope.identity()]) {
    var functionAst = _emptyFunction()
      ..metadata.addAll(_annotations.map/*<Annotation>*/((a) => a.toAst(scope)))
      ..name = _stringId(_name)
      ..returnType = _returnType?.toAst(scope);
    if (_returnExpression != null) {
      functionAst.functionExpression = _returnExpression.toFunctionExpression();
    } else {
      functionAst.functionExpression = new FunctionExpression(
        null,
        _emptyParameters(),
        _blockBody(_statements.map/*<Statement>*/((s) => s.toAst(scope))),
      );
    }
    if (_parameters.isNotEmpty) {
      functionAst.functionExpression.parameters.parameters
          .addAll(_parameters.map/*<FormalParameter>*/((p) => p.toAst(scope)));
    }
    return functionAst;
  }

  /// Returns a copy-safe [FunctionDeclaration] AST representing current state.
  MethodDeclaration toMethodAst([Scope scope = const Scope.identity()]) {
    var methodAst = _emptyMethod()
      ..metadata.addAll(_annotations.map/*<Annotation>*/((a) => a.toAst(scope)))
      ..name = _stringId(_name)
      ..returnType = _returnType?.toAst(scope);
    FunctionBody methodBody = _returnExpression?.toFunctionBody(scope);
    if (_isStatic) {
      methodAst.modifierKeyword = _static;
      if (methodBody == null) {
        methodBody = _blockBody();
      }
    }
    if (methodBody == null) {
      methodBody = _isAbstract
          ? new EmptyFunctionBody(_semicolon)
          : _blockBody(_statements.map/*<Statement>*/((s) => s.toAst(scope)));
    }
    if (_parameters.isNotEmpty) {
      methodAst.parameters.parameters
          .addAll(_parameters.map/*<FormalParameter>*/((p) => p.toAst(scope)));
    }
    methodAst.body = methodBody;
    return methodAst;
  }

  @override
  String toString() => 'MethodBuilder ${toAst().toSource()}';

  static FunctionBody _blockBody([Iterable<Statement> statements]) =>
      new BlockFunctionBody(
        null,
        null,
        new Block(
          new Token(TokenType.OPEN_CURLY_BRACKET, 0),
          statements?.toList(),
          new Token(TokenType.CLOSE_CURLY_BRACKET, 0),
        ),
      );

  static FunctionDeclaration _emptyFunction() => new FunctionDeclaration(
        null,
        null,
        null,
        null,
        null,
        null,
        new FunctionExpression(
          null,
          _emptyParameters(),
          _blockBody(),
        ),
      );
  // TODO: implement requiredImports
  static MethodDeclaration _emptyMethod() => new MethodDeclaration(
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        _emptyParameters(),
        null,
      );

  static FormalParameterList _emptyParameters() => new FormalParameterList(
        new Token(TokenType.OPEN_PAREN, 0),
        [],
        null,
        null,
        new Token(TokenType.CLOSE_PAREN, 0),
      );
}
