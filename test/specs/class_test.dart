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

  test('should create a class with annotations', () {
    expect(
      new Class(
        (b) => b
          ..name = 'Foo'
          ..annotations.addAll([
            refer('deprecated'),
            refer('Deprecated').call([literalString('This is an old class')])
          ]),
      ),
      equalsDart(r'''
        @deprecated
        @Deprecated('This is an old class')
        class Foo {}
      '''),
    );
  });

  test('should create a class with a generic type', () {
    expect(
      new Class((b) => b
        ..name = 'List'
        ..types.add(refer('T'))),
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
            refer('K'),
            refer('V'),
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
            ..types.add(refer('T').type))))),
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

  test('should create a class with a constructor', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor())),
      equalsDart(r'''
        class Foo {
          Foo();
        }
      '''),
    );
  });

  test('should create a class with a constructor with initializers', () {
    expect(
      new Class(
        (b) => b
          ..name = 'Foo'
          ..constructors.add(
            new Constructor(
              (b) => b
                ..initializers.addAll([
                  const Code('a = 5'),
                  const Code('super()'),
                ]),
            ),
          ),
      ),
      equalsDart(r'''
        class Foo {
          Foo() : a = 5, super();
        }
      '''),
    );
  });

  test('should create a class with an annotated constructor [deprecated]', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor((b) => b
          ..annotations.add(
            new Annotation((b) => b..code = const Code('deprecated')),
          )))),
      equalsDart(r'''
        class Foo {
          @deprecated
          Foo();
        }
      '''),
    );
  });

  test('should create a class with a annotated constructor', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(
            new Constructor((b) => b..annotations.add(refer('deprecated'))))),
      equalsDart(r'''
        class Foo {
          @deprecated
          Foo();
        }
      '''),
    );
  });

  test('should create a class with a named constructor', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor((b) => b..name = 'named'))),
      equalsDart(r'''
        class Foo {
          Foo.named();
        }
      '''),
    );
  });

  test('should create a class with a const constructor', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor((b) => b..constant = true))),
      equalsDart(r'''
        class Foo {
          const Foo();
        }
      '''),
    );
  });

  test('should create a class with an external constructor', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor((b) => b..external = true))),
      equalsDart(r'''
        class Foo {
          external Foo();
        }
      '''),
    );
  });

  test('should create a class with a factory constructor', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor((b) => b
          ..factory = true
          ..redirect = refer('_Foo')))),
      equalsDart(r'''
        class Foo {
          factory Foo() = _Foo;
        }
      '''),
    );
  });

  test('should create a class with a factory lambda constructor', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor((b) => b
          ..factory = true
          ..lambda = true
          ..body = const Code('new _Foo()')))),
      equalsDart(r'''
        class Foo {
          factory Foo() => new _Foo();
        }
      '''),
    );
  });

  test('should create a class with a constructor with a body', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor((b) => b
          ..factory = true
          ..body = const Code('return new _Foo();')))),
      equalsDart(r'''
        class Foo {
          factory Foo() {
            return new _Foo();
          }
        }
      '''),
    );
  });

  test('should create a class with method parameters', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor((b) => b
          ..requiredParameters.addAll([
            new Parameter((b) => b..name = 'a'),
            new Parameter((b) => b..name = 'b'),
          ])
          ..optionalParameters.addAll([
            new Parameter((b) => b
              ..name = 'c'
              ..named = true),
          ])))),
      equalsDart(r'''
        class Foo {
          Foo(a, b, {c});
        }
      '''),
    );
  });

  test('should create a class with a constructor+field-formal parameters', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..constructors.add(new Constructor((b) => b
          ..requiredParameters.addAll([
            new Parameter((b) => b
              ..name = 'a'
              ..toThis = true),
            new Parameter((b) => b
              ..name = 'b'
              ..toThis = true),
          ])
          ..optionalParameters.addAll([
            new Parameter((b) => b
              ..name = 'c'
              ..named = true
              ..toThis = true),
          ])))),
      equalsDart(r'''
        class Foo {
          Foo(this.a, this.b, {this.c});
        }
      '''),
    );
  });
}
