// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.type;

/// Lazily builds an [InstanceCreationExpression] AST when built.
///
/// See [TypeBuilder]:
/// - [TypeBuilder.constInstance]
/// - [TypeBuilder.newInstance]
abstract class NewInstanceBuilder
    implements AnnotationBuilder, InvocationBuilder {
  factory NewInstanceBuilder._const(
    TypeBuilder type, {
    String constructor,
  }) {
    return new _NewInvocationBuilderImpl(
      Keyword.CONST,
      type,
      constructor,
    );
  }

  factory NewInstanceBuilder._new(
    TypeBuilder type, {
    String constructor,
  }) {
    return new _NewInvocationBuilderImpl(
      Keyword.NEW,
      type,
      constructor,
    );
  }
}

class _NewInvocationBuilderImpl extends Object
    with AbstractExpressionMixin, AbstractInvocationBuilderMixin, TopLevelMixin
    implements NewInstanceBuilder {
  final String _constructor;
  final Keyword _keyword;
  final TypeBuilder _type;

  _NewInvocationBuilderImpl(
    this._keyword,
    this._type,
    this._constructor,
  );

  @override
  Annotation buildAnnotation([Scope scope]) {
    return astFactory.annotation(
      $at,
      _type.buildType(scope).name,
      $period,
      _constructor != null && _constructor.isNotEmpty
          ? stringIdentifier(_constructor)
          : null,
      buildArgumentList(scope: scope),
    );
  }

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.instanceCreationExpression(
      new KeywordToken(_keyword, 0),
      astFactory.constructorName(
        _type.buildType(scope),
        _constructor != null && _constructor.isNotEmpty ? $period : null,
        _constructor != null && _constructor.isNotEmpty
            ? stringIdentifier(_constructor)
            : null,
      ),
      buildArgumentList(scope: scope),
    );
  }
}
