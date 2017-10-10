// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../base.dart';
import '../../visitors.dart';

/// Represents a Dart expression.
///
/// See various concrete implementations for details.
abstract class Expression implements Spec {
  const Expression();

  @override
  R accept<R>(covariant ExpressionVisitor<R> visitor, [R context]);

  Expression and(Expression other) => new BinaryExpression._(this, other, '&&');
}

/// Knowledge of different types of expressions in Dart.
///
/// **INTERNAL ONLY**.
abstract class ExpressionVisitor<T> implements SpecVisitor<T> {
  T visitBinaryExpression(BinaryExpression expression, [T context]);
  T visitLiteralExpression(LiteralExpression expression, [T context]);
}

/// Knowledge of how to write valid Dart code from [ExpressionVisitor].
///
/// **INTERNAL ONLY**.
abstract class ExpressionEmitter implements ExpressionVisitor<StringSink> {
  @override
  visitBinaryExpression(BinaryExpression expression, [StringSink output]) {
    output ??= new StringBuffer();
    return output
      ..write(expression.left.accept(this))
      ..write(' ')
      ..write(expression.operator)
      ..write(' ')
      ..write(expression.right.accept(this));
  }

  @override
  visitLiteralExpression(LiteralExpression expression, [StringSink output]) {
    output ??= new StringBuffer();
    return output..write(expression.literal);
  }
}

/// Converts a runtime Dart [literal] value into an [Expression].
///
/// Unsupported inputs invoke the [onError] callback.
Expression literal(Object literal, {Expression onError(Object value)}) {
  if (literal is bool) {
    return literalBool(literal);
  }
  if (literal == null) {
    return literalNull;
  }
  if (onError != null) {
    return onError(literal);
  }
  throw new UnsupportedError('Not a supported literal type: $literal.');
}

/// Represents the literal value `true`.
const Expression literalTrue = const LiteralExpression._('true');

/// Represents the literal value `false`.
const Expression literalFalse = const LiteralExpression._('false');

/// Create a literal expression from a boolean [value].
Expression literalBool(bool value) => value ? literalTrue : literalFalse;

/// Represents the literal value `null`.
const Expression literalNull = const LiteralExpression._('null');

/// Represents a literal value in Dart source code.
///
/// For example, `new LiteralExpression('null')` should emit `null`.
///
/// Some common literals and helpers are available as methods/fields:
/// * [literal]
/// * [literalBool] and [literalTrue], [literalFalse]
/// * [literalNull]
class LiteralExpression extends Expression {
  final String literal;

  const LiteralExpression._(this.literal);

  @override
  R accept<R>(ExpressionVisitor<R> visitor, [R context]) {
    return visitor.visitLiteralExpression(this, context);
  }
}

/// Represents two expressions ([left] and [right]) and an [operator].
class BinaryExpression extends Expression {
  final Expression left;
  final Expression right;
  final String operator;

  const BinaryExpression._(this.left, this.right, this.operator);

  @override
  R accept<R>(ExpressionVisitor<R> visitor, [R context]) {
    return visitor.visitBinaryExpression(this, context);
  }
}
