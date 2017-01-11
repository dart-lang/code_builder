// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  test('TypeBuilder emits a generic type reference', () {
    expect(
      new TypeBuilder('List', genericTypes: [reference('String')]),
      equalsSource(r'''
        List<String>
      '''),
    );
  });

  test('ReferenceBuilder.toTyped emits a generic type reference', () {
    expect(
      lib$core.Map.toTyped([
        lib$core.String,
        lib$core.List.toTyped([
          lib$core.int,
        ]),
      ]),
      equalsSource(r'''
        Map<String, List<int>>
      '''),
    );
  });

  group('new instance', () {
    test('emits a new List', () {
      expect(
        lib$core.List.newInstance([]),
        equalsSource(r'''
          new List()
        '''),
      );
    });

    test('emits a new List.from', () {
      expect(
        lib$core.List.namedNewInstance('from', [
          literal([1, 2, 3]),
        ]),
        equalsSource(r'''
          new List.from([1, 2, 3])
        '''),
      );
    });

    test('emits a new const Point', () {
      expect(
        reference('Point').constInstance([
          literal(1),
          literal(2),
        ]),
        equalsSource(r'''
          const Point(1, 2)
        '''),
      );
    });

    test('emits a const constructor as an annotation', () {
      expect(
        clazz('Animal', [
          lib$core.Deprecated
              .constInstance([literal('Animals are out of style')]),
        ]),
        equalsSource(r'''
          @Deprecated('Animals are out of style')
          class Animal {}
        '''),
      );
    });

    test('emits a named const constructor as an annotation', () {
      expect(
        clazz('Animal', [
          reference('Component').namedConstInstance(
            'stateful',
            [],
            {
              'selector': literal('animal'),
            },
          ),
        ]),
        equalsSource(r'''
          @Component.stateful(selector: 'animal')
          class Animal {}
        '''),
      );
    });

    test('emits an export builder', () {
      expect(
        reference('Foo', 'package:foo/foo.dart').toExportBuilder(),
        equalsSource(r'''
          export 'package:foo/foo.dart' show Foo;
        '''),
      );
    });

    test('emits an export builder', () {
      expect(
        reference('Foo', 'package:foo/foo.dart').toImportBuilder(),
        equalsSource(r'''
          import 'package:foo/foo.dart' show Foo;
        '''),
      );
    });
  });

  test('emits as a Type to be used as an expression', () {
    expect(
      lambda('foo', new TypeBuilder('Foo')),
      equalsSource(r'''
        foo() => Foo;
      '''),
    );
  });

  test('throws when a Type references generics for an expression', () {
    expect(
      () => new TypeBuilder('Foo', genericTypes: [
            new TypeBuilder('Bar'),
          ]).buildExpression(),
      throwsStateError,
    );
  });
}
