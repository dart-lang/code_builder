// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.reference;

import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../visitors.dart';
import 'type_reference.dart';

/// A reference to [symbol], such as a class, or top-level method or field.
///
/// References can be collected and collated in order to automatically generate
/// `import` statements for all used symbols.
@immutable
class Reference implements Spec {
  /// Relative, `package:` or `dart:` URL of the library.
  ///
  /// May be omitted (`null`) in order to express "same library".
  final String url;

  /// Name of the class, method, or field.
  final String symbol;

  /// Create a reference to [symbol] in [url].
  const Reference(this.symbol, this.url);

  /// Create a reference to [symbol] in the same library (no import statement).
  const Reference.localScope(this.symbol) : url = null;

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitReference(this);

  @override
  int get hashCode => '$url#$symbol'.hashCode;

  @override
  bool operator ==(Object o) =>
      o is Reference && o.url == url && o.symbol == symbol;

  @override
  String toString() => (newBuiltValueToStringHelper('Reference')
        ..add('url', url)
        ..add('symbol', symbol))
      .toString();

  /// Returns as a [TypeReference], which allows adding generic type parameters.
  TypeReference toType() => new TypeReference((b) => b
    ..url = url
    ..symbol = symbol);
}
