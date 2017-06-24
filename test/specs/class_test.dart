// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should create a class', () {
    expect(
      new Class((b) => b..name = 'Foo'),
      equalsDart(r'''
        class Foo {}
      '''),
    );
  });

  test('should create an abstract class', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..abstract = true),
      equalsDart(r'''
        abstract class Foo {}
      '''),
    );
  });

  test('should create a class with documentations', () {
    expect(
      new Class(
        (b) => b
          ..name = 'Foo'
          ..docs.addAll(
            const [
              '/// My favorite class.',
            ],
          ),
      ),
      equalsDart(r'''
        /// My favorite class.
        class Foo {}
      '''),
    );
  });

  test('should create a class with a generic type', () {
    expect(
      new Class((b) => b
        ..name = 'List'
        ..types.add(const Reference.localScope('T').toType())),
      equalsDart(r'''
        class List<T> {}
      '''),
    );
  });

  test('should create a class with multiple generic types', () {
    expect(
      new Class(
        (b) => b
          ..name = 'Map'
          ..types.addAll([
            const Reference.localScope('K').toType(),
            const Reference.localScope('V').toType(),
          ]),
      ),
      equalsDart(r'''
        class Map<K, V> {}
      '''),
    );
  });

  test('should create a class with a bound generic type', () {
    expect(
      new Class((b) => b
        ..name = 'Comparable'
        ..types.add(new TypeReference((b) => b
          ..symbol = 'T'
          ..bound = new TypeReference((b) => b
            ..symbol = 'Comparable'
            ..types.add(const Reference.localScope('T').toType()))))),
      equalsDart(r'''
        class Comparable<T extends Comparable<T>> {}
      '''),
    );
  });

  test('should create a class extending another class', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..extend = new TypeReference((b) => b.symbol = 'Bar')),
      equalsDart(r'''
        class Foo extends Bar {}
      '''),
    );
  });

  test('should create a class mixing in another class', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..extend = new TypeReference((b) => b.symbol = 'Bar')
        ..mixins.add(new TypeReference((b) => b.symbol = 'Foo'))),
      equalsDart(r'''
        class Foo extends Bar with Foo {}
      '''),
    );
  });

  test('should create a class implementing another class', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..extend = new TypeReference((b) => b.symbol = 'Bar')
        ..implements.add(new TypeReference((b) => b.symbol = 'Foo'))),
      equalsDart(r'''
        class Foo extends Bar implements Foo {}
      '''),
    );
  });
}
