// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

/// Partial implementation of [InvocationBuilder].
abstract class AbstractInvocationBuilderMixin implements InvocationBuilder {
  final List<ExpressionBuilder> _positional = <ExpressionBuilder>[];
  final Map<String, ExpressionBuilder> _named = <String, ExpressionBuilder>{};

  @override
  void addNamedArgument(String name, ExpressionBuilder argument) {
    _named[name] = argument;
  }

  @override
  void addPositionalArgument(ExpressionBuilder argument) {
    _positional.add(argument);
  }

  /// Returns an [ArgumentList] AST.
  ArgumentList buildArgumentList([Scope scope]) {
    final allArguments = <Expression>[];
    allArguments.addAll(
        _positional.map/*<Expression>*/((e) => e.buildExpression(scope)));
    _named.forEach((name, e) {
      allArguments.add(new NamedExpression(
        new Label(
          stringIdentifier(name),
          $colon,
        ),
        e.buildExpression(scope),
      ));
    });
    return new ArgumentList(
      $openParen,
      allArguments,
      $closeParen,
    );
  }

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);
}

/// Builds an invocation AST.
abstract class InvocationBuilder
    implements ExpressionBuilder, StatementBuilder, ValidMethodMember {
  factory InvocationBuilder._(ExpressionBuilder target) {
    return new _FunctionInvocationBuilder(target);
  }

  factory InvocationBuilder._on(ExpressionBuilder target, String method) {
    return new _MethodInvocationBuilder(target, method);
  }

  /// Adds [argument] as a [name]d argument to this method call.
  void addNamedArgument(String name, ExpressionBuilder argument);

  /// Adds [argument] as a positional argument to this method call.
  void addPositionalArgument(ExpressionBuilder argument);
}

class _FunctionInvocationBuilder extends Object
    with AbstractInvocationBuilderMixin, AbstractExpressionMixin
    implements InvocationBuilder {
  final ExpressionBuilder _target;

  _FunctionInvocationBuilder(this._target);

  @override
  Expression buildExpression([Scope scope]) {
    return new FunctionExpressionInvocation(
      _target.buildExpression(scope),
      null,
      buildArgumentList(scope),
    );
  }
}

class _MethodInvocationBuilder extends Object
    with AbstractInvocationBuilderMixin, AbstractExpressionMixin
    implements InvocationBuilder {
  final String _method;
  final ExpressionBuilder _target;

  _MethodInvocationBuilder(this._target, this._method);

  @override
  Expression buildExpression([Scope scope]) {
    return new MethodInvocation(
      _target.buildExpression(scope),
      $period,
      stringIdentifier(_method),
      null,
      buildArgumentList(scope),
    );
  }
}
