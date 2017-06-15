// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

final TypeBuilder _barType = new TypeBuilder('Bar');

void main() {
  test('should emit an `is` expression', () {
    expect(reference('foo').isInstanceOf(_barType), equalsSource('foo is Bar'));
  });

  test('should emit an `is!` expression', () {
    expect(reference('foo').isNotInstanceOf(_barType),
        equalsSource('foo is! Bar'));
  });
}
