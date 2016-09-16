// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Build a [FormalParameter] AST.
///
/// A parameter is part of a built [MethodBuilder], and can refer to  a
/// class-member (field) variable (see the `field` property in the
/// constructors).
class ParameterBuilder extends ScopeAware<FormalParameter> {
  static final Token _this = new KeywordToken(Keyword.THIS, 0);

  final String _name;
  final bool _isField;
  final bool _isOptional;
  final bool _isNamed;
  final TypeBuilder _type;
  final ExpressionBuilder _defaultTo;

  final List<AnnotationBuilder> _annotations = <AnnotationBuilder>[];

  /// Create a new _required_ parameter of [name].
  factory ParameterBuilder(
    String name, {
    bool field: false,
    TypeBuilder type,
  }) {
    return new ParameterBuilder._(
      name,
      field,
      false,
      false,
      type,
      null,
    );
  }

  /// Create a new _optional_ _named_ parameter.
  factory ParameterBuilder.named(
    String name, {
    bool field: false,
    TypeBuilder type,
    ExpressionBuilder defaultTo,
  }) {
    return new ParameterBuilder._optional(
      name,
      true,
      field: field,
      type: type,
      defaultTo: defaultTo,
    );
  }

  /// Create a new _optional_ (but positional) parameter.
  ///
  /// See [ParameterBuilder.named] for an optional _named_ parameter.
  factory ParameterBuilder.optional(
    String name, {
    bool field: false,
    TypeBuilder type,
    ExpressionBuilder defaultTo,
  }) {
    return new ParameterBuilder._optional(
      name,
      false,
      field: field,
      type: type,
      defaultTo: defaultTo,
    );
  }

  ParameterBuilder._(
    this._name,
    this._isField,
    this._isOptional,
    this._isNamed,
    this._type,
    this._defaultTo,
  );

  // Actual implementation of optional and named.
  factory ParameterBuilder._optional(
    String name,
    bool named, {
    bool field: false,
    TypeBuilder type,
    ExpressionBuilder defaultTo,
  }) {
    return new ParameterBuilder._(
      name,
      field,
      true,
      named,
      type,
      defaultTo,
    );
  }

  /// Adds a metadata annotation from [builder].
  void addAnnotation(AnnotationBuilder builder) {
    _annotations.add(builder);
  }

  @override
  FormalParameter toScopedAst(Scope scope) {
    FormalParameter astNode;
    if (_isField) {
      astNode = _createFieldFormalParameter(scope);
    } else {
      astNode = _createSimpleFormalParameter(scope);
    }
    if (_isOptional) {
      astNode = _createDefaultFormalParameter(
        astNode,
        _isNamed,
        _defaultTo,
        scope,
      );
    }
    astNode.metadata.addAll(_annotations.map/*<Annotation>*/((a) => a.toAst()));
    return astNode;
  }

  static DefaultFormalParameter _createDefaultFormalParameter(
    FormalParameter parameter,
    bool named,
    ExpressionBuilder defaultTo,
    Scope scope,
  ) {
    return new DefaultFormalParameter(
      parameter,
      named ? ParameterKind.NAMED : ParameterKind.POSITIONAL,
      defaultTo != null
          ? named ? new Token(TokenType.COLON, 0) : new Token(TokenType.EQ, 0)
          : null,
      defaultTo?.toAst(),
    );
  }

  FieldFormalParameter _createFieldFormalParameter(Scope scope) =>
      new FieldFormalParameter(
        null,
        null,
        null,
        _type?.toScopedAst(scope),
        _this,
        null,
        _stringId(_name),
        null,
        null,
      );

  SimpleFormalParameter _createSimpleFormalParameter(Scope scope) =>
      new SimpleFormalParameter(
        null,
        null,
        null,
        _type?.toScopedAst(scope),
        _stringId(_name),
      );
}
