// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Build a [FormalParameter] AST.
///
/// A parameter is part of a built [MethodBuilder], and can refer to  a
/// class-member (field) variable (see the `field` property in the
/// constructors).
class ParameterBuilder extends _AbstractCodeBuilder<FormalParameter> {
  static final Token _this = new KeywordToken(Keyword.THIS, 0);

  /// Create a new _required_ parameter of [name].
  factory ParameterBuilder(
    String name, {
    bool field: false,
    TypeBuilder type,
  }) {
    FormalParameter astNode;
    if (field) {
      astNode = new FieldFormalParameter(
        null,
        null,
        null,
        type?.toAst(),
        _this,
        null,
        _stringId(name),
        null,
        null,
      );
    } else {
      astNode = new SimpleFormalParameter(
        null,
        null,
        null,
        type?.toAst(),
        _stringId(name),
      );
    }
    return new ParameterBuilder._(astNode);
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

  // Actual implementation of optional and named.
  factory ParameterBuilder._optional(
    String name,
    bool named, {
    bool field: false,
    TypeBuilder type,
    ExpressionBuilder defaultTo,
  }) {
    FormalParameter astNode;
    if (field) {
      astNode = new FieldFormalParameter(
        null,
        null,
        null,
        type?.toAst(),
        _this,
        null,
        _stringId(name),
        null,
        null,
      );
    } else {
      astNode = new SimpleFormalParameter(
        null,
        null,
        null,
        type?.toAst(),
        _stringId(name),
      );
    }
    Token defaultToEq;
    if (defaultTo != null) {
      defaultToEq =
          named ? new Token(TokenType.COLON, 0) : new Token(TokenType.EQ, 0);
    }
    astNode = new DefaultFormalParameter(
      astNode,
      named ? ParameterKind.NAMED : ParameterKind.POSITIONAL,
      defaultToEq,
      defaultTo?.toAst(),
    );
    return new ParameterBuilder._(astNode);
  }

  ParameterBuilder._(FormalParameter astNode) : super._(astNode);

  /// Adds a metadata annotation from [builder].
  void addAnnotation(AnnotationBuilder builder) {
    _astNode.metadata.add(builder.toAst());
  }
}
