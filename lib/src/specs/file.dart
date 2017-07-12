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

part 'file.g.dart';

@immutable
abstract class File implements Built<File, FileBuilder>, Spec {
  factory File([void updates(FileBuilder b)]) = _$File;

  File._();

  BuiltList<Directive> get directives;
  BuiltList<Spec> get body;

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitFile(this);
}

abstract class FileBuilder implements Builder<File, FileBuilder> {
  factory FileBuilder() = _$FileBuilder;

  FileBuilder._();

  ListBuilder<Directive> directives = new ListBuilder<Directive>();
  ListBuilder<Spec> body = new ListBuilder<Spec>();
}
