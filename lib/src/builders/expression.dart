library code_builder.src.builders.expression;

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:code_builder/code_builder.dart' show Scope;
import 'package:code_builder/src/tokens.dart';
import 'package:code_builder/src/builders/class.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/type.dart';

part 'expression/assert.dart';
part 'expression/assign.dart';
part 'expression/binary.dart';
part 'expression/if.dart';
part 'expression/invocation.dart';
part 'expression/literal.dart';
part 'expression/mixin.dart';
part 'expression/negate.dart';
part 'expression/parentheses.dart';
part 'expression/return.dart';

/// Builds an [Expression] AST.
abstract class ExpressionBuilder
    implements StatementBuilder, ValidParameterMember {
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
  IfStatementBuilder asIf();

  /// Returns _as_ a constructor initializer setting [field]
  ConstructorInitializerBuilder asInitializer(String field);

  /// Returns _as_ a statement that `return`s this expression.
  ///
  /// __Example use__:
  ///   literalTrue.asReturn() // Outputs "return true;"
  StatementBuilder asReturn();

  /// Returns _as_ a statement.
  ///
  /// **NOTE**: An [ExpressionBuilder] _is_ a [StatementBuilder]; this cast
  /// is only necessary if you explicitly want [buildAst] to return a
  /// [Statement] object, not an [Expression].
  ///
  /// __Example use__:
  ///   literalTrue.asStatement() // Outputs "true;"
  StatementBuilder asStatement() => new _AsStatement(this);

  /// Returns _as_ an expression calling itself.
  ///
  /// __Example use__:
  ///   reference('foo').call() // Outputs "foo()"
  ExpressionSelfInvocationBuilder call([Iterable<ExpressionBuilder> arguments]);

  /// Returns _as_ an expression calling itself.
  ///
  /// Unlike [call], may specify either [named] and/or [positional] arguments.
  ExpressionSelfInvocationBuilder callWith({
    Map<String, ExpressionBuilder> named,
    Iterable<ExpressionBuilder> positional,
  });

  /// Returns _as_ an expression accessing and calling [method].
  ///
  /// __Example use__:
  ///   literalTrue.invoke('toString') // Outputs true.toString()
  ExpressionInvocationBuilder invoke(
    String method, [
    Iterable<ExpressionBuilder> arguments,
  ]);

  /// Returns _as_ an expression accessing and calling [method].
  ///
  /// Unlike [invoke], may specify either [named] and/or [positional] arguments.
  ExpressionInvocationBuilder invokeWith(
    String method, {
    Map<String, ExpressionBuilder> named,
    Iterable<ExpressionBuilder> positional,
  });

  /// Returns _as_ an expression using the equality operator on [other].
  ///
  /// __Example use__:
  ///   literalTrue.equals(literalTrue) // Outputs "true == true"
  ExpressionBuilder equals(ExpressionBuilder other);

  /// Returns _as_ an expression using the not-equals operator on [other].
  ///
  /// __Example use__:
  ///   literalTrue.notEquals(literalTrue) // Outputs "true != true"
  ExpressionBuilder notEquals(ExpressionBuilder other);

  /// Returns _as_ an expression negating this one.
  ///
  /// __Example use__:
  ///   literalTrue.not() // Outputs "!true"
  ExpressionBuilder not();

  /// Returns _as_ an expression summing this and [other].
  ExpressionBuilder operator +(ExpressionBuilder other);

  /// Returns _as_ an expression wrapped in parentheses.
  ///
  /// __Example use__:
  ///   literalTrue.parentheses() // Outputs "(true)"
  ExpressionBuilder parentheses();

  /// Returns as an [Expression] AST.
  Expression buildExpression([Scope scope = Scope.identity]);

  /// Returns as a [Statement] AST.
  @override
  Statement buildStatement([Scope scope = Scope.identity]);
}
