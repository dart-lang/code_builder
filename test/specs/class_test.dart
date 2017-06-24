// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should create a class', () {
    expect(
      new Class((b) => b..name = 'Foo'),
      equalsDart(r'''
        class Foo {}
      '''),
    );
  });

  test('should create an abstract class', () {
    expect(
      new Class((b) => b
        ..name = 'Foo'
        ..abstract = true),
      equalsDart(r'''
        abstract class Foo {}
      '''),
    );
  });

  test('should create a class with documentations', () {
    expect(
      new Class(
        (b) => b
          ..name = 'Foo'
          ..docs.addAll(
            const [
              '/// My favorite class.',
            ],
          ),
      ),
      equalsDart(r'''
        /// My favorite class.
        class Foo {}
      '''),
    );
  });
}
