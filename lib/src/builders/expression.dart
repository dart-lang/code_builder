import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/shared.dart';

/// Lazily builds an [Expression] AST when [buildExpression] is invoked.
abstract class ExpressionBuilder implements AstBuilder {
  /// Returns an [Expression] AST representing the builder.
  Expression buildExpression([Scope scope]);
}

/// An [AstBuilder] that can add [ExpressionBuilder].
abstract class HasExpressions implements AstBuilder {
  final List<ExpressionBuilder> _expressions = <ExpressionBuilder> [];

  /// Adds [expression] to the builder.
  void addExpression(ExpressionBuilder expression) {
    _expressions.add(expression);
  }

  /// Adds [expressions] to the builder.
  void addExpressions(Iterable<ExpressionBuilder> expressions) {
    _expressions.addAll(expressions);
  }
}

/// Implements [HasExpressions].
abstract class HasExpressionsMixin extends HasExpressions {
  /// Clones all expressions to [clone].
  void cloneExpressionsTo(HasExpressions clone) {
    clone.addExpressions(_expressions);
  }

  /// Returns a [List] of all built [Expression]s.
  List<Expression> buildExpressions([Scope scope]) => _expressions.map/*<Expression>*/((e) => e.buildExpression(scope)).toList();
}
