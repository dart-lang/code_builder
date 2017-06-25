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

  test('should create a getter', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..external = true
        ..type = MethodType.getter),
      equalsDart(r'''
        external get foo;
      '''),
    );
  });

  test('should create a setter', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..external = true
        ..requiredParameters.add((new Parameter((b) => b..name = 'foo')))
        ..type = MethodType.setter),
      equalsDart(r'''
        external set foo(foo);
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

  test('should create a lambda method', () {
    expect(
      new Method(
        (b) => b
          ..name = 'foo'
          ..lambda = true
          ..body = new Code(
            (b) => b.code = r'''
              1 + 2
            ''',
          ),
      ),
      equalsDart(r'''
        foo() => 1 + 2;
      '''),
    );
  });

  test('should create a method with a body with references', () {
    final linkedHashMap = const Reference('LinkedHashMap', 'dart:collection');
    expect(
      new Method(
        (b) => b
          ..name = 'foo'
          ..body = new Code(
            (b) => b
              // Just an example to make it clear this != an actual type.
              //
              // Can be used to do automatic import prefixing or rewrites.
              ..references['LINKED_HASH_MAP'] = linkedHashMap
              ..code = r'''
                return new {{LINKED_HASH_MAP}}();
              ''',
          ),
      ),
      equalsDart(r'''
        foo() {
          return new LinkedHashMap();
        }
      '''),
    );
  });

  test('should create a method with a paremter', () {
    expect(
      new Method(
        (b) => b
          ..name = 'fib'
          ..requiredParameters.add(
            new Parameter((b) => b.name = 'i'),
          ),
      ),
      equalsDart(r'''
        fib(i);
      '''),
    );
  });

  test('should create a method with a parameter with a type', () {
    expect(
      new Method(
        (b) => b
          ..name = 'fib'
          ..requiredParameters.add(
            new Parameter(
              (b) => b
                ..name = 'i'
                ..type = const Reference.localScope('int').toType(),
            ),
          ),
      ),
      equalsDart(r'''
        fib(int i);
      '''),
    );
  });

  test('should create a method with a parameter with a generic type', () {
    expect(
      new Method(
        (b) => b
          ..name = 'foo'
          ..types.add(new TypeReference((b) => b
            ..symbol = 'T'
            ..bound = const Reference.localScope('Iterable').toType()))
          ..requiredParameters.addAll([
            new Parameter(
              (b) => b
                ..name = 't'
                ..type = const Reference.localScope('T').toType(),
            ),
            new Parameter((b) => b
              ..name = 'x'
              ..type = new TypeReference((b) => b
                ..symbol = 'X'
                ..types.add(const Reference.localScope('T').toType()))),
          ]),
      ),
      equalsDart(r'''
        foo<T extends Iterable>(T t, X<T> x);
      '''),
    );
  });

  test('should create a method with an optional parameter', () {
    expect(
      new Method(
        (b) => b
          ..name = 'fib'
          ..optionalParameters.add(
            new Parameter((b) => b.name = 'i'),
          ),
      ),
      equalsDart(r'''
        fib([i]);
      '''),
    );
  });

  test('should create a method with multiple optional parameters', () {
    expect(
      new Method(
        (b) => b
          ..name = 'foo'
          ..optionalParameters.addAll([
            new Parameter((b) => b.name = 'a'),
            new Parameter((b) => b.name = 'b'),
          ]),
      ),
      equalsDart(r'''
        foo([a, b]);
      '''),
    );
  });

  test('should create a method with an optional parameter with a value', () {
    expect(
      new Method(
        (b) => b
          ..name = 'fib'
          ..optionalParameters.add(
            new Parameter((b) => b
              ..name = 'i'
              ..defaultTo = new Code((b) => b.code = '0')),
          ),
      ),
      equalsDart(r'''
        fib([i = 0]);
      '''),
    );
  });

  test('should create a method with a named optional parameter', () {
    expect(
      new Method(
        (b) => b
          ..name = 'fib'
          ..optionalParameters.add(
            new Parameter((b) => b
              ..named = true
              ..name = 'i'),
          ),
      ),
      equalsDart(r'''
        fib({i});
      '''),
    );
  });

  test('should create a method with a named optional parameter with value', () {
    expect(
      new Method(
        (b) => b
          ..name = 'fib'
          ..optionalParameters.add(
            new Parameter((b) => b
              ..named = true
              ..name = 'i'
              ..defaultTo = new Code((b) => b.code = '0')),
          ),
      ),
      equalsDart(r'''
        fib({i: 0});
      '''),
    );
  });

  test('should create a method with a mix of parameters', () {
    expect(
      new Method(
        (b) => b
          ..name = 'foo'
          ..requiredParameters.add(
            new Parameter((b) => b..name = 'a'),
          )
          ..optionalParameters.add(
            new Parameter((b) => b
              ..named = true
              ..name = 'b'),
          ),
      ),
      equalsDart(r'''
        foo(a, {b});
      '''),
    );
  });
}
