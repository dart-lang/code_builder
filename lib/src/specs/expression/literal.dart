// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.specs.expression;

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

/// Creates a literal list expression from [values].
LiteralListExpression literalList(List<Object> values, [Reference type]) {
  return new LiteralListExpression._(false, values, type);
}

/// Creates a literal `const` list expression from [values].
LiteralListExpression literalConstList(List<Object> values, [Reference type]) {
  return new LiteralListExpression._(true, values, type);
}

/// Represents a literal value in Dart source code.
///
/// For example, `new LiteralExpression('null')` should emit `null`.
///
/// Some common literals and helpers are available as methods/fields:
/// * [literal]
/// * [literalBool] and [literalTrue], [literalFalse]
/// * [literalNull]
/// * [literalList] and [literalConstList]
class LiteralExpression extends Expression {
  final String literal;

  const LiteralExpression._(this.literal);

  @override
  R accept<R>(ExpressionVisitor<R> visitor, [R context]) {
    return visitor.visitLiteralExpression(this, context);
  }
}

class LiteralListExpression extends Expression {
  final bool isConst;
  final List<Object> values;
  final Reference type;

  const LiteralListExpression._(this.isConst, this.values, this.type);

  @override
  R accept<R>(ExpressionVisitor<R> visitor, [R context]) {
    return visitor.visitLiteralListExpression(this, context);
  }
}
