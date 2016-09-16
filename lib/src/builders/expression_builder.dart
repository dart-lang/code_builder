// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

// Shared functionality between ExpressionBuilder and _LiteralExpression.
/// Represents an expression value of `false`.
const literalFalse = const LiteralBool(false);

/// Represents an expression value of `null`.
const literalNull = const _LiteralNull();

/// Represents an expression value of `true`.
const literalTrue = const LiteralBool(true);

// Returns wrapped as a [ExpressionFunctionBody] AST.
final Token _closeP = new Token(TokenType.CLOSE_PAREN, 0);

// Returns wrapped as a [FunctionExpression] AST.
final Token _openP = new Token(TokenType.OPEN_PAREN, 0);

final Token _semicolon = new Token(TokenType.SEMICOLON, 0);

// TODO(matanl): Make this part of the public API. See annotation_builder.dart.
ExpressionFunctionBody _asFunctionBody(
  CodeBuilder<Expression> expression,
  Scope scope,
) {
  return new ExpressionFunctionBody(
    null,
    null,
    expression.toAst(scope),
    _semicolon,
  );
}

FunctionExpression _asFunctionExpression(
  CodeBuilder<Expression> expression,
  Scope scope,
) {
  return new FunctionExpression(
    null,
    new FormalParameterList(
      _openP,
      const [],
      null,
      null,
      _closeP,
    ),
    _asFunctionBody(expression, scope),
  );
}

ExpressionBuilder _invokeSelfImpl(
  ExpressionBuilder self,
  String name, {
  Iterable<CodeBuilder<Expression>> positional: const [],
  Map<String, CodeBuilder<Expression>> named: const {},
}) {
  return new _InvokeExpression.target(
    name,
    self,
    positional,
    named,
  );
}

/// Builds an [Expression] AST.
///
/// For simple literal expressions see:
/// - [LiteralBool] and [literalTrue] [literalFalse]
/// - [LiteralInt]
/// - [LiteralString]
/// - [literalNull]
abstract class ExpressionBuilder implements CodeBuilder<Expression> {
  /// Invoke [name] (which should be available in the local scope).
  ///
  /// Optionally specify [positional] and [named] arguments.
  factory ExpressionBuilder.invoke(
    String name, {
    String importFrom,
    Iterable<CodeBuilder<Expression>> positional: const [],
    Map<String, CodeBuilder<Expression>> named: const {},
  }) {
    return new _InvokeExpression(
      name,
      new List<CodeBuilder<Expression>>.unmodifiable(positional),
      new Map<String, CodeBuilder<Expression>>.unmodifiable(named),
      importFrom,
    );
  }

  factory ExpressionBuilder.invokeNew(
    TypeBuilder type, {
    String name,
    Iterable<CodeBuilder<Expression>> positional: const [],
    Map<String, CodeBuilder<Expression>> named: const {},
  }) {
    return new _InvokeExpression.newInstance(
      type,
      name,
      new List<CodeBuilder<Expression>>.unmodifiable(positional),
      new Map<String, CodeBuilder<Expression>>.unmodifiable(named),
    );
  }

  const ExpressionBuilder._();

  /// Return a new [ExpressionBuilder] invoking the result of this expression.
  ExpressionBuilder invokeSelf(
    String name, {
    Iterable<CodeBuilder<Expression>> positional: const [],
    Map<String, CodeBuilder<Expression>> named: const {},
  }); // TODO(matanl): Rename to invoke when factory is removed.

  /// Returns wrapped as a [ExpressionFunctionBody] AST.
  ExpressionFunctionBody toFunctionBody(
          [Scope scope = const Scope.identity()]) =>
      _asFunctionBody(this, scope);

  /// Returns wrapped as a [FunctionExpression] AST.
  FunctionExpression toFunctionExpression(
          [Scope scope = const Scope.identity()]) =>
      _asFunctionExpression(this, scope);

  /// Converts to a [StatementBuilder].
  ///
  /// __Example use__:
  ///     literalNull.toStatement(); // ==> null;
  StatementBuilder toStatement();
}

/// Creates a new literal `bool` value.
class LiteralBool extends _LiteralExpression<BooleanLiteral> {
  static final BooleanLiteral _true =
      new BooleanLiteral(new KeywordToken(Keyword.TRUE, 0), true);
  static final BooleanLiteral _false =
      new BooleanLiteral(new KeywordToken(Keyword.FALSE, 0), false);

  final bool _value;

  /// Returns the passed value as a [BooleanLiteral].
  const LiteralBool(this._value);

