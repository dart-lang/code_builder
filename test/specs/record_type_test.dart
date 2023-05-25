// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  late DartEmitter emitter;

  useDartfmt();

  setUp(() => emitter = DartEmitter.scoped(useNullSafetySyntax: true));

  final intRef = TypeReference((b) => b.symbol = 'int');
  TypeReference listRef(TypeReference argType) => TypeReference((b) => b
    ..symbol = 'List'
    ..types.add(argType));

  test('should create an empty record type', () {
    expect(RecordType(), equalsDart('()', emitter));
  });

  test('should create a record type with positional fields', () {
    expect(
      RecordType((b) => b
        ..positionalFieldTypes.addAll(
            [intRef, listRef(intRef).rebuild((b) => b..isNullable = true)])
        ..isNullable = true),
      equalsDart('(int, List<int>?)?', emitter),
    );
  });

  test('should create a record type with one positional field', () {
    expect(RecordType((b) => b..positionalFieldTypes.add(intRef)),
        equalsDart('(int,)', emitter));
  });

  test('should create a record type with named fields', () {
    expect(
        RecordType((b) => b
          ..namedFieldTypes.addAll({
            'named': intRef,
            'other': listRef(intRef),
          })),
        equalsDart('({int named, List<int> other})', emitter));
  });

  test('should create a record type with both positional and named fields', () {
    expect(
        RecordType((b) => b
          ..positionalFieldTypes.add(listRef(intRef))
          ..namedFieldTypes.addAll({'named': intRef})
          ..isNullable = true),
        equalsDart('(List<int>, {int named})?', emitter));
  });

  test('should create a nested record type', () {
    expect(
        RecordType((b) => b
          ..positionalFieldTypes.add(RecordType((b) => b
            ..namedFieldTypes.addAll({'named': intRef, 'other': intRef})
            ..isNullable = true))),
        equalsDart('(({int named, int other})?,)', emitter));
  });
}
