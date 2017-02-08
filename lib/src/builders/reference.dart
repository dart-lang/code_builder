// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/file.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/builders/type.dart';
import 'package:code_builder/src/tokens.dart';

/// An explicit reference to `this`.
final ReferenceBuilder explicitThis = reference('this');

/// Creates a reference called [name].
///
/// **NOTE**: To refer to a _generic_ type, use [TypeBuilder] instead:
///     // Refer to `List<String>`
///     new TypeBuilder(
///       'List',
///       genericTypes: [reference('String')],
///     )
ReferenceBuilder reference(String name, [String importUri]) {
  return new ReferenceBuilder._(name, importUri);
}

/// An abstract way of representing other types of [AstBuilder].
class ReferenceBuilder extends Object
    with AbstractExpressionMixin, AbstractTypeBuilderMixin, TopLevelMixin
    implements AnnotationBuilder, ExpressionBuilder, TypeBuilder {
  final String _importFrom;
  final String _name;

  ReferenceBuilder._(this._name, [this._importFrom]);

  @override
  Annotation buildAnnotation([Scope scope]) {
    return astFactory.annotation(
      $at,
      identifier(scope, _name, _importFrom),
      null,
      null,
      null,
    );
  }

  @override
  AstNode buildAst([Scope scope]) => buildType(scope);

  @override
  Expression buildExpression([Scope scope]) {
    return identifier(
      scope,
      _name,
      _importFrom,
    );
  }

  @override
  TypeName buildType([Scope scope]) {
    return new TypeBuilder(_name, importFrom: _importFrom).buildType(scope);
  }

  @override
  ExportBuilder toExportBuilder() {
    if (_importFrom == null) {
      throw new StateError('Cannot create an import - no URI provided');
    }
    return new ExportBuilder(_importFrom)..show(_name);
  }

  @override
  ImportBuilder toImportBuilder({bool deferred: false, String prefix}) {
    if (_importFrom == null) {
      throw new StateError('Cannot create an import - no URI provided');
    }
    return new ImportBuilder(
      _importFrom,
      deferred: deferred,
      prefix: prefix,
    )..show(_name);
  }

  /// Returns a new [ReferenceBuilder] with [genericTypes].
  ///
  /// Example use:
  ///     // List<String>
  ///     reference('List').toTyped([reference('String')])
  ReferenceBuilder toTyped(Iterable<TypeBuilder> genericTypes) {
    return new _TypedReferenceBuilder(
        genericTypes.toList(), _name, _importFrom);
  }
}

class _TypedReferenceBuilder extends ReferenceBuilder {
  final List<TypeBuilder> _genericTypes;

  _TypedReferenceBuilder(
    this._genericTypes,
    String name,
    String importFrom,
  )
      : super._(name, importFrom);

  @override
  TypeName buildType([Scope scope]) {
    return new TypeBuilder(
      _name,
      importFrom: _importFrom,
      genericTypes: _genericTypes,
    )
        .buildType(scope);
  }
}
