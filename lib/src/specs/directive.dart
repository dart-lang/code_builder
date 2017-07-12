// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.directive;

import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../visitors.dart';

part 'directive.g.dart';

@immutable
abstract class Directive implements Built<Directive, DirectiveBuilder>, Spec {
  factory Directive([void updates(DirectiveBuilder b)]) = _$Directive;

  factory Directive.import(
    String url, {
    String as,
  }) =>
      new Directive((builder) => builder
        ..as = as
        ..type = DirectiveType.import
        ..url = url);

  factory Directive.export(String url) => new Directive((builder) => builder
    ..type = DirectiveType.export
    ..url = url);

  Directive._();

  @nullable
  String get as;

  String get url;

  DirectiveType get type;

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitDirective(this);
}

abstract class DirectiveBuilder
    implements Builder<Directive, DirectiveBuilder> {
  factory DirectiveBuilder() = _$DirectiveBuilder;

  DirectiveBuilder._();

  String as;

  String url;

  DirectiveType type;
}

enum DirectiveType {
  import,
  export,
}
