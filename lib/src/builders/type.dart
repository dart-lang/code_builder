// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/method.dart';
import 'package:code_builder/src/builders/parameter.dart';
import 'package:code_builder/src/builders/shared.dart';

/// Lazily builds an [TypeName] AST when [buildType] is invoked.
class TypeBuilder
    implements AstBuilder, ValidMethodMember, ValidParameterMember {
  final String _importFrom;
  final String _name;

  /// Creates a new [TypeBuilder].
  factory TypeBuilder(String name, [String importFrom]) = TypeBuilder._;

  TypeBuilder._(this._name, [this._importFrom]);

  @override
  AstNode buildAst([Scope scope]) => buildType(scope);

  /// Returns an [TypeName] AST representing the builder.
  TypeName buildType([Scope scope]) {
    return new TypeName(
      getIdentifier(
        scope,
        _name,
        _importFrom != null ? Uri.parse(_importFrom) : null,
      ),
      null,
    );
  }
}
