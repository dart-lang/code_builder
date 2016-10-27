// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  test('should emit a simple parameter', () {
    expect(
      parameter('foo'),
      equalsSource(r'''
        foo
      '''),
    );
  });

  test('should emit a typed parameter', () {
    expect(
      parameter('foo', [reference('String')]),
      equalsSource(r'''
        String foo
      '''),
    );
  });

  test('should emit an optional parameter with a default value', () {
    expect(
      parameter('foo').asOptional(literal(true)),
      equalsSource(r'''
        foo = true
      '''),
    );
  });

  test('should emit a named parameter with a default value', () {
    expect(
      parameter('foo').asOptional(literal(true)).buildNamed(false).toSource(),
      equalsIgnoringCase(r'foo : true'),
    );
  });

  test('should emit a field formal parameter', () {
    expect(
      parameter('foo').buildPositional(true).toSource(),
      equalsIgnoringCase(r'this.foo'),
    );
  });
}
