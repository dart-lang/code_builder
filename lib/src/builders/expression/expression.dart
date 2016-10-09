import 'package:analyzer/analyzer.dart'
    show
        AssertStatement,
        AssignmentExpression,
        BooleanLiteral,
        Expression,
        ExpressionStatement,
        Literal,
        NullLiteral,
        SimpleIdentifier,
        SimpleStringLiteral,
        Statement,
        VariableDeclaration,
        VariableDeclarationList,
        VariableDeclarationStatement;
import 'package:analyzer/dart/ast/token.dart';
import 'package:code_builder/code_builder.dart'
    show CodeBuilder, Scope, TypeBuilder;
import 'package:code_builder/src/tokens.dart'
    show
        $assert,
        $closeParen,
        $const,
        $equals,
        $false,
        $final,
        $null,
        $openParen,
        $semicolon,
        $true,
        $var,
        stringToken;
import 'package:code_builder/src/builders/statement/statement.dart'
    show StatementBuilder;

final Literal _null = new NullLiteral($null);
final Literal _true = new BooleanLiteral($true, true);
final Literal _false = new BooleanLiteral($false, false);

final ExpressionBuilder _literalNull = new _LiteralExpression(_null);
final ExpressionBuilder _literalTrue = new _LiteralExpression(_true);
final ExpressionBuilder _literalFalse = new _LiteralExpression(_false);

/// Return a literal [value].
///
/// Must either be `null` or [bool], [num], or [String].
///
/// __Example use__:
///   literal(null);
///   literal('Hello World');
///   literal(5);
///   literal(false);
///
/// **NOTE**: A string literal is automatically wrapped in single-quotes.
///
/// TODO(matanl): Add support for literal [List] and [Map] of other literals.
ExpressionBuilder literal(value) {
  if (value == null) {
    return _literalNull;
  }
  if (value is bool) {
    return value ? _literalTrue : _literalFalse;
  }
  if (value is String) {
    return new _LiteralExpression(new SimpleStringLiteral(
      stringToken("'$value'"),
      value,
    ));
  }
  if (value is num) {}
  throw new ArgumentError('Invalid type: ${value.runtimeType}');
}

/// Builds an [Expression] AST.
abstract class ExpressionBuilder implements CodeBuilder<Expression> {
  /// Returns _as_ a statement that `asserts` the expression.
  StatementBuilder asAssert();

  /// Returns _as_ an expression that assigns to an existing [variable].
  ///
  /// __Example use__:
  ///   literalTrue.assign('foo') // Outputs "foo = true"
  ExpressionBuilder assign(String variable);

  /// Returns _as_ a statement that assigns to a new `const` [variable].
  ///
  /// __Example use__:
  ///   literalTrue.asConst('foo') // Outputs "const foo = true;"
  StatementBuilder asConst(String variable, [TypeBuilder type]);

  /// Returns _as_ a statement that assigns to a new `final` [variable].
  ///
  /// __Example use__:
  ///   literalTrue.asFinal('foo') // Outputs "final foo = true;"
  StatementBuilder asFinal(String variable, [TypeBuilder type]);

  /// Returns _as_ a statement that assigns to a new [variable].
  ///
  /// __Example use__:
  ///   literalTrue.asVar('foo') // Outputs "var foo = true;"
  StatementBuilder asVar(String variable);

  /// Returns _as_ a statement that builds an `if` statement.
  ///
  /// __Example use__:
  ///   literalTrue.asIf() // Outputs "if (true) { ... }"
  /*If*/ StatementBuilder asIf();

  /// Returns _as_ a statement that `return`s this expression.
  ///
  /// __Example use__:
  ///   literalTrue.asReturn() // Outputs "return true;"
  StatementBuilder asReturn();

  /// Returns _as_ a statement.
  ///
  /// An expression itself in Dart is a valid statement.
  ///
  /// __Example use__:
  ///   invoke('foo').asStatement() // Outputs "foo();"
  StatementBuilder asStatement();

