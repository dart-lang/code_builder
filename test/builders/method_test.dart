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
        main() {}
      '''),
    );
  });

  test('should emit a top-level void main() function', () {
    expect(
      method('main', [
        lib$core.$void,
      ]).buildMethod(false).toSource(),
      equalsIgnoringWhitespace(r'''
        void main() {}
      '''),
    );
  });

  test('should emit a function with a parameter', () {
    expect(
      method('main', [
        parameter('args', [lib$core.List]),
      ]).buildMethod(false).toSource(),
      equalsIgnoringWhitespace(r'''
        main(List args) {}
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
        main(a, b, [c]) {}
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
        main(a, b, [c = true]) {}
      '''),
    );
  });

  test('should emit a function with named parameters', () {
    expect(
      method('main', [
        named(parameter('a')),
        named(parameter('b').asOptional(literal(true))),
      ]).buildMethod(false).toSource(),
      equalsIgnoringWhitespace(r'''
        main({a, b : true}) {}
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

    test('should a method with a lambda value', () {
      expect(
        lambda('supported', literal(true), returnType: lib$core.bool),
        equalsSource(r'''
          bool supported() => true;
        '''),
      );
    });
  });

  test('should emit a getter with a lambda value', () {
    expect(
      getter('unsupported', returns: literal(true)),
      equalsSource(r'''
        get unsupported => true;
      '''),
    );
  });

  test('should emit a getter with statements', () {
    expect(
      getter(
        'values',
        returnType: lib$core.Iterable,
        statements: [
          literal([]).asReturn(),
        ],
      ),
      equalsSource(r'''
        Iterable get values {
          return [];
        }
      '''),
    );
  });

  test('should emit a setter', () {
    expect(
      setter('name', parameter('name', [lib$core.String]), [
        (reference('name') + literal('!')).asAssign('_name'),
      ]),
      equalsSource(r'''
        set name(String name) {
          _name = name + '!';
        }
      '''),
    );
  });

  group('closure', () {
    MethodBuilder closure;
    setUp(() {
      closure = new MethodBuilder.closure(
        returns: literal(false).or(reference('defaultTo')),
        returnType: lib$core.bool,
      )..addPositional(parameter('defaultTo', [lib$core.bool]));
    });

    test('should emit a closure', () {
      // Should be usable as an expression/parameter itself.
      expect(closure, const isInstanceOf<ExpressionBuilder>());
      expect(
        closure,
        equalsSource(r'''
        (bool defaultTo) => false || defaultTo
      '''),
      );

      test('should treat closure as expression', () {
        expect(
            list([true, false]).invoke('where', [closure]),
            equalsSource(
                '[true, false].where((bool defaultTo) => false || defaultTo)'));
      });

      test('should emit a closure as a function in a library', () {
        final library = new LibraryBuilder();
        library.addMember(closure);
        expect(
            library, equalsSource('(bool defaultTo) => false || defaultTo;'));
      });
    });
  });
}
