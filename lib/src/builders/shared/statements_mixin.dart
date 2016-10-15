import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';

/// A builder that supports adding statements.
abstract class HasStatements {
  /// Lazily adds [statement] as a builder.
  ///
  /// When the AST is built, [StatementBuilder.buildStatement] is invoked.
  void addStatement(StatementBuilder statement);

  /// Lazily adds [statements] as builders.
  ///
  /// When the AST is built, [StatementBuilder.buildStatement] is invoked.
  void addStatements(Iterable<StatementBuilder> statements);
}

/// A mixin to add [addStatement] and [addStatements] to a builder.
abstract class HasStatementsMixin implements HasStatements {
  final List<StatementBuilder> _statements = <StatementBuilder>[];

  @override
  void addStatement(StatementBuilder statement) {
    _statements.add(statement);
  }

  @override
  void addStatements(Iterable<StatementBuilder> statements) {
    _statements.addAll(statements);
  }

  /// Clones all added statements to [mixin].
  void cloneStatementsTo(HasStatements mixin) {
    mixin.addStatements(_statements);
  }

  /// Whether any statements have been added.
  bool get hasStatements => _statements.isNotEmpty;

  /// Returns a built list of [Annotation] ASTs.
  List<Statement> toStatementAsts([Scope scope = Scope.identity]) {
    return _statements
        .map/*<Statement>*/((a) => a.buildStatement(scope))
        .toList();
  }
}
