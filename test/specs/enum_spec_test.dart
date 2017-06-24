// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should build an enum', () {
    expect(
      specToDart(
        enumBuilder('Foo').build(),
      ),
      equalsIgnoringWhitespace(r'''
        enum Foo {}
      '''),
    );
  });

  test('should build an enum with dartdoc', () {
    expect(
      specToDart(
        (enumBuilder('Foo')..addDartDoc('/// My favorite enum.')).build(),
      ),
      equalsIgnoringWhitespace(r'''
        /// My favorite enum.
        enum Foo {}
      '''),
    );
  });
}
