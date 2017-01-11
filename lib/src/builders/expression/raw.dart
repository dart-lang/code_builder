// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:func/func.dart';

class RawExpressionBuilder extends Object
    with AbstractExpressionMixin, TopLevelMixin
    implements ExpressionBuilder {
  final Func1<Scope, String> _raw;

  RawExpressionBuilder(this._raw);

  @override
  AstNode buildAst([Scope scope]) {
    FunctionDeclaration d =
        parseCompilationUnit('main() => ${_raw(scope)};').declarations.first;
    ExpressionFunctionBody f = d.functionExpression.body;
    return f.expression;
  }

  @override
  Expression buildExpression([Scope scope]) => buildAst(scope);
}
