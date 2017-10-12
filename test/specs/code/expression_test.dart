// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should emit a simple expression', () {
    expect(literalNull, equalsDart('null'));
  });

  test('should emit a && expression', () {
    expect(literalTrue.and(literalFalse), equalsDart('true && false'));
  });

  test('should emit a list', () {
    expect(literalList([]), equalsDart('[]'));
  });

  test('should emit a const list', () {
    expect(literalConstList([]), equalsDart('const []'));
  });

  test('should emit a typed list', () {
    expect(literalList([], const Reference('int')), equalsDart('<int>[]'));
  });

  test('should emit a list of other literals and expressions', () {
    expect(
      literalList([
        literalList([]),
        literalTrue,
        literalNull,
        const Reference('Map').toExpression().newInstance([])
      ]),
      equalsDart('[[], true, null, new Map()]'),
    );
  });

  test('should emit a type as an expression', () {
    expect(const Reference('Map').toExpression(), equalsDart('Map'));
  });

  test('should emit a scoped type as an expression', () {
    expect(
      const Reference('Foo', 'package:foo/foo.dart').toExpression(),
      equalsDart('_1.Foo', new DartEmitter(new Allocator.simplePrefixing())),
    );
  });

  test('should emit invoking new Type()', () {
    expect(
      const Reference('Map').toExpression().newInstance([]),
      equalsDart('new Map()'),
    );
  });

  test('should emit invoking a property accessor', () {
    expect(const Reference('foo').property('bar'), equalsDart('foo.bar'));
  });

  test('should emit invoking a method with a single positional argument', () {
    expect(
      const Reference('foo').toExpression().call([
        literal(1),
      ]),
      equalsDart('foo(1)'),
    );
  });

  test('should emit invoking a method with positional arguments', () {
    expect(
      const Reference('foo').toExpression().call([
        literal(1),
        literal(2),
        literal(3),
      ]),
      equalsDart('foo(1, 2, 3)'),
    );
  });

  test('should emit invoking a method with a single named argument', () {
    expect(
      const Reference('foo').toExpression().call([], {
        'bar': literal(1),
      }),
      equalsDart('foo(bar: 1)'),
    );
  });

  test('should emit invoking a method with named arguments', () {
    expect(
      const Reference('foo').toExpression().call([], {
        'bar': literal(1),
        'baz': literal(2),
      }),
      equalsDart('foo(bar: 1, baz: 2)'),
    );
  });

  test('should emit invoking a method with positional and named arguments', () {
    expect(
      const Reference('foo').toExpression().call([
        literal(1)
      ], {
        'bar': literal(2),
        'baz': literal(3),
      }),
      equalsDart('foo(1, bar: 2, baz: 3)'),
    );
  });
}