  @override
  BooleanLiteral toAst([_]) => _value ? _true : _false;
}

/// Represents an expression value of a literal number.
class LiteralInt extends _LiteralExpression<IntegerLiteral> {
  final int _value;

  /// Returns the passed value as a [IntegerLiteral].
  const LiteralInt(this._value);

  @override
  IntegerLiteral toAst([_]) => new IntegerLiteral(
        new StringToken(TokenType.INT, '$_value', 0),
        _value,
      );
}

/// Represents an expression value of a literal `'string'`.
class LiteralString extends _LiteralExpression<StringLiteral> {
  final String _value;

  /// Returns the passed value as a [StringLiteral].
  const LiteralString(this._value);

  @override
  StringLiteral toAst([_]) => new SimpleStringLiteral(
        new StringToken(
          TokenType.STRING,
          "'$_value'",
          0,
        ),
        _value,
      );
}

class _InvokeExpression extends ExpressionBuilder {
  static final Token _colon = new Token(TokenType.COLON, 0);

  final String _importFrom;
  final ExpressionBuilder _target;
  final String _name;
  final List<CodeBuilder<Expression>> _positionalArguments;
  final Map<String, CodeBuilder<Expression>> _namedArguments;
  final TypeBuilder _type;

  const _InvokeExpression(
    this._name,
    this._positionalArguments,
    this._namedArguments,
    this._importFrom,
  )
      : _target = null,
        _type = null,
        super._();

  const _InvokeExpression.newInstance(
    this._type,
    this._name,
    this._positionalArguments,
    this._namedArguments,
  )
      : _target = null,
        _importFrom = null,
        super._();

  const _InvokeExpression.target(
      this._name, this._target, this._positionalArguments, this._namedArguments)
      : _importFrom = null,
        _type = null,
        super._();

  @override
  ExpressionBuilder invokeSelf(
    String name, {
    Iterable<CodeBuilder<Expression>> positional: const [],
    Map<String, CodeBuilder<Expression>> named: const {},
  }) =>
      _invokeSelfImpl(this, name, positional: positional, named: named);

  @override
  Expression toAst([Scope scope = const Scope.identity()]) {
    // TODO(matanl): Move to TypeBuilder.newInstance.
    if (_type != null) {
      return new InstanceCreationExpression(
        new KeywordToken(Keyword.NEW, 0),
        new ConstructorName(
          _type.toAst(scope),
          _name != null ? new Token(TokenType.PERIOD, 0) : null,
          _name != null ? _stringIdentifier(_name) : null,
        ),
        _getArgumentList(scope),
      );
    }
    return new MethodInvocation(
      _target?.toAst(scope),
      _target != null ? new Token(TokenType.PERIOD, 0) : null,
      _stringIdentifier(_name),
      null,
      _getArgumentList(scope),
    );
  }

  @override
  StatementBuilder toStatement() => new StatementBuilder.fromExpression(this);

  ArgumentList _getArgumentList(Scope scope) {
    return new ArgumentList(
      new Token(TokenType.OPEN_CURLY_BRACKET, 0),
      _positionalArguments.map/*<Expression*/((p) => p.toAst(scope)).toList()
        ..addAll(_namedArguments.keys
            .map/*<Expression>*/((name) => new NamedExpression(
                  new Label(
                    _stringIdentifier(name),
                    _colon,
                  ),
                  _namedArguments[name].toAst(scope),
                ))),
      new Token(TokenType.CLOSE_CURLY_BRACKET, 0),
    );
  }
}

abstract class _LiteralExpression<A extends Literal>
    implements ExpressionBuilder, CodeBuilder<A> {
  const _LiteralExpression();

  @override
  ExpressionBuilder invokeSelf(
    String name, {
    Iterable<CodeBuilder<Expression>> positional: const [],
    Map<String, CodeBuilder<Expression>> named: const {},
  }) =>
      _invokeSelfImpl(this, name, positional: positional, named: named);

  @override
  ExpressionFunctionBody toFunctionBody(
          [Scope scope = const Scope.identity()]) =>
      _asFunctionBody(this, scope);

  @override
  FunctionExpression toFunctionExpression(
          [Scope scope = const Scope.identity()]) =>
      _asFunctionExpression(this, scope);

  @override
  StatementBuilder toStatement() => new StatementBuilder.fromExpression(this);
}

class _LiteralNull extends _LiteralExpression<NullLiteral> {
  static NullLiteral _null = new NullLiteral(new KeywordToken(Keyword.NULL, 0));

  const _LiteralNull();

  @override
  NullLiteral toAst([_]) => _null;
}
