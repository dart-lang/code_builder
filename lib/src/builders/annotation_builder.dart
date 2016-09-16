// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Builds a metadata [Annotation] to be added to other AST elements.
///
/// An annotation may either be a reference to an existing `const` identifier
/// _or_ to an invocation of a `const` class constructor.
///
/// To create a `@doNotUse` reference, use [AnnotationBuilder.reference]:
///   const doNotUse = #do_not_use;
///
///   @doNotUse
///   void destroyTheWorld() { ... }
///
/// To create a `@DoNotUse('Blows up')` use [AnnotationBuilder.invoke].
abstract class AnnotationBuilder implements CodeBuilder<Annotation> {
  /// Create a new annotated `const` [constructor] invocation.
  ///
  /// May optionally specify an [importFrom] to auto-prefix the annotation _if_
  /// attached to a library where the import is not specified or is prefixed.
  factory AnnotationBuilder.invoke(
    String constructor, {
    String importFrom,
    Iterable<CodeBuilder<Expression>> positional: const [],
    Map<String, CodeBuilder<Expression>> named: const {},
  }) {
    return new _ConstructorAnnotationBuilder(
      constructor,
      new ExpressionBuilder.invoke(
        null,
        positional: positional,
        named: named,
      ),
      importFrom,
    );
  }

  /// Create a new annotated `const` [identifier].
  ///
  /// May optionally specify an [importFrom] to auto-prefix the annotation _if_
  /// attached to a library where the import is not specified or is prefixed.
  const factory AnnotationBuilder.reference(String identifier,
      [String importFrom]) = _ReferenceAnnotationBuilder;
}

class _ConstructorAnnotationBuilder implements AnnotationBuilder {
  final String _constructor;
  final ExpressionBuilder _expression;
  final String _importFrom;

  _ConstructorAnnotationBuilder(this._constructor, this._expression,
      [this._importFrom]);

  @override
  Annotation toAst([Scope scope = const Scope.identity()]) {
    var expressionAst = _expression.toAst(scope);
    if (expressionAst is MethodInvocation) {
      return new Annotation(
        null,
        scope.getIdentifier(_constructor, _importFrom),
        null,
        null,
        // TODO(matanl): InvocationExpression needs to be public API.
        expressionAst.argumentList,
      );
    }
    throw new UnsupportedError('Expression must be InvocationExpression');
  }
}

class _ReferenceAnnotationBuilder implements AnnotationBuilder {
  final String _importFrom;
  final String _reference;

  const _ReferenceAnnotationBuilder(this._reference, [this._importFrom]);

  @override
  Annotation toAst([Scope scope = const Scope.identity()]) => new Annotation(
        null,
        scope.getIdentifier(_reference, _importFrom),
        null,
        null,
        null,
      );
}
