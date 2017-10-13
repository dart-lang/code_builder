// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.code;

import 'package:meta/meta.dart';

import '../allocator.dart';
import '../base.dart';
import '../visitors.dart';

import 'reference.dart';

/// Returns a scoped symbol to [Reference], with an import prefix if needed.
///
/// This is short-hand for [Allocator.allocate] in most implementations.
typedef String Allocate(Reference reference);

/// Represents arbitrary Dart code (either expressions or statements).
///
/// See the various constructors for details.
abstract class Code implements Spec {
  /// Create a simple code body based on a static string.
  const factory Code(String code) = StaticCode._;

  /// Create a code based that may use a provided [Allocator] for scoping:
  ///
  /// ```dart
  /// // Emits `new _i123.FooType()`, where `_i123` is the import prefix.
  ///
  /// new Code.scope((a) {
  ///   return 'new ${a.allocate(fooType)}()'
  /// });
  /// ```
  const factory Code.scope(
    String Function(Allocate allocate) scope,
  ) = ScopedCode._;

  @override
  R accept<R>(covariant CodeVisitor<R> visitor, [R context]);
}

/// Knowledge of different types of blocks of code in Dart.
///
/// **INTERNAL ONLY**.
abstract class CodeVisitor<T> implements SpecVisitor<T> {
  T visitStaticCode(StaticCode code, [T context]);
  T visitScopedCode(ScopedCode code, [T context]);
}

/// Knowledge of how to write valid Dart code from [CodeVisitor].
abstract class CodeEmitter implements CodeVisitor<StringSink> {
  @protected
  Allocator get allocator;

  @override
  visitStaticCode(StaticCode code, [StringSink output]) {
    output ??= new StringBuffer();
    return output..write(code.code);
  }

  @override
  visitScopedCode(ScopedCode code, [StringSink output]) {
    output ??= new StringBuffer();
    return output..write(code.code(allocator.allocate));
  }
}

/// Represents a simple, literal [code] block to be inserted as-is.
class StaticCode implements Code {
  final String code;

  const StaticCode._(this.code);

  @override
  R accept<R>(CodeVisitor<R> visitor, [R context]) {
    return visitor.visitStaticCode(this, context);
  }
}

/// Represents a [code] block that may require scoping.
class ScopedCode implements Code {
  final String Function(Allocate allocate) code;

  const ScopedCode._(this.code);

  @override
  R accept<R>(CodeVisitor<R> visitor, [R context]) {
    return visitor.visitScopedCode(this, context);
  }
}
