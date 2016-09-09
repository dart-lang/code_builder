// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing/equals_source.dart';
import 'package:test/test.dart';

void main() {
  test('should emit an unitialized simple variable', () {
    expect(
      new FieldBuilder('name'),
      equalsSource(r'var name;'),
    );
  });

  test('should emit a typed variable', () {
    expect(
      new FieldBuilder('name', type: typeString),
      equalsSource(r'String name;'),
    );
  });

  test('should emit an initialized variable', () {
    expect(
      new FieldBuilder(
        'name',
        type: typeString,
        initialize: const LiteralString('Jill User'),
      ),
      equalsSource(r"String name = 'Jill User';"),
    );
  });

  test('should emit a final variable', () {
    expect(
      new FieldBuilder.isFinal('name'),
      equalsSource(r'final name;'),
    );
  });

  test('should emit a const variable', () {
    expect(
      new FieldBuilder.isConst('name'),
      equalsSource(r'const name;'),
    );
  });
}
