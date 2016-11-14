// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/scope.dart';
import 'package:test/test.dart';

void main() {
  Scope scope;

  tearDown(() => scope = null);

  test('Identity scope should do nothing', () {
    scope = Scope.identity;

    var identifiers = <Identifier>[
      scope.identifier('Foo', 'package:foo/foo.dart'),
      scope.identifier('Bar', 'package:foo/foo.dart'),
      scope.identifier('Baz', 'package:baz/baz.dart'),
    ].map((i) => i.toSource());

    expect(
      identifiers,
      [
        'Foo',
        'Bar',
        'Baz',
      ],
    );

    expect(scope.toImports(), isEmpty);
  });

  test('Deduplicating scope should deduplicate imports', () {
    scope = new Scope.dedupe();

    var identifiers = <Identifier>[
      scope.identifier('Foo', 'package:foo/foo.dart'),
      scope.identifier('Bar', 'package:foo/foo.dart'),
      scope.identifier('Baz', 'package:baz/baz.dart'),
    ].map((i) => i.toSource());

    expect(
      identifiers,
      [
        'Foo',
        'Bar',
        'Baz',
      ],
    );

    expect(
      scope.toImports().map((i) => i.buildAst().toSource()),
      [
        r"import 'package:foo/foo.dart';",
        r"import 'package:baz/baz.dart';",
      ],
    );
  });

  test('Default scope should auto-prefix', () {
    scope = new Scope();

    var identifiers = <Identifier>[
      scope.identifier('Foo', 'package:foo/foo.dart'),
      scope.identifier('Bar', 'package:foo/foo.dart'),
      scope.identifier('Baz', 'package:baz/baz.dart'),
    ].map((i) => i.toSource());

    expect(
      identifiers,
      [
        '_i1.Foo',
        '_i1.Bar',
        '_i2.Baz',
      ],
    );

    expect(
      scope.toImports().map((i) => i.buildAst().toSource()),
      [
        r"import 'package:foo/foo.dart' as _i1;",
        r"import 'package:baz/baz.dart' as _i2;",
      ],
    );
  });
}
