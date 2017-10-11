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
    List<String> show: const [],
    List<String> hide: const [],
  }) =>
      new Directive((builder) => builder
        ..as = as
        ..type = DirectiveType.import
        ..url = url
        ..show.addAll(show)
        ..hide.addAll(hide));

  factory Directive.importDeferredAs(
    String url,
    String as, {
    List<String> show: const [],
    List<String> hide: const [],
  }) =>
      new Directive((builder) => builder
        ..as = as
        ..type = DirectiveType.import
        ..url = url
        ..deferred = true
        ..show.addAll(show)
        ..hide.addAll(hide));

  factory Directive.export(
    String url, {
    List<String> show: const [],
    List<String> hide: const [],
  }) =>
      new Directive((builder) => builder
        ..type = DirectiveType.export
        ..url = url
        ..show.addAll(show)
        ..hide.addAll(hide));

  Directive._();

  @nullable
  String get as;

  String get url;

  DirectiveType get type;

  List<String> get show;

  List<String> get hide;

  bool get deferred;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R context,
  ]) =>
      visitor.visitDirective(this, context);
}

abstract class DirectiveBuilder
    implements Builder<Directive, DirectiveBuilder> {
  factory DirectiveBuilder() = _$DirectiveBuilder;

  DirectiveBuilder._();

  bool deferred = false;

  String as;

  String url;

  List<String> show = <String>[];

  List<String> hide = <String>[];

  DirectiveType type;
}

enum DirectiveType {
  import,
  export,
}
