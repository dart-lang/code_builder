// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds a [ConstructorDeclaration] AST.
///
/// Similar to [MethodBuilder] but with constructor-only features.
class ConstructorBuilder implements CodeBuilder<ConstructorDeclaration> {
  final bool _isConstant;
  final String _name;

  final List<AnnotationBuilder> _annotations = <AnnotationBuilder>[];
  final List<ParameterBuilder> _parameters = <ParameterBuilder>[];
  final List<StatementBuilder> _statements = <StatementBuilder>[];

  /// Create a new builder for a constructor, optionally with a [name].
  factory ConstructorBuilder([String name]) {
    return new ConstructorBuilder._(false, name);
  }

  /// Create a new builder for a constructor, optionally with a [name].
  ///
  /// The resulting constructor will be `const`.
  factory ConstructorBuilder.isConst([String name]) {
    return new ConstructorBuilder._(true, name);
  }

  ConstructorBuilder._(this._isConstant, this._name);

  /// Lazily adds [annotation].
  ///
  /// When the method is emitted as an AST, [AnnotationBuilder.toAst] is used.
  void addAnnotation(AnnotationBuilder annotation) {
    _annotations.add(annotation);
  }

  /// Lazily adds [builder].
  ///
  /// When the method is emitted as an AST, [ParameterBuilder.toAst] is used.
  void addParameter(ParameterBuilder builder) {
    _parameters.add(builder);
  }

  /// Lazily adds [statement].
  ///
  /// When the method is emitted as an AST, [StatementBuilder.toAst] is used.
  void addStatement(StatementBuilder statement) {
    _statements.add(statement);
  }

  @override
  ConstructorDeclaration toAst([Scope scope = const Scope.identity()]) {
    var astNode = new ConstructorDeclaration(
        null,
        _annotations.map/*<Annotation>*/((a) => a.toAst(scope)),
        null,
        null,
        _isConstant ? $const : null,
        null,
        null,
        _name != null ? _stringIdentifier(_name) : null,
        MethodBuilder._emptyParameters()
          ..parameters.addAll(
              _parameters.map/*<FormalParameter>*/((p) => p.toAst(scope))),
        null,
        null,
        null,
        _statements.isEmpty
            ? new EmptyFunctionBody($semicolon)
            : MethodBuilder._blockBody(
                _statements.map/*<Statement>*/((s) => s.toAst(scope))));
    return astNode;
  }
}
