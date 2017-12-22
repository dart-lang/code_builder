// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.expression;

import 'package:meta/meta.dart';

import '../base.dart';
import '../emitter.dart';
import '../visitors.dart';
import 'code.dart';
import 'method.dart';
import 'reference.dart';
import 'type_function.dart';

part 'expression/binary.dart';
part 'expression/closure.dart';
part 'expression/code.dart';
part 'expression/invoke.dart';
part 'expression/literal.dart';

/// Represents a [code] block that wraps an [Expression].

/// Represents a Dart expression.
///
/// See various concrete implementations for details.
abstract class Expression implements Spec {
  const Expression();

  @override
  R accept<R>(covariant ExpressionVisitor<R> visitor, [R context]);

  /// The expression as a valid [Code] block.
  ///
  /// Also see [statement].
  Code get code => new ToCodeExpression(this, false);

  /// The expression as a valid [Code] block with a trailing `;`.
  Code get statement => new ToCodeExpression(this, true);

  /// Returns the result of `this` `&&` [other].
  Expression and(Expression other) {
    return new BinaryExpression._(expression, other, '&&');
  }

  /// Returns accessing the index operator (`[]`) on `this`.
  Expression index(Expression index) {
    return new BinaryExpression._(
      expression,
      new CodeExpression(new Block.of([
        const Code('['),
        index.code,
        const Code(']'),
      ])),
      '',
    );
  }

  /// Returns the result of `this` `is` [other].
  Expression isA(Expression other) {
    return new BinaryExpression._(
      expression,
      other,
      'is',
    );
  }

  /// Returns the result of `this` `is!` [other].
  Expression isNotA(Expression other) {
    return new BinaryExpression._(
      expression,
      other,
      'is!',
    );
  }

  /// Returns the result of `this` `==` [other].
  Expression equalTo(Expression other) {
    return new BinaryExpression._(
      expression,
      other,
      '==',
    );
  }

  /// Returns the result of `this` `!=` [other].
  Expression notEqualTo(Expression other) {
    return new BinaryExpression._(
      expression,
      other,
      '!=',
    );
  }

  /// Returns the result of `this` `>` [other].
  Expression greaterThan(Expression other) {
    return new BinaryExpression._(
      expression,
      other,
      '>',
    );
  }

  /// Returns the result of `this` `<` [other].
  Expression lessThan(Expression other) {
    return new BinaryExpression._(
      expression,
      other,
      '<',
    );
  }

  /// Returns the result of `this` `>=` [other].
  Expression greaterOrEqualTo(Expression other) {
    return new BinaryExpression._(
      expression,
      other,
      '>=',
    );
  }

  /// Returns the result of `this` `<=` [other].
  Expression lessOrEqualTo(Expression other) {
    return new BinaryExpression._(
      expression,
      other,
      '<=',
    );
  }

  Expression conditional(Expression whenTrue, Expression whenFalse) {
    return new BinaryExpression._(
      expression,
      new BinaryExpression._(whenTrue, whenFalse, ':'),
      '?',
    );
  }

  /// This expression preceded by `await`.
  Expression get awaited {
    return new BinaryExpression._(
      const LiteralExpression._('await'),
      this,
      '',
    );
  }

  /// Return `{other} = {this}`.
  Expression assign(Expression other) {
    return new BinaryExpression._(
      this,
      other,
      '=',
    );
  }

  /// Return `{other} ??= {this}`.
  Expression assignNullAware(Expression other) {
    return new BinaryExpression._(
      this,
      other,
      '??=',
    );
  }

  /// Return `var {name} = {this}`.
  Expression assignVar(String name, [Reference type]) {
    return new BinaryExpression._(
      type == null
          ? new LiteralExpression._('var $name')
          : new BinaryExpression._(
              type.expression,
              new LiteralExpression._(name),
              '',
            ),
      this,
      '=',
    );
  }

  /// Return `final {name} = {this}`.
  Expression assignFinal(String name, [Reference type]) {
    return new BinaryExpression._(
      type == null
          ? const LiteralExpression._('final')
          : new BinaryExpression._(
              const LiteralExpression._('final'),
              type.expression,
              '',
            ),
      this,
      '$name =',
    );
  }

  /// Return `const {name} = {this}`.
  Expression assignConst(String name, [Reference type]) {
    return new BinaryExpression._(
      type == null
          ? const LiteralExpression._('const')
          : new BinaryExpression._(
              const LiteralExpression._('const'),
              type.expression,
              '',
            ),
      this,
      '$name =',
    );
  }

