// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Contains references to the `dart:core` library for use in code generation.
///
/// This library is currently *experimental*, and is subject to change; it
/// currently is manually written but there might be a strong use case for this
/// to be automatically generated (at least partially) in the near future.
library code_builder.dart.core;

import 'package:code_builder/code_builder.dart';

/// An alias for `new AnnotationBuilder('override')`.
const AnnotationBuilder atOverride = const AnnotationBuilder.reference(
  'override',
  'dart:core',
);

/// An alias for `new TypeBuilder('bool')`.
const TypeBuilder typeBool = const TypeBuilder(
  'bool',
  importFrom: 'dart:core',
);

/// An alias for `new TypeBuilder('DateTime')`.
const TypeBuilder typeDateTime = const TypeBuilder(
  'DateTime',
  importFrom: 'dart:core',
);

/// An alias for `new TypeBuilder('double')`.
const TypeBuilder typeDouble = const TypeBuilder(
  'double',
  importFrom: 'dart:core',
);

/// An alias for `new TypeBuilder('Duration')`.
const TypeBuilder typeDuration = const TypeBuilder(
  'Duration',
  importFrom: 'dart:core',
);

/// An alias for `new TypeBuilder('Expando')`.
const TypeBuilder typeExpando = const TypeBuilder(
  'Expando',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Function')`.
const TypeBuilder typeFunction = const TypeBuilder(
  'Function',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('int')`.
const TypeBuilder typeInt = const TypeBuilder(
  'int',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Iterable')`.
const TypeBuilder typeIterable = const TypeBuilder(
  'Iterable',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('List')`.
const TypeBuilder typeList = const TypeBuilder(
  'List',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Map')`.
const TypeBuilder typeMap = const TypeBuilder(
  'Map',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Null')`.
const TypeBuilder typeNull = const TypeBuilder(
  'Null',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('num')`.
const TypeBuilder typeNum = const TypeBuilder(
  'num',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Object')`.
const TypeBuilder typeObject = const TypeBuilder(
  'Object',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Set')`.
const TypeBuilder typeSet = const TypeBuilder(
  'Set',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('String')`.
const TypeBuilder typeString = const TypeBuilder(
  'String',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Symbol')`.
const TypeBuilder typeSymbol = const TypeBuilder(
  'Symbol',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Type')`.
const TypeBuilder typeType = const TypeBuilder(
  'Type',
  importFrom: 'dart:core',
);

/// An alias for `const  TypeBuilder('Uri')`.
const TypeBuilder typeUri = const TypeBuilder(
  'Uri',
  importFrom: 'dart:core',
);

/// Creates either a `@deprecated` or `@Deprecated('Message')` annotation.
AnnotationBuilder atDeprecated([String message]) {
  if (message == null) {
    return new AnnotationBuilder.reference('deprecated', 'dart:core');
  }
  return new AnnotationBuilder.invoke(
    'Deprecated',
    positional: [new LiteralString(message)],
  );
}
