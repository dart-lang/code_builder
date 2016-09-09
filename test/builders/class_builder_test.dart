// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing/equals_source.dart';
import 'package:test/test.dart';

void main() {
  test('should emit an empty class', () {
    expect(new ClassBuilder('Animal'), equalsSource('class Animal {}'));
  });

  test('should emit an abstract class', () {
    expect(
      new ClassBuilder('Animal', abstract: true),
      equalsSource('abstract class Animal {}'),
    );
  });

  test('should emit a class extending another class', () {
    expect(
      new ClassBuilder('Animal', extend: 'Organism'),
      equalsSource('class Animal extends Organism {}'),
    );
  });

  test('should emit a class implementing another class', () {
    expect(
      new ClassBuilder('Animal', implement: ['Delicious']),
      equalsSource('class Animal implements Delicious {}'),
    );
  });

  test('should emit a class extending and mixing in another class', () {
    expect(
      new ClassBuilder('Animal', extend: 'Organism', mixin: ['Breathing']),
      equalsSource('class Animal extends Organism with Breathing {}'),
    );
  });

  test('should emit a class with a method', () {
    expect(
      new ClassBuilder('Animal')
        ..addMethod(new MethodBuilder(
          name: 'toString',
          returns: typeString,
        )..setExpression(const LiteralString('Delicious'))),
      equalsSource(r'''
      class Animal {
        String toString() => 'Delicious';
      }
      '''),
    );
  });

  test('should emit an abstract class with an abstract method', () {
    expect(
      new ClassBuilder('Animal', abstract: true)
        ..addMethod(
          new MethodBuilder.returnVoid('eat'),
        ),
      equalsSource(r'''
      abstract class Animal {
        void eat();
      }
      '''),
    );
  });

  test('should emit a class with a static method', () {
    expect(
      new ClassBuilder('Animal')
        ..addMethod(
          new MethodBuilder(
            name: 'create',
            returns: new TypeBuilder('Animal'),
          )..setExpression(literalNull),
          static: true,
        ),
      equalsSource(r'''
      class Animal {
        static Animal create() => null;
      }
      '''),
    );
  });

  test('should emit a class with a metadata annotation', () {
    expect(
      new ClassBuilder('Animal')..addAnnotation(atDeprecated()),
      equalsSource(r'''
      @deprecated
      class Animal {}
      '''),
    );
  });

  test('should emit a class with an invoking metadata annotation', () {
    expect(
      new ClassBuilder('Animal')
        ..addAnnotation(atDeprecated('We ate them all')),
      equalsSource(r'''
      @Deprecated('We ate them all')
      class Animal {}
      '''),
    );
  });

  group('constructors', () {
    ClassBuilder clazz;

    setUp(() {
      clazz = new ClassBuilder('Animal');
    });

    test('default constructor', () {
      clazz.addConstructor(new ConstructorBuilder.initializeFields());
      expect(
          clazz,
          equalsSource(
            r'''
        class Animal {
          Animal();
        }
        ''',
          ));
    });

    test('default const constructor', () {
      clazz.addConstructor(
          new ConstructorBuilder.initializeFields(constant: true));
      expect(
          clazz,
          equalsSource(
            r'''
        class Animal {
          const Animal();
        }
        ''',
          ));
    });

    test('initializing fields', () {
      clazz.addConstructor(new ConstructorBuilder.initializeFields(
        positionalArguments: ['a'],
        optionalArguments: ['b'],
      ));
      expect(
          clazz,
          equalsSource(
            r'''
        class Animal {
          Animal(this.a, [this.b]);
        }
        ''',
          ));
    });
  });
}