  /// Returns _as_ an expression using the equality operator on [condition].
  ///
  /// __Example use__:
  ///   literalTrue.equals(literalTrue) // Outputs "true == true"
  ExpressionBuilder equals(ExpressionBuilder condition);

  /// Returns _as_ an expression using the not-equals operator on [condition].
  ///
  /// __Example use__:
  ///   literalTrue.notEquals(literalTrue) // Outputs "true != true"
  ExpressionBuilder notEquals(ExpressionBuilder condition);

  /// Returns _as_ an expression negating this one.
  ///
  /// __Example use__:
  ///   literalTrue.not() // Outputs "!true"
  ExpressionBuilder not();

  /// Returns _as_ an expression wrapped in parentheses.
  ///
  /// __Example use__:
  ///   literalTrue.parentheses() // Outputs "(true)"
  ExpressionBuilder parentheses();
}

/// A partial implementation of [ExpressionBuilder] suitable as a mixin.
abstract class ExpressionBuilderMixin implements ExpressionBuilder {
  @override
  StatementBuilder asAssert() => new _AsAssert(this);

  @override
  ExpressionBuilder assign(String variable) => new _AsAssign(this, variable);

  @override
  StatementBuilder asConst(String variable, [TypeBuilder type]) =>
      new _AsAssignStatement(this, variable,
          keyword: _AsAssignType.asConst, type: type);

  @override
  StatementBuilder asFinal(String variable, [TypeBuilder type]) =>
      new _AsAssignStatement(this, variable,
          keyword: _AsAssignType.asFinal, type: type);

  @override
  StatementBuilder asVar(String variable, [TypeBuilder type]) =>
      new _AsAssignStatement(this, variable,
          keyword: _AsAssignType.asVar, type: type);

  @override
  StatementBuilder asStatement() => new _AsStatement(this);
}

class _AsAssert implements StatementBuilder {
  final ExpressionBuilder _expression;

  _AsAssert(this._expression);

  @override
  Statement build([Scope scope = Scope.identity]) {
    return new AssertStatement(
      $assert,
      $openParen,
      _expression.build(scope),
      null,
      null,
      $closeParen,
      $semicolon,
    );
  }
}

class _AsAssign extends ExpressionBuilderMixin implements ExpressionBuilder {
  final ExpressionBuilder _expression;
  final String _name;

  _AsAssign(this._expression, this._name);

  @override
  Expression build([Scope scope = Scope.identity]) {
    final name = new SimpleIdentifier(stringToken(_name));
    return new AssignmentExpression(
      name,
      $equals,
      _expression.build(scope),
    );
  }
}

class _AsAssignStatement implements StatementBuilder {
  final ExpressionBuilder _expression;
  final String _name;
  final _AsAssignType _keyword;
  final TypeBuilder _type;

  _AsAssignStatement(
    this._expression,
    this._name, {
    _AsAssignType keyword,
    TypeBuilder type,
  })
      : _keyword = keyword,
        _type = type;

  @override
  Statement build([Scope scope = Scope.identity]) {
    final name = new SimpleIdentifier(stringToken(_name));
    Token token;
    switch (_keyword) {
      case _AsAssignType.asConst:
        token = $const;
        break;
      case _AsAssignType.asFinal:
        token = $final;
        break;
      case _AsAssignType.asVar:
        token = $var;
        break;
    }
    return new VariableDeclarationStatement(
      new VariableDeclarationList(
        null,
        null,
        token,
        _type?.build(scope),
        [new VariableDeclaration(name, $equals, _expression.build(scope))],
      ),
      $semicolon,
    );
  }
}

class _AsStatement implements StatementBuilder {
  final ExpressionBuilder _expression;

  _AsStatement(this._expression);

  @override
  Statement build([Scope scope = Scope.identity]) {
    return new ExpressionStatement(_expression.build(scope), $semicolon);
  }
}

class _LiteralExpression extends ExpressionBuilderMixin
    implements CodeBuilder<Literal> {
  final Literal _literal;

  _LiteralExpression(this._literal);

  @override
  Literal build([_]) => _literal;
}

enum _AsAssignType { asConst, asFinal, asVar, }
