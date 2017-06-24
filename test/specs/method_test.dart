// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should create a method', () {
    expect(
      new Method((b) => b..name = 'foo'),
      equalsDart(r'''
        foo();
      '''),
    );
  });

  test('should create a method with a return type', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..returns = const Reference.localScope('String').toType()),
      equalsDart(r'''
        String foo();
      '''),
    );
  });

  test('should create a method with generic types', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..types.add(const Reference.localScope('T').toType())),
      equalsDart(r'''
        foo<T>();
      '''),
    );
  });

  test('should create an external method', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..external = true),
      equalsDart(r'''
        external foo();
      '''),
    );
  });

  test('should create a method with a body', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..body = new Code((b) => b.code = r'''
          return 1 + 2;
        ''')),
      equalsDart(r'''
        foo() {
          return 1 + 2;
        }
      '''),
    );
  });
}
