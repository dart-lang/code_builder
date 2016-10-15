// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Contains references to the `dart:core` library for use in code generation.
///
/// This library is currently *experimental*, and is subject to change; it
/// currently is manually written but there might be a strong use case for this
/// to be automatically generated (at least partially) in the near future.
library code_builder.dart.core;

import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/reference.dart';
import 'package:code_builder/src/builders/type.dart';

/// An alias for `new AnnotationBuilder('override')`.
final ReferenceBuilder atOverride = reference(
  'override',
  'dart:core',
);

/// A reference to the `print` method.
final ReferenceBuilder printMethod = reference(
  'print',
  'dart:core',
);

/// An alias for `new TypeBuilder('bool')`.
final TypeBuilder typeBool = new TypeBuilder(
  'bool',
  importFrom: 'dart:core',
);

/// An alias for `new TypeBuilder('DateTime')`.
final TypeBuilder typeDateTime = new TypeBuilder(
  'DateTime',
  importFrom: 'dart:core',
);

/// An alias for `new TypeBuilder('double')`.
final TypeBuilder typeDouble = new TypeBuilder(
  'double',
  importFrom: 'dart:core',
);

/// An alias for `new TypeBuilder('Duration')`.
final TypeBuilder typeDuration = new TypeBuilder(
  'Duration',
  importFrom: 'dart:core',
);

/// An alias for `new TypeBuilder('Expando')`.
final TypeBuilder typeExpando = new TypeBuilder(
  'Expando',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Function')`.
final TypeBuilder typeFunction = new TypeBuilder(
  'Function',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('int')`.
final TypeBuilder typeInt = new TypeBuilder(
  'int',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Iterable')`.
final TypeBuilder typeIterable = new TypeBuilder(
  'Iterable',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('List')`.
final TypeBuilder typeList = new TypeBuilder(
  'List',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Map')`.
final TypeBuilder typeMap = new TypeBuilder(
  'Map',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Null')`.
final TypeBuilder typeNull = new TypeBuilder(
  'Null',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('num')`.
final TypeBuilder typeNum = new TypeBuilder(
  'num',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Object')`.
final TypeBuilder typeObject = new TypeBuilder(
  'Object',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Set')`.
final TypeBuilder typeSet = new TypeBuilder(
  'Set',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('String')`.
final TypeBuilder typeString = new TypeBuilder(
  'String',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Symbol')`.
final TypeBuilder typeSymbol = new TypeBuilder(
  'Symbol',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Type')`.
final TypeBuilder typeType = new TypeBuilder(
  'Type',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Uri')`.
final TypeBuilder typeUri = new TypeBuilder(
  'Uri',
  importFrom: 'dart:core',
);

/// Creates either a `@deprecated` or `@Deprecated('Message')` annotation.
AnnotationBuilder atDeprecated([String message]) {
  if (message == null) {
    return reference('deprecated', 'dart:core');
  }
  throw new UnimplementedError();
}
