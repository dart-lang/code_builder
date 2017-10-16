// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should emit a block of code', () {
    expect(
      new Block((b) => b.statements.addAll([
            const Code('if (foo) {'),
            const Code('  print(true);'),
            const Code('}'),
          ])),
      equalsDart(r'''
        if (foo) {
          print(true);
        }
      '''),
    );
  });

  test('should emit a block of code including expressions', () {
    expect(
      new Block((b) => b.statements.addAll([
            const Code('if (foo) {'),
            refer('print')([literalTrue]).statement,
            const Code('}'),
          ])),
      equalsDart(r'''
        if (foo) {
          print(true);
        }
      '''),
    );
  });
}
