// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/testing/equals_source.dart';
import 'package:test/test.dart';

void main() {
  test('should emit a blank file', () {
    expect(new FileBuilder(), equalsSource(''));
  });

  test('should emit a file with a library directive', () {
    expect(
        new FileBuilder('code_builder'), equalsSource('library code_builder;'));
  });

  test('should emit a file with a part of directive', () {
    expect(
      new FileBuilder.partOf('code_builder'),
      equalsSource('part of code_builder;'),
    );
  });

  test('should emit an import directive', () {
    expect(
      new ImportBuilder('package:foo/foo.dart'),
      equalsSource("import 'package:foo/foo.dart';"),
    );
  });

  test('should emit an import directive and a prefix', () {
    expect(
      new ImportBuilder('package:foo/foo.dart', as: 'foo'),
      equalsSource("import 'package:foo/foo.dart' as foo;"),
    );
  });

  test('should emit an export directive', () {
    expect(
      new ExportBuilder('package:foo/foo.dart'),
      equalsSource("export 'package:foo/foo.dart';"),
    );
  });
}
