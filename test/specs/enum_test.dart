// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  useDartfmt();

  test('should create an enum', () {
    expect(
        Enum((b) => b
          ..name = 'E'
          ..values.addAll([
            EnumValue((b) => b..name = 'A'),
            EnumValue((b) => b..name = 'B'),
          ])),
        equalsDart(r'''
      enum E {
        A,
        B
      }
    '''));
  });

  test('should create an enum with annotations', () {
    expect(
        Enum((b) => b
          ..annotations.addAll([
            refer('deprecated'),
            refer('Deprecated').call([literalString('This is an old enum')])
          ])
          ..name = 'V'
          ..values.addAll([
            EnumValue((b) => b..name = 'X'),
          ])),
        equalsDart(r'''
      @deprecated
      @Deprecated('This is an old enum')
      enum V {
        X
      }
    '''));
  });

  test('should create an enum with annotated values', () {
    expect(
        Enum((b) => b
          ..name = 'Status'
          ..values.addAll([
            EnumValue((b) => b
              ..name = 'Okay'
              ..annotations.addAll([
                refer('deprecated'),
                refer('Deprecated').call([literalString('use Good insted')]),
              ])),
            EnumValue((b) => b
              ..name = 'Good'
              ..annotations.addAll([
                refer('JsonKey').call([literalString('good')])
              ])),
          ])),
        equalsDart(r'''
      enum Status {
        @deprecated
        @Deprecated('use Good insted')
        Okay,
        @JsonKey('good')
        Good
      }
    '''));
  });
}
