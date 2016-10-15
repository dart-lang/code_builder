// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  group('literal', () {
    test('should emit a null', () {
      expect(literal(null), equalsSource(r'null'));
    });

    test('should emit true', () {
      expect(literal(true), equalsSource(r'true'));
    });

    test('should emit false', () {
      expect(literal(false), equalsSource(r'false'));
    });

    test('should emit an int', () {
      expect(literal(5), equalsSource(r'5'));
    });

    test('should emit a double', () {
      expect(literal(5.5), equalsSource(r'5.5'));
    });

    test('should emit a string', () {
      expect(literal('Hello'), equalsSource(r"'Hello'"));
    });

    test('should emit a list', () {
      expect(literal([1, 2, 3]), equalsSource(r'[1, 2, 3]'));
    });

    test('should emit a map', () {
      expect(literal({1: 2, 2: 3}), equalsSource(r'{1 : 2, 2 : 3}'));
    });
  });
}
