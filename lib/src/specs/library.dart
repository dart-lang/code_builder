// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.library;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../visitors.dart';
import 'directive.dart';

part 'library.g.dart';

@Deprecated('Replace with "Library" by 3.0.0')
abstract class File implements Built<File, FileBuilder>, Spec {
  factory File([void updates(FileBuilder b)]) = _$File;
  File._();

  BuiltList<Directive> get directives;
  BuiltList<Spec> get body;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R context,
  ]) =>
      visitor.visitFile(this, context);
}

@Deprecated('Replace with "LibraryBuilder" by 3.0.0')
abstract class FileBuilder implements Builder<File, FileBuilder> {
  factory FileBuilder() = _$FileBuilder;
  FileBuilder._();

  ListBuilder<Directive> directives = new ListBuilder<Directive>();
  ListBuilder<Spec> body = new ListBuilder<Spec>();
}

@immutable
// TODO: Remove File in 3.0.0.
// ignore: deprecated_member_use
class Library extends _$File implements Spec {
  factory Library([void updates(LibraryBuilder b)]) {
    return (new LibraryBuilder()..update(updates)).build();
  }

  Library._({
    BuiltList<Directive> directives,
    BuiltList<Spec> body,
  })
      : super._(directives: directives, body: body);
}

// TODO: Remove File in 3.0.0.
//
// This implementation is imperfect (not identical to the code emitted by
// the built_value package but seems to the only way to adhere to the
// inheritance chain without breaking the code generator).
//
// May be changed as a result of
// https://github.com/google/built_value.dart/issues/257.
//
// ignore: deprecated_member_use
class LibraryBuilder implements FileBuilder {
  @override
  ListBuilder<Spec> body = new ListBuilder<Spec>();

  @override
  ListBuilder<Directive> directives = new ListBuilder<Directive>();

  @override
  Library build() {
    return new Library._(directives: directives.build(), body: body.build());
  }

  @override
  void replace(covariant Library other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    body = other.body.toBuilder();
    directives = other.directives.toBuilder();
  }

  @override
  void update(void updates(LibraryBuilder builder)) {
    if (updates != null) {
      updates(this);
    }
  }
}
