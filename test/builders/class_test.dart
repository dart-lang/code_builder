// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/src/builders/method.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  test('should emit an empty class', () {
    expect(
      clazz('Animal'),
      equalsSource(r'''
        class Animal {}
      '''),
    );
  });

  test('should emit an abstract class', () {
    expect(
      new ClassBuilder('Animal', asAbstract: true)
        ..addMethod(new MethodBuilder.returnVoid(
          'eat',
          asAbstract: true,
        )),
      equalsSource(r'''
        abstract class Animal {
          void eat();
        }
      '''),
    );
  });

  test('should emit a class with an annotation', () {
    expect(
      clazz('Animal', [reference('deprecated')]),
      equalsSource(r'''
        @deprecated
        class Animal {}
      '''),
    );
  });

  test('should emit a class that extends another', () {
    expect(
      clazz('Animal', [extend(reference('Life'))]),
      equalsSource(r'''
        class Animal extends Life {}
      '''),
    );
  });

  test('should emit a class that implements another', () {
    expect(
      clazz('Animal', [implement(reference('Living'))]),
      equalsSource(r'''
        class Animal implements Living {}
      '''),
    );
  });

  test('should emit a class that mixes in another', () {
    expect(
      clazz('Animal', [mixin(reference('Living'))]),
      equalsSource(r'''
        class Animal extends Object with Living {}
      '''),
    );
  });

  test('should emit a class with a constructor', () {
    expect(
      clazz('Animal', [
        constructor(),
      ]),
      equalsSource(r'''
        class Animal {
          Animal();
        }
      '''),
    );
  });

  test('should emit a class with a named constructor', () {
    expect(
      clazz('Animal', [
        constructorNamed('internal'),
      ]),
      equalsSource(r'''
        class Animal {
          Animal.internal();
        }
      '''),
    );
  });

  test('should emit a class with a constructor with parameters', () {
    expect(
      clazz('Animal', [
        constructor([
          parameter('name', [lib$core.String]),
          thisField(
            named(
              parameter('age').asOptional(literal(0)),
            ),
          )
        ])
      ]),
      equalsSource(r'''
        class Animal {
          Animal(String name, {this.age: 0});
        }
      '''),
    );
  });

  test('should emit a class with a constructor with initializers', () {
    expect(
      clazz('Animal', [
        new ConstructorBuilder(
          invokeSuper: const [],
        )..addInitializer('name', toParameter: 'other'),
      ]),
      equalsSource(r'''
        class Animal {
          Animal() : name = other, super();
        }
      '''),
    );
  });

  test('should emit a class with fields', () {
    expect(
      clazz('Animal', [
        asStatic(
          varField('static1', type: lib$core.String, value: literal('Hello')),
        ),
        asStatic(
          varFinal('static2', type: lib$core.List, value: literal([])),
        ),
        asStatic(
          varConst('static3', type: lib$core.bool, value: literal(true)),
        ),
        varField('var1', type: lib$core.String, value: literal('Hello')),
        varFinal('var2', type: lib$core.List, value: literal([])),
        varConst('var3', type: lib$core.bool, value: literal(true)),
      ]),
      equalsSource(r'''
        class Animal {
          static String static1 = 'Hello';
          static final List static2 = [];
          static const bool static3 = true;
          String var1 = 'Hello';
          final List var2 = [];
          const bool var3 = true;
        }
      '''),
    );
  });

  test('should emit a class with methods', () {
    expect(
      clazz('Animal', [
        asStatic(method('staticMethod', <ValidMethodMember>[
          lib$core.$void,
          lib$core.print.call([literal('Called staticMethod')]),
        ])),
        method('instanceMethod', <ValidMethodMember>[
          lib$core.$void,
          lib$core.print.call([literal('Called instanceMethod')]),
        ]),
        constructor([
          lib$core.print.call([literal('Called constructor')]),
        ]),
      ]),
      equalsSource(r'''
        class Animal {
          Animal() {
            print('Called constructor');
          }
          static void staticMethod() {
            print('Called staticMethod');
          }
          void instanceMethod() {
            print('Called instanceMethod');
          }
        }
      '''),
    );
  });
}
