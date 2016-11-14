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
  });
}
