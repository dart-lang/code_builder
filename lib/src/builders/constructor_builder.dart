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
  final List<ParameterBuilder> _parameters = <ParameterBuilder>[];

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

  /// Lazily adds [builder].
  ///
  /// When the method is emitted as an AST, [ParameterBuilder.toAst] is used.
  void addParameter(ParameterBuilder builder) {
    _parameters.add(builder);
  }

  @override
  ConstructorDeclaration toAst([Scope scope = const Scope.identity()]) {
    var astNode = new ConstructorDeclaration(
      null,
      null,
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
      new EmptyFunctionBody($semicolon),
    );
    return astNode;
  }
}
