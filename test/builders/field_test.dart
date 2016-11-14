// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  test('emit a var', () {
    expect(
      varField('a', type: lib$core.String, value: literal('Hello')),
      equalsSource(r'''
        String a = 'Hello';
      '''),
    );
  });

  test('emit a final', () {
    expect(
      varFinal('a', type: lib$core.String, value: literal('Hello')),
      equalsSource(r'''
        final String a = 'Hello';
      '''),
    );
  });

  test('emit a const', () {
    expect(
      varConst('a', type: lib$core.String, value: literal('Hello')),
      equalsSource(r'''
        const String a = 'Hello';
      '''),
    );
  });
}
