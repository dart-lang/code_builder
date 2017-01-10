// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:func/func.dart';

class RawStatementBuilder implements StatementBuilder {
  final Func1<Scope, String> _raw;

  const RawStatementBuilder(this._raw);

  @override
  AstNode buildAst([Scope scope]) {
    FunctionDeclaration d =
        parseCompilationUnit('raw() { ${_raw(scope)} }').declarations.first;
    BlockFunctionBody f = d.functionExpression.childEntities.elementAt(1);
    Block b = f.childEntities.first;
    return b.statements.first;
  }

  @override
  Statement buildStatement([Scope scope]) => buildAst(scope);

  @override
  CompilationUnitMember buildTopLevelAst([Scope scope]) => buildAst(scope);
}
