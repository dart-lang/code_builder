// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds either a [FieldDeclaration] or [VariableDeclaration] AST.
///
/// While the API is the same, you may specifically ask for either a field
/// AST (for class members) via [toFieldAst] or a variable declaration (used
/// both at the top-level and within methods) via [toVariablesAst].
class FieldBuilder implements CodeBuilder<Declaration> {
  final bool _isConst;
  final bool _isFinal;
  final bool _isStatic;
  final ExpressionBuilder _initialize;
  final String _name;
  final TypeBuilder _type;

  /// Create a new field builder.
  ///
  /// Optionally set a type and initializer.
  FieldBuilder(
    this._name, {
    TypeBuilder type,
    ExpressionBuilder initialize,
    bool asStatic: false,
  })
      : this._type = type,
        this._initialize = initialize,
        this._isFinal = false,
        this._isConst = false,
        this._isStatic = asStatic;

  /// Create a new field builder that emits a `const` field.
  ///
  /// Optionally set a type and initializer.
  FieldBuilder.isConst(
    this._name, {
    TypeBuilder type,
    ExpressionBuilder initialize,
    bool asStatic: false,
  })
      : this._type = type,
        this._initialize = initialize,
        this._isFinal = false,
        this._isConst = true,
        this._isStatic = false;

  /// Create a new field builder that emits a `final` field.
  ///
  /// Optionally set a type and initializer.
  FieldBuilder.isFinal(
    this._name, {
    TypeBuilder type,
    ExpressionBuilder initialize,
    bool asStatic: false,
  })
      : this._type = type,
        this._initialize = initialize,
        this._isFinal = true,
        this._isConst = false,
        this._isStatic = asStatic;

  /// Returns a copy-safe [AstNode] representing the current builder state.
  ///
  /// **NOTE**: This method exists primarily for testing and compatibility with
  /// the [CodeBuilder] ADT. When possible, invoke [toFieldAst] or
  /// [toVariablesAst].
  @override
  @visibleForTesting
  Declaration toAst([Scope scope = const Scope.identity()]) =>
      toFieldAst(scope);

  /// Returns a copy-safe [FieldDeclaration] AST representing current state.
  FieldDeclaration toFieldAst([Scope scope = const Scope.identity()]) =>
      new FieldDeclaration(
        null,
        null,
        _isStatic ? $static : null,
        toVariablesAst(scope),
        null,
      );

  /// Returns a copy-safe [VariableDeclaration] AST representing current state.
  VariableDeclarationList toVariablesAst(
          [Scope scope = const Scope.identity()]) =>
      new VariableDeclarationList(
        null,
        null,
        _getVariableKeyword(),
        _type?.toAst(scope),
        [
          new VariableDeclaration(
            _stringIdentifier(_name),
            _initialize != null ? $equals : null,
            _initialize?.toAst(scope),
          )
        ],
      );

  Token _getVariableKeyword() {
    if (_isFinal) {
      return $final;
    }
    if (_isConst) {
      return $const;
    }
    return _type == null ? $var : null;
  }
}
