// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/method.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/type.dart';
import 'package:code_builder/src/tokens.dart';

/// A short-hand way of constructing a [ParameterBuilder].
ParameterBuilder parameter(
  String name, [
  Iterable<ValidParameterMember> members = const [],
]) {
  final List<AnnotationBuilder> annotations = <AnnotationBuilder>[];
  ExpressionBuilder defaultTo;
  bool defaultToSet = false;
  TypeBuilder type;
  for (final member in members) {
    if (member is TypeBuilder) {
      type = member;
    } else if (member is AnnotationBuilder) {
      annotations.add(member);
    } else if (member is ExpressionBuilder) {
      defaultTo = member;
      defaultToSet = true;
    } else {
      throw new StateError('Invalid AST type: ${member.runtimeType}');
    }
  }
  var builder = new ParameterBuilder(
    name,
    type: type,
  )..addAnnotations(annotations);
  if (defaultToSet) {
    builder = builder.asOptional(defaultTo);
  }
  return builder;
}

/// An [AstBuilder] that can be built up using [ParameterBuilder].
abstract class HasParameters implements AstBuilder {
  /// Adds [parameter] to the builder.
  void addNamed(ParameterBuilder parameter);

  /// Adds [parameter] to the builder.
  void addPositional(ParameterBuilder parameter);
}

/// Implements [HasParameters].
abstract class HasParametersMixin implements HasParameters {
  final List<_ParameterPair> _parameters = <_ParameterPair>[];

  @override
  void addNamed(ParameterBuilder parameter, {bool asField: false}) {
    _parameters.add(new _ParameterPair.named(parameter, field: asField));
  }

  @override
  void addPositional(ParameterBuilder parameter, {bool asField: false}) {
    _parameters.add(new _ParameterPair(parameter, field: asField));
  }

  /// Builds a [FormalParameterList].
  FormalParameterList buildParameterList([Scope scope]) {
    return new FormalParameterList(
      $openParen,
      _parameters
          .map/*<FormalParameter>*/((p) => p.buildParameter(scope))
          .toList(),
      null,
      null,
      $closeParen,
    );
  }
}

/// Lazily builds an [FormalParameter] AST the builder is invoked.
abstract class ParameterBuilder
    implements
        AstBuilder<FormalParameter>,
        HasAnnotations,
        ValidConstructorMember,
        ValidMethodMember {
  /// Create a new builder for parameter [name].
  factory ParameterBuilder(
    String name, {
    TypeBuilder type,
  }) = _SimpleParameterBuilder;

  /// Returns as an optional [ParameterBuilder] set to [defaultTo].
  ParameterBuilder asOptional([ExpressionBuilder defaultTo]);

  /// Returns a positional [FormalParameter] AST representing the builder.
  FormalParameter buildNamed(bool field, [Scope scope]);

  /// Returns a positional [FormalParameter] AST representing the builder.
  FormalParameter buildPositional(bool field, [Scope scope]);
}

/// A marker interface for an AST that could be added to [ParameterBuilder].
abstract class ValidParameterMember implements AstBuilder {}

class _OptionalParameterBuilder extends Object
    with HasAnnotationsMixin
    implements ParameterBuilder {
  final ParameterBuilder _parameter;
  final ExpressionBuilder _expression;

  _OptionalParameterBuilder(this._parameter, [this._expression]);

  @override
  ParameterBuilder asOptional([ExpressionBuilder defaultTo]) {
    return new _OptionalParameterBuilder(_parameter, defaultTo);
  }

  @override
  FormalParameter buildAst([Scope scope]) => buildPositional(false, scope);

  @override
  FormalParameter buildNamed(bool field, [Scope scope]) {
    return new DefaultFormalParameter(
      _parameter.buildPositional(field, scope),
      ParameterKind.NAMED,
      _expression != null ? $colon : null,
      _expression?.buildExpression(scope),
    );
  }

  @override
  FormalParameter buildPositional(bool field, [Scope scope]) {
    return new DefaultFormalParameter(
      _parameter.buildPositional(field, scope),
      ParameterKind.POSITIONAL,
      _expression != null ? $equals : null,
      _expression?.buildExpression(scope),
    );
  }
}

class _ParameterPair {
  final bool _isField;
  final bool _isNamed;
  final ParameterBuilder _parameter;

  _ParameterPair(this._parameter, {bool field: false})
      : _isNamed = false,
        _isField = field;

  _ParameterPair.named(this._parameter, {bool field: false})
      : _isNamed = true,
        _isField = field;

  FormalParameter buildParameter([Scope scope]) {
    return _isNamed
        ? _parameter.buildNamed(_isField, scope)
        : _parameter.buildPositional(_isField, scope);
  }
}

class _SimpleParameterBuilder extends Object
    with HasAnnotationsMixin
    implements ParameterBuilder {
  final String _name;
  final TypeBuilder _type;

  _SimpleParameterBuilder(
    String name, {
    TypeBuilder type,
  })
      : _name = name,
        _type = type;

  @override
  ParameterBuilder asOptional([ExpressionBuilder defaultTo]) {
    return new _OptionalParameterBuilder(this, defaultTo);
  }

  @override
  FormalParameter buildAst([Scope scope]) => buildPositional(false, scope);

  @override
  FormalParameter buildNamed(bool field, [Scope scope]) {
    return asOptional().buildNamed(field, scope);
  }

  @override
  FormalParameter buildPositional(bool field, [Scope scope]) {
    if (field) {
      return new FieldFormalParameter(
        null,
        buildAnnotations(scope),
        null,
        _type?.buildType(scope),
        $this,
        $period,
        stringIdentifier(_name),
        null,
        null,
      );
    }
    return new SimpleFormalParameter(
      null,
      buildAnnotations(scope),
      null,
      _type?.buildType(scope),
      stringIdentifier(_name),
    );
  }
}
