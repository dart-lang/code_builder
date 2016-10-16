// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
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
          parameter('name', [core.String]),
          fieldFormal(
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
}
