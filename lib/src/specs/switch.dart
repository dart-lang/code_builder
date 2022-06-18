// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:meta/meta.dart';

import '../../code_builder.dart';
import '../mixins/dartdoc.dart';
import '../visitors.dart';

part 'switch.g.dart';

@immutable
abstract class Switch extends Object
    with HasDartDocs
    implements Built<Switch, SwitchBuilder>, Spec {
  factory Switch([void Function(SwitchBuilder) updates]) = _$Switch;

  Switch._();

  Expression get condition;

  BuiltList<SwitchCase> get cases;

  Code? get default$;

  @override
  BuiltList<String> get docs;

  @override
  R accept<R>(
    SpecVisitor<R> visitor, [
    R? context,
  ]) =>
      visitor.visitSwitch(this, context);
}

abstract class SwitchBuilder extends Object
    with HasDartDocsBuilder
    implements Builder<Switch, SwitchBuilder> {
  factory SwitchBuilder() = _$SwitchBuilder;

  SwitchBuilder._();

  Expression? condition;

  ListBuilder<SwitchCase> cases = ListBuilder<SwitchCase>();

  Code? default$;

  @override
  ListBuilder<String> docs = ListBuilder<String>();
}

@immutable
abstract class SwitchCase extends Object
    with HasDartDocs
    implements Built<SwitchCase, SwitchCaseBuilder> {
  factory SwitchCase([void Function(SwitchCaseBuilder) updates]) = _$SwitchCase;

  SwitchCase._();

  Expression? get condition;

  Code? get body;

  /// Whether this case should be suffixed with 'break'.
  bool? get break$;

  @override
  BuiltList<String> get docs;
}

abstract class SwitchCaseBuilder extends Object
    with HasDartDocsBuilder
    implements Builder<SwitchCase, SwitchCaseBuilder> {
  factory SwitchCaseBuilder() = _$SwitchCaseBuilder;

  SwitchCaseBuilder._();

  Expression? condition;

  Code? body;

  /// Whether this case should be suffixed with 'break'.
  bool? break$ = true;

  @override
  ListBuilder<String> docs = ListBuilder<String>();
}
