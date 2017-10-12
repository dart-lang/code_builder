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

  test('should emit an explicitly typed list', () {
    expect(literalList([], refer('int')), equalsDart('<int>[]'));
  });

  test('should emit a map', () {
    expect(literalMap({}), equalsDart('{}'));
  });

  test('should emit a const map', () {
    expect(literalConstMap({}), equalsDart('const {}'));
  });

  test('should emit an explicitly typed map', () {
    expect(
      literalMap({}, refer('int'), refer('bool')),
      equalsDart('<int, bool>{}'),
    );
  });

  test('should emit a map of other literals and expressions', () {
    expect(
      literalMap({
        1: 'one',
        2: refer('two'),
        refer('three'): 3,
        refer('Map').newInstance([]): null,
      }),
      equalsDart(r"{1: 'one', 2: two, three: 3, new Map(): null}"),
    );
  });

  test('should emit a list of other literals and expressions', () {
    expect(
      literalList([<dynamic>[], true, null, refer('Map').newInstance([])]),
      equalsDart('[[], true, null, new Map()]'),
    );
  });

  test('should emit a type as an expression', () {
    expect(refer('Map'), equalsDart('Map'));
  });

  test('should emit a scoped type as an expression', () {
    expect(
      refer('Foo', 'package:foo/foo.dart'),
      equalsDart('_1.Foo', new DartEmitter(new Allocator.simplePrefixing())),
    );
  });

  test('should emit invoking new Type()', () {
    expect(
      refer('Map').newInstance([]),
      equalsDart('new Map()'),
    );
  });

  test('should emit invoking a property accessor', () {
    expect(refer('foo').property('bar'), equalsDart('foo.bar'));
  });

  test('should emit invoking a method with a single positional argument', () {
    expect(
      refer('foo').call([
        literal(1),
      ]),
      equalsDart('foo(1)'),
    );
  });

  test('should emit invoking a method with positional arguments', () {
    expect(
      refer('foo').call([
        literal(1),
        literal(2),
        literal(3),
      ]),
      equalsDart('foo(1, 2, 3)'),
    );
  });

  test('should emit invoking a method with a single named argument', () {
    expect(
      refer('foo').call([], {
        'bar': literal(1),
      }),
      equalsDart('foo(bar: 1)'),
    );
  });

  test('should emit invoking a method with named arguments', () {
    expect(
      refer('foo').call([], {
        'bar': literal(1),
        'baz': literal(2),
      }),
      equalsDart('foo(bar: 1, baz: 2)'),
    );
  });

  test('should emit invoking a method with positional and named arguments', () {
    expect(
      refer('foo').call([
        literal(1)
      ], {
        'bar': literal(2),
        'baz': literal(3),
      }),
      equalsDart('foo(1, bar: 2, baz: 3)'),
    );
  });
}
