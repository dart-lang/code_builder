// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  group('$ImportBuilder', () {
    test('should support "show"', () {
      expect(
        new ImportBuilder('package:foo/foo.dart')..show('Foo'),
        equalsSource(r'''
          import 'package:foo/foo.dart' show Foo;
        '''),
      );
    });

    test('should support "show"', () {
      expect(
        new ImportBuilder('package:foo/foo.dart')..hide('Bar'),
        equalsSource(r'''
          import 'package:foo/foo.dart' hide Bar;
        '''),
      );
    });

    test('should support "deferred as"', () {
      expect(
        new ImportBuilder(
          'package:foo/foo.dart',
          deferred: true,
          prefix: 'foo',
        ),
        equalsSource(r'''
          import 'package:foo/foo.dart' deferred as foo;
        '''),
      );
    });
  });

  group('$ExportBuilder', () {
    test('should support "show"', () {
      expect(
        new ExportBuilder('package:foo/foo.dart')..show('Foo'),
        equalsSource(r'''
          export 'package:foo/foo.dart' show Foo;
        '''),
      );
    });

    test('should support "show"', () {
      expect(
        new ExportBuilder('package:foo/foo.dart')..hide('Bar'),
        equalsSource(r'''
          export 'package:foo/foo.dart' hide Bar;
        '''),
      );
    });

    group('$LibraryBuilder', () {
      test('should handle empty methods', () {
        expect(
          new LibraryBuilder()..addMember(new MethodBuilder.returnVoid('main')),
          equalsSource('void main() {}'),
        );
      });

      test('should support metadata', () {
        expect(
          new LibraryBuilder('some_lib')..addAnnotation(reference('ignore')),
          equalsSource(r'''
            @ignore
            library some_lib;
          '''),
        );
      });
    });

    group('$PartBuilder', () {
      test('should emit a part directive', () {
        expect(
          new LibraryBuilder()..addDirective(new PartBuilder('part.dart')),
          equalsSource(r'''
            part 'part.dart';
          '''),
        );
      });
    });

    group('$PartOfBuilder', () {
      test('should emit a part-of file', () {
        expect(
          new PartOfBuilder('main.dart'),
          equalsSource(r'''
            part of 'main.dart';
          '''),
        );
      });
    });
  });
}
