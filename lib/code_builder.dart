// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';

export 'src/builders/annotation.dart' show AnnotationBuilder;
export 'src/builders/class.dart'
    show asStatic, clazz, extend, implement, mixin, ClassBuilder;
export 'src/builders/expression.dart'
    show literal, ExpressionBuilder, InvocationBuilder;
export 'src/builders/field.dart'
    show varConst, varField, varFinal, FieldBuilder;
export 'src/builders/method.dart'
    show
        constructor,
        constructorNamed,
        getter,
        setter,
        thisField,
        lambda,
        method,
        named,
        ConstructorBuilder,
        MethodBuilder,
        ValidMethodMember;
export 'src/builders/parameter.dart' show parameter, ParameterBuilder;
export 'src/pretty_printer.dart' show prettyToSource;
export 'src/builders/reference.dart'
    show explicitThis, reference, ReferenceBuilder;
export 'src/builders/shared.dart' show AstBuilder, Scope;
export 'src/builders/statement.dart'
    show ifThen, elseIf, elseThen, IfStatementBuilder, StatementBuilder;
export 'src/builders/type.dart' show NewInstanceBuilder, TypeBuilder;

final _dartFmt = new DartFormatter();

/// Returns [source] formatted by `dartfmt`.
@visibleForTesting
String dartfmt(String source) {
  try {
    return _dartFmt.format(source);
  } on FormatterException catch (_) {
    return _dartFmt.formatStatement(source);
  }
}
