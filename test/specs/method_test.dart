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

  test('should create an async method', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..modifier = MethodModifier.async
        ..lambda = true
        ..body = const Code('null')),
      equalsDart(r'''
        foo() async => null; 
      '''),
    );
  });

  test('should create an async* method', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..modifier = MethodModifier.asyncStar
        ..lambda = true
        ..body = const Code('null')),
      equalsDart(r'''
        foo() async* => null; 
      '''),
    );
  });

  test('should create an sync* method', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..modifier = MethodModifier.syncStar
        ..lambda = true
        ..body = const Code('null')),
      equalsDart(r'''
        foo() sync* => null; 
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
        ..returns = const Reference('String')),
      equalsDart(r'''
        String foo();
      '''),
    );
  });

  test('should create a method with a void return type', () {
    expect(
      new Method.returnsVoid((b) => b..name = 'foo'),
      equalsDart(r'''
        void foo();
      '''),
    );
  });

  test('should create a method with generic types', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..types.add(const Reference('T'))),
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
        ..body = const Code('return 1+ 2;')),
      equalsDart(r'''
        foo() {
          return 1 + 2;
        }
      '''),
    );
  });

  test('should create a lambda method', () {
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..lambda = true
        ..body = const Code('1 + 2')),
      equalsDart(r'''
        foo() => 1 + 2;
      '''),
    );
  });

  test('should create a method with a body with references', () {
    final linkedHashMap = const Reference('LinkedHashMap', 'dart:collection');
    expect(
      new Method((b) => b
        ..name = 'foo'
        ..body = new Code.scope(
          (a) => 'return new ${a(linkedHashMap)}();',
        )),
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

  test('should create a method with a paremter with an annotation', () {
    expect(
      new Method(
        (b) => b
          ..name = 'fib'
          ..requiredParameters.add(
            new Parameter((b) => b
              ..name = 'i'
              ..annotations.add(
                  new Annotation((a) => a..code = const Code('deprecated')))),
          ),
      ),
      equalsDart(r'''
        fib(@deprecated i);
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
                ..type = const Reference('int').toType(),
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
            ..bound = const Reference('Iterable')))
          ..requiredParameters.addAll([
            new Parameter(
              (b) => b
                ..name = 't'
                ..type = const Reference('T'),
            ),
            new Parameter((b) => b
              ..name = 'x'
              ..type = new TypeReference((b) => b
                ..symbol = 'X'
                ..types.add(const Reference('T')))),
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
              ..defaultTo = const Code('0')),
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
              ..defaultTo = const Code('0')),
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
