// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/builders/statement/switch.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  test('should emit an empty switch statement', () {
    expect(switchStatement(reference('foo')), equalsSource('''
    switch (foo) {}
    '''));
  });

  test('should emit cases', () {
    expect(
        switchStatement(reference('foo'), cases: [
          switchCase(literal('bar'), [literal('baz').asReturn()]),
          switchCase(literal(42) * literal(5), [
            reference('math')
                .call([literal(24) + reference('three')]).asReturn()
          ])
        ]),
        equalsSource('''
    switch (foo) {
      case 'bar':
        return 'baz';
      case 42 * 5:
        return math(24 + three);
    }
    '''));
  });

  test('should emit default case if given', () {
    expect(
        switchStatement(reference('foo'),
            cases: [
              switchCase(literal('bar'), [literal('baz').asReturn()])
            ],
            defaultCase: switchDefault([literal(null).asReturn()])),
        equalsSource('''
    switch(foo) {
      case 'bar':
        return 'baz';
      default:
        return null;
    }
    '''));
  });
}
