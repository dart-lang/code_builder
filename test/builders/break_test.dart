// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/src/builders/statement/break.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  test('should emit a break statement', () {
    expect(breakStatement, equalsSource('break;'));
  });
}
