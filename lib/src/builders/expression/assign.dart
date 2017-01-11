// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder.src.builders.expression;

class _AsAssign extends AbstractExpressionMixin with TopLevelMixin {
  final bool _nullAware;
  final ExpressionBuilder _value;
  final ExpressionBuilder _target;

  _AsAssign(this._value, this._nullAware, this._target);

  @override
  AstNode buildAst([Scope scope]) => buildExpression(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return astFactory.assignmentExpression(
      _target.buildExpression(scope),
      _nullAware ? $nullAwareEquals : $equals,
      _value.buildExpression(scope),
    );
  }
}

class _AsAssignNew extends TopLevelMixin implements StatementBuilder {
  final ExpressionBuilder _value;
  final String _name;
  final TypeBuilder _type;
  final Token _modifier;

  _AsAssignNew(this._value, this._name, this._type, this._modifier);

  @override
  Statement buildAst([Scope scope]) => buildStatement(scope);

  @override
  Statement buildStatement([Scope scope]) {
    return astFactory.variableDeclarationStatement(
      astFactory.variableDeclarationList(
        null,
        null,
        _type == null || _modifier != $var ? _modifier : null,
        _type?.buildType(scope),
        [
          astFactory.variableDeclaration(
            stringIdentifier(_name),
            $equals,
            _value.buildExpression(scope),
          ),
        ],
      ),
      $semicolon,
    );
  }

  @override
  CompilationUnitMember buildTopLevelAst([Scope scope]) {
    return astFactory.topLevelVariableDeclaration(
      null,
      null,
      astFactory.variableDeclarationList(
        null,
        null,
        _type == null || _modifier != $var ? _modifier : null,
        _type?.buildType(scope),
        [
          astFactory.variableDeclaration(
            stringIdentifier(_name),
            $equals,
            _value.buildExpression(scope),
          ),
        ],
      ),
      $semicolon,
    );
  }
}
