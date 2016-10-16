// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';

export 'src/builders/annotation.dart' show AnnotationBuilder;
export 'src/builders/class.dart'
    show clazz, extend, implement, mixin, ClassBuilder;
export 'src/builders/expression.dart' show literal, ExpressionBuilder;
export 'src/builders/method.dart' show constructor, constructorNamed, fieldFormal, method, named, ConstructorBuilder, MethodBuilder;
export 'src/builders/parameter.dart' show parameter, ParameterBuilder;
export 'src/builders/reference.dart' show reference, ReferenceBuilder;
export 'src/builders/shared.dart' show AstBuilder, Scope;
export 'src/builders/statement.dart' show StatementBuilder;

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
