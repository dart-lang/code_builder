// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  test('should emit a top-level main() function', () {
    expect(
      method('main'),
      equalsSource(r'''
        main();
      '''),
    );
  });

  test('should emit a top-level void main() function', () {
    expect(
      method('main', [
        core.Void,
      ]),
      equalsSource(r'''
        void main();
      '''),
    );
  });

  test('should emit a function with a parameter', () {
    expect(
      method('main', [
        parameter('args', [core.List]),
      ]),
      equalsSource(r'''
        main(List args);
      '''),
    );
  });

  test('should emit a function with multiple parameters', () {
    expect(
      method('main', [
        parameter('a'),
        parameter('b'),
        parameter('c').asOptional(),
      ]),
      equalsSource(r'''
        main(a, b, [c]);
      '''),
    );
  });

  test('should emit a function with multiple parameters', () {
    expect(
      method('main', [
        parameter('a'),
        parameter('b'),
        parameter('c').asOptional(literal(true)),
      ]),
      equalsSource(r'''
        main(a, b, [c = true]);
      '''),
    );
  });

  test('should emit a function with named parameters', () {
    expect(
      method('main', [
        named(parameter('a')),
        named(parameter('b').asOptional(literal(true))),
      ]),
      equalsSource(r'''
        main({a, b : true});
      '''),
    );
  });

  group('constructors', () {
    test('should emit a simple constructor', () {
      expect(
        new ConstructorBuilder()
            .buildConstructor(
              reference('Animal'),
            )
            .toSource(),
        equalsIgnoringWhitespace(r'''
          Animal();
        '''),
      );
    });

    test('should emit a simple constructor with parameters', () {
      expect(
        (new ConstructorBuilder()..addPositional(parameter('name')))
            .buildConstructor(
              reference('Animal'),
            )
            .toSource(),
        equalsIgnoringWhitespace(r'''
          Animal(name);
        '''),
      );
    });

    test('should emit a simple constructor with field-formal parameters', () {
      expect(
        (new ConstructorBuilder()
              ..addPositional(
                parameter('name'),
                asField: true,
              ))
            .buildConstructor(
              reference('Animal'),
            )
            .toSource(),
        equalsIgnoringWhitespace(r'''
          Animal(this.name);
        '''),
      );
    });
  });
}
