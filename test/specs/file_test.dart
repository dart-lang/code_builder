// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  group('File', () {
    const $linkedHashMap = const Reference('LinkedHashMap', 'dart:collection');
    test('should emit a source file', () {
      expect(
        new File((b) => b
          ..directives.add(new Directive.import('dart:collection'))
          ..body.add(new Field((b) => b
            ..name = 'test'
            ..modifier = FieldModifier.final$
            ..assignment = new Code((b) => b
              ..code = 'new {{LinkedHashMap}}()'
              ..specs.addAll({'LinkedHashMap': () => $linkedHashMap}))))),
        equalsDart(r'''
          import 'dart:collection';
          
          final test = new LinkedHashMap();
        '''),
      );
    });
  });
}
