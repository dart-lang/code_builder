// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.code;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../visitors.dart';

part 'code.g.dart';

/// Returns a [Spec] to be created lazily on demand.
typedef Spec LazySpec();

@immutable
abstract class Code implements Built<Code, CodeBuilder>, Spec {
  factory Code([void updates(CodeBuilder b)]) = _$Code;

  Code._();

  String get code;

  BuiltMap<String, LazySpec> get specs;

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitCode(this);
}

abstract class CodeBuilder implements Builder<Code, CodeBuilder> {
  factory CodeBuilder() = _$CodeBuilder;

  CodeBuilder._();

  String code;

  MapBuilder<String, LazySpec> specs = new MapBuilder<String, LazySpec>();
}
