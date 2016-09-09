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
  static Token _equals = new Token(TokenType.EQ, 0);
  static Token _semicolon = new Token(TokenType.SEMICOLON, 0);
  static Token _static = new KeywordToken(Keyword.STATIC, 0);
  static Token _final = new KeywordToken(Keyword.FINAL, 0);
  static Token _const = new KeywordToken(Keyword.CONST, 0);
  static Token _var = new KeywordToken(Keyword.VAR, 0);

  final bool _isConst;
  final bool _isFinal;
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
  })
      : this._type = type,
        this._initialize = initialize,
        this._isFinal = false,
        this._isConst = false;

  /// Create a new field builder that emits a `const` field.
  ///
  /// Optionally set a type and initializer.
  FieldBuilder.isConst(
    this._name, {
    TypeBuilder type,
    ExpressionBuilder initialize,
  })
      : this._type = type,
        this._initialize = initialize,
        this._isFinal = false,
        this._isConst = true;

  /// Create a new field builder that emits a `final` field.
  ///
  /// Optionally set a type and initializer.
  FieldBuilder.isFinal(
    this._name, {
    TypeBuilder type,
    ExpressionBuilder initialize,
  })
      : this._type = type,
        this._initialize = initialize,
        this._isFinal = true,
        this._isConst = false;

  Token _getVariableKeyword() {
    if (_isFinal) {
      return _final;
    }
    if (_isConst) {
      return _const;
    }
    return _type == null ? _var : null;
  }

  /// Returns a copy-safe [AstNode] representing the current builder state.
  ///
  /// **NOTE**: This method exists primarily for testing and compatibility with
  /// the [CodeBuilder] ADT. When possible, invoke [toFieldAst] or
  /// [toVariablesAst].
  @override
  @visibleForTesting
  Declaration toAst() => toFieldAst();

  /// Returns a copy-safe [FieldDeclaration] AST representing current state.
  FieldDeclaration toFieldAst({
    bool static: false,
  }) =>
      new FieldDeclaration(
        null,
        null,
        static ? _static : null,
        toVariablesAst(),
        null,
      );

  /// Returns a copy-safe [VariableDeclaration] AST representing current state.
  VariableDeclarationList toVariablesAst() => new VariableDeclarationList(
        null,
        null,
        _getVariableKeyword(),
        _type?.toAst(),
        [
          new VariableDeclaration(
            _stringId(_name),
            _initialize != null ? _equals : null,
            _initialize?.toAst(),
          )
        ],
      );
}