  /// Call this expression as a method.
  Expression call(
    Iterable<Expression> positionalArguments, [
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) {
    return new InvokeExpression._(
      this,
      positionalArguments.toList(),
      namedArguments,
      typeArguments,
    );
  }

  /// Returns an expression accessing `.<name>` on this expression.
  Expression property(String name) {
    return new BinaryExpression._(
      this,
      new LiteralExpression._(name),
      '.',
      false,
    );
  }

  /// Returns an expression accessing `?.<name>` on this expression.
  Expression nullSafeProperty(String name) {
    return new BinaryExpression._(
      this,
      new LiteralExpression._(name),
      '?.',
      false,
    );
  }

  /// This expression preceded by `return`.
  Expression get returned {
    return new BinaryExpression._(
      const LiteralExpression._('return'),
      this,
      '',
    );
  }

  /// May be overridden to support other types implementing [Expression].
  @visibleForOverriding
  Expression get expression => this;
}

/// Creates `typedef {name} =`.
Code createTypeDef(String name, FunctionType type) => new BinaryExpression._(
        new LiteralExpression._('typedef $name'), type.expression, '=')
    .statement;

class ToCodeExpression implements Code {
  final Expression code;

  /// Whether this code should be considered a _statement_.
  final bool isStatement;

  @visibleForTesting
  const ToCodeExpression(this.code, [this.isStatement = false]);

  @override
  R accept<R>(CodeVisitor<R> visitor, [R context]) {
    return (visitor as ExpressionVisitor<R>)
        .visitToCodeExpression(this, context);
  }

  @override
  String toString() => code.toString();
}

/// Knowledge of different types of expressions in Dart.
///
/// **INTERNAL ONLY**.
abstract class ExpressionVisitor<T> implements SpecVisitor<T> {
  T visitToCodeExpression(ToCodeExpression code, [T context]);
  T visitBinaryExpression(BinaryExpression expression, [T context]);
  T visitClosureExpression(ClosureExpression expression, [T context]);
  T visitCodeExpression(CodeExpression expression, [T context]);
  T visitInvokeExpression(InvokeExpression expression, [T context]);
  T visitLiteralExpression(LiteralExpression expression, [T context]);
  T visitLiteralListExpression(LiteralListExpression expression, [T context]);
  T visitLiteralMapExpression(LiteralMapExpression expression, [T context]);
}

/// Knowledge of how to write valid Dart code from [ExpressionVisitor].
///
/// **INTERNAL ONLY**.
abstract class ExpressionEmitter implements ExpressionVisitor<StringSink> {
  @override
  visitToCodeExpression(ToCodeExpression expression, [StringSink output]) {
    output ??= new StringBuffer();
    expression.code.accept(this, output);
    if (expression.isStatement) {
      output.write(';');
    }
    return output;
  }

  @override
  visitBinaryExpression(BinaryExpression expression, [StringSink output]) {
    output ??= new StringBuffer();
    expression.left.accept(this, output);
    if (expression.addSpace) {
      output.write(' ');
    }
    output.write(expression.operator);
    if (expression.addSpace) {
      output.write(' ');
    }
    expression.right.accept(this, output);
    return output;
  }

  @override
  visitClosureExpression(ClosureExpression expression, [StringSink output]) {
    output ??= new StringBuffer();
    return expression.method.accept(this, output);
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
    if (expression.name != null) {
      output..write('.')..write(expression.name);
    }
    if (expression.typeArguments.isNotEmpty) {
      output.write('<');
      visitAll<Reference>(expression.typeArguments, output, (type) {
        type.accept(this, output);
      });
      output.write('>');
    }
    output.write('(');
    visitAll<Spec>(expression.positionalArguments, output, (spec) {
      spec.accept(this, output);
    });
    if (expression.positionalArguments.isNotEmpty &&
        expression.namedArguments.isNotEmpty) {
      output.write(', ');
    }
    visitAll<String>(expression.namedArguments.keys, output, (name) {
      output..write(name)..write(': ');
      expression.namedArguments[name].accept(this, output);
    });
    return output..write(')');
  }

  @override
  visitLiteralExpression(LiteralExpression expression, [StringSink output]) {
    output ??= new StringBuffer();
    return output..write(expression.literal);
  }

  void _acceptLiteral(Object literalOrSpec, StringSink output) {
    if (literalOrSpec is Spec) {
      literalOrSpec.accept(this, output);
      return;
    }
    literal(literalOrSpec).accept(this, output);
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
    visitAll<Object>(expression.values, output, (value) {
      _acceptLiteral(value, output);
    });
    return output..write(']');
  }

  @override
  visitLiteralMapExpression(
    LiteralMapExpression expression, [
    StringSink output,
  ]) {
    output ??= new StringBuffer();
    if (expression.isConst) {
      output.write('const ');
    }
    if (expression.keyType != null) {
      output.write('<');
      expression.keyType.accept(this, output);
      output.write(', ');
      if (expression.valueType == null) {
        const Reference('dynamic', 'dart:core').accept(this, output);
      } else {
        expression.valueType.accept(this, output);
      }
      output.write('>');
    }
    output.write('{');
    visitAll<Object>(expression.values.keys, output, (key) {
      final value = expression.values[key];
      _acceptLiteral(key, output);
      output.write(': ');
      _acceptLiteral(value, output);
    });
    return output..write('}');
  }
}
