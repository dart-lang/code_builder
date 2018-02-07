// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/generics.dart';
import '../visitors.dart';
import 'code.dart';
import 'expression.dart';
import 'reference.dart';

part 'type_reference.g.dart';

@immutable
abstract class TypeReference extends Expression
    with HasGenerics
    implements Built<TypeReference, TypeReferenceBuilder>, Reference, Spec {
  factory TypeReference([
    void updates(TypeReferenceBuilder b),
  ]) = _$TypeReference;

  TypeReference._();

  @override
  String get symbol;

  @override
  @nullable
  String get url;

  /// Optional bound generic.
  @nullable
  Reference get bound;

  @override
  BuiltList<Reference> get types;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R context,
  ]) =>
      visitor.visitType(this, context);

  @override
  Expression get expression {
    return new CodeExpression(new Code.scope((a) => a(this)));
  }

  @override
  TypeReference get type => this;

  @override
  Expression newInstance(
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) {
    return new InvokeExpression.newOf(
      this,
      positionalArguments.toList(),
      namedArguments,
      typeArguments,
      null,
    );
  }

  @override
  Expression newInstanceNamed(
    String name,
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) {
    return new InvokeExpression.newOf(
      this,
      positionalArguments.toList(),
      namedArguments,
      typeArguments,
      name,
    );
  }

  @override
  Expression constInstance(
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) {
    return new InvokeExpression.constOf(
      this,
      positionalArguments.toList(),
      namedArguments,
      typeArguments,
      null,
    );
  }

  @override
  Expression constInstanceNamed(
    String name,
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) {
    return new InvokeExpression.constOf(
      this,
      positionalArguments.toList(),
      namedArguments,
      typeArguments,
      name,
    );
  }
}

abstract class TypeReferenceBuilder extends Object
    with HasGenericsBuilder
    implements Builder<TypeReference, TypeReferenceBuilder> {
  factory TypeReferenceBuilder() = _$TypeReferenceBuilder;

  TypeReferenceBuilder._();

  String symbol;

  String url;

  /// Optional bound generic.
  Reference bound;

  @override
  ListBuilder<Reference> types = new ListBuilder<Reference>();
}
