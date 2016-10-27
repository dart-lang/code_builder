// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/tokens.dart';
import 'package:test/test.dart';

void main() {
  test('stringIdentifier should return a string identifier', () {
    expect(stringIdentifier('Coffee').toSource(), 'Coffee');
  });

  test('stringToken should return a string token', () {
    expect(stringToken('Coffee').value().toString(), 'Coffee');
  });
}
