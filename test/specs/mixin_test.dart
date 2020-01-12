// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  useDartfmt();

  test('should create a mixin', () {
    expect(
      Mixin((b) => b..name = 'Foo'),
      equalsDart(r'''
        mixin Foo {}
      '''),
    );
  });

  test('should create a mixin with documentations', () {
    expect(
      Mixin(
        (b) => b
          ..name = 'Foo'
          ..docs.addAll(
            const [
              '/// My favorite mixin.',
            ],
          ),
      ),
      equalsDart(r'''
        /// My favorite mixin.
        mixin Foo {}
      '''),
    );
  });

  test('should create a mixin with annotations', () {
    expect(
      Mixin(
        (b) => b
          ..name = 'Foo'
          ..annotations.addAll([
            refer('deprecated'),
            refer('Deprecated').call([literalString('This is an old mixin')])
          ]),
      ),
      equalsDart(r'''
        @deprecated
        @Deprecated('This is an old mixin')
        mixin Foo {}
      '''),
    );
  });

  test('should create a mixin with a generic type', () {
    expect(
      Mixin((b) => b
        ..name = 'List'
        ..types.add(refer('T'))),
      equalsDart(r'''
        mixin List<T> {}
      '''),
    );
  });

  test('should create a mixin with multiple generic types', () {
    expect(
      Mixin(
        (b) => b
          ..name = 'Map'
          ..types.addAll([
            refer('K'),
            refer('V'),
          ]),
      ),
      equalsDart(r'''
        mixin Map<K, V> {}
      '''),
    );
  });

  test('should create a mixin with a bound generic type', () {
    expect(
      Mixin((b) => b
        ..name = 'Comparable'
        ..types.add(TypeReference((b) => b
          ..symbol = 'T'
          ..bound = TypeReference((b) => b
            ..symbol = 'Comparable'
            ..types.add(refer('T').type))))),
      equalsDart(r'''
        mixin Comparable<T extends Comparable<T>> {}
      '''),
    );
  });

  test('should create a mixin on another mixin', () {
    expect(
      Mixin((b) => b
        ..name = 'Foo'
        ..on = TypeReference((b) => b.symbol = 'Bar')),
      equalsDart(r'''
        mixin Foo on Bar {}
      '''),
    );
  });

  test('should create a mixin implementing another mixin', () {
    expect(
      Mixin((b) => b
        ..name = 'Foo'
        ..on = TypeReference((b) => b.symbol = 'Bar')
        ..implements.add(TypeReference((b) => b.symbol = 'Foo'))),
      equalsDart(r'''
        mixin Foo on Bar implements Foo {}
      '''),
    );
  });

  test('should create a mixin with a method', () {
    expect(
      Mixin((b) => b
        ..name = 'Foo'
        ..methods.add(Method((b) => b
          ..name = 'foo'
          ..body = const Code('return 1+ 2;')))),
      equalsDart(r'''
        mixin Foo {
          foo() {
            return 1 + 2;
          }
        }
      '''),
    );
  });
}
