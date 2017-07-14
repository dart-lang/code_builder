// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Allocator', () {
    Allocator allocator;

    test('should return the exact (non-prefixed) symbol', () {
      allocator = new Allocator();
      expect(allocator.allocate(const Reference('Foo', 'package:foo')), 'Foo');
    });

    test('should collect import URLs', () {
      allocator = new Allocator()
        ..allocate(const Reference('List', 'dart:core'))
        ..allocate(const Reference('LinkedHashMap', 'dart:collection'))
        ..allocate(const Reference('someSymbol'));
      expect(allocator.imports.map((d) => d.url), [
        'dart:core',
        'dart:collection',
      ]);
    });

    test('.none should do nothing', () {
      allocator = Allocator.none;
      expect(allocator.allocate(const Reference('Foo', 'package:foo')), 'Foo');
      expect(allocator.imports, isEmpty);
    });

    test('.simplePrefixing should add import prefixes', () {
      allocator = new Allocator.simplePrefixing();
      expect(
        allocator.allocate(const Reference('List', 'dart:core')),
        'List',
      );
      expect(
        allocator.allocate(const Reference('LinkedHashMap', 'dart:collection')),
        '_1.LinkedHashMap',
      );
      expect(allocator.imports.map((d) => '${d.url} as ${d.as}'), [
        'dart:collection as _1',
      ]);
    });
  });
}
