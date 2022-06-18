// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  useDartfmt();

  switch (true) {
  }

  test('should create a switch', () {
    expect(
      Switch((b) => b..condition = literal(true)),
      equalsDart(r'''
        switch (true) {
        }
      '''),
    );
  });

  test('should create a switch with a case', () {
    expect(
      Switch((b) => b
        ..condition = literal(true)
        ..cases.add(SwitchCase(
          (b) => b
            ..condition = literal(false)
            ..body = refer('Exception').call([]).thrown.statement
            ..break$ = false,
        ))),
      equalsDart(r'''
        switch (true) {
          case false:
            throw Exception();
        }
      '''),
    );
  });

  test('should create a switch with a default', () {
    expect(
      Switch(
        (b) => b
          ..condition = literal(true)
          ..default$ = refer('print').call([literal('hello')]).statement,
      ),
      equalsDart(r'''
        switch (true) {
          default:
            print('hello');
        }
      '''),
    );
  });

  test('should add a break statement by default', () {
    expect(
      Switch((b) => b
        ..condition = literal(true)
        ..cases.add(SwitchCase(
          (b) => b
            ..condition = literal(false)
            ..body = refer('print').call([literal('Oh no!')]).statement,
        ))),
      equalsDart(r'''
        switch (true) {
          case false:
            print('Oh no!');
            break;
        }
      '''),
    );
  });

  test('should be able to be used within a code block', () {
    expect(
      Method(
        (b) => b
          ..returns = refer('String?')
          ..name = 'getStatus'
          ..requiredParameters.add(Parameter(
            (b) => b
              ..type = refer('int')
              ..name = 'value',
          ))
          ..body = Block.of([
            Switch(
              (b) => b
                ..condition = refer('value')
                ..cases.addAll([
                  SwitchCase(
                    (b) => b
                      ..condition = literal(200)
                      ..body = literal('OK').returned.statement
                      ..break$ = false,
                  ),
                  SwitchCase(
                    (b) => b
                      ..condition = literal(201)
                      ..body = literal('CREATED').returned.statement
                      ..break$ = false,
                  ),
                ])
                ..default$ = literal(null).returned.statement,
            ).code,
          ]),
      ),
      equalsDart(r'''
        String? getStatus(int value) {
          switch (value) {
            case 200:
              return 'OK';
            case 201:
              return 'CREATED';
            default:
              return null;
          }
        }
      '''),
    );
  });
}
