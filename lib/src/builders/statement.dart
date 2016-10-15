import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart' show AstBuilder, Scope;
import 'package:code_builder/src/builders/shared.dart';

/// Builds an [Statement] AST.
abstract class StatementBuilder implements AstBuilder, ValidConstructorMember {
  @override
  AstNode buildAst([Scope scope = Scope.identity]) => buildStatement(scope);

  /// Returns a Dart [Statement] AST reprsenting the current builder state.
  Statement buildStatement([Scope scope = Scope.identity]);
}
