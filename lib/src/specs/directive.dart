// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.directive;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../visitors.dart';

part 'directive.g.dart';

@immutable
abstract class Directive implements Built<Directive, CodeBuilder>, Spec {
  factory Directive([void updates(CodeBuilder b)]) = _$Directive;

  Directive._();

  String get url;

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitCode(this);
}

abstract class CodeBuilder implements Builder<Directive, CodeBuilder> {
  factory CodeBuilder() = _$Directive;

  CodeBuilder._();

  String url;
}
