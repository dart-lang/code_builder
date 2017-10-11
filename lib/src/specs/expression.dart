// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.expression;

import 'package:meta/meta.dart';

import '../base.dart';
import '../visitors.dart';
import 'code.dart';
import 'reference.dart';

part 'expression/binary.dart';
part 'expression/code.dart';
part 'expression/invoke.dart';
part 'expression/literal.dart';

/// Represents a Dart expression.
///
/// See various concrete implementations for details.
abstract class Expression implements Spec {
  const Expression();

  @override
  R accept<R>(covariant ExpressionVisitor<R> visitor, [R context]);

  /// Returns the result of [this] `&&` [other].
  Expression and(Expression other) {
    return new BinaryExpression._(toExpression(), other, '&&');
  }

  /// Call this expression as a method.
  Expression call() {
    return new InvokeExpression._(this);
  }

  /// Returns a new instance of this expression.
  Expression newInstance() {
    return new InvokeExpression._new(this);
  }

  /// Returns a const instance of this expression.
  Expression constInstance() {
    return new InvokeExpression._const(this);
  }

  /// May be overriden to support other types implementing [Expression].
  @visibleForOverriding
  Expression toExpression() => this;
}

/// Knowledge of different types of expressions in Dart.
///
/// **INTERNAL ONLY**.
abstract class ExpressionVisitor<T> implements SpecVisitor<T> {
  T visitBinaryExpression(BinaryExpression expression, [T context]);
  T visitCodeExpression(CodeExpression expression, [T context]);
  T visitInvokeExpression(InvokeExpression expression, [T context]);
  T visitLiteralExpression(LiteralExpression expression, [T context]);
  T visitLiteralListExpression(LiteralListExpression expression, [T context]);
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
  visitCodeExpression(CodeExpression expression, [StringSink output]) {
    output ??= new StringBuffer();
    final visitor = this as CodeVisitor<StringSink>;
    return expression.code.accept(visitor, output);
  }

  @override
  visitInvokeExpression(InvokeExpression expression, [StringSink output]) {
    output ??= new StringBuffer();
    switch (expression.type) {
      case InvokeExpressionType.newInstance:
        output.write('new ');
        break;
      case InvokeExpressionType.constInstance:
        output.write('const ');
        break;
    }
    expression.target.accept(this, output);
    return output..write('()');
  }

  @override
  visitLiteralExpression(LiteralExpression expression, [StringSink output]) {
    output ??= new StringBuffer();
    return output..write(expression.literal);
  }

  @override
  visitLiteralListExpression(
    LiteralListExpression expression, [
    StringSink output,
  ]) {
    output ??= new StringBuffer();
    if (expression.isConst) {
      output.write('const ');
    }
    if (expression.type != null) {
      output.write('<');
      expression.type.accept(this, output);
      output.write('>');
    }
    output.write('[');
    // ignore: prefer_final_locals
    for (var i = 0, l = expression.values.length; i < l; i++) {
      final value = expression.values[i];
      if (value is Spec) {
        value.accept(this, output);
      } else {
        literal(value).accept(this, output);
      }
      if (i < l - 1) {
        output.write(', ');
      }
    }
    return output..write(']');
  }
}
