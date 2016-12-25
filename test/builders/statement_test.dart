// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  group('if statements', () {
    test('should emit a simple if statement', () {
      expect(
        ifThen(literal(true), [
          lib$core.print.call([literal('Hello World')]),
        ]),
        equalsSource(r'''
        if (true) {
          print('Hello World');
        }
      '''),
      );
    });

    test('should emit an if then else statement', () {
      expect(
        ifThen(literal(true), [
          lib$core.print.call([literal('TRUE')]),
          elseThen([
            lib$core.print.call([literal('FALSE')]),
          ]),
        ]),
        equalsSource(r'''
          if (true) {
            print('TRUE');
          } else {
            print('FALSE');
          }
        '''),
      );
    });

    test('should emit an if else then statement', () {
      final a = reference('a');
      expect(
        ifThen(a.equals(literal(1)), [
          lib$core.print.call([literal('Was 1')]),
          elseIf(ifThen(a.equals(literal(2)), [
            lib$core.print.call([literal('Was 2')]),
          ])),
        ]),
        equalsSource(r'''
          if (a == 1) {
            print('Was 1');
          } else if (a == 2) {
            print('Was 2');
          }
        '''),
      );
    });

    test('should emit an if else if else statement', () {
      final a = reference('a');
      expect(
        ifThen(
          a.equals(literal(1)),
          [
            lib$core.print.call([literal('Was 1')]),
            elseIf(ifThen(a.equals(literal(2)), [
              lib$core.print.call([literal('Was 2')]),
              elseThen([
                lib$core.print.call([literal('Was ') + a]),
              ]),
            ])),
          ],
        ),
        equalsSource(r'''
          if (a == 1) {
            print('Was 1');
          } else if (a == 2) {
            print('Was 2');
          } else {
            print('Was ' + a);
          }
        '''),
      );
    });

    test('should emit a return statement', () {
      expect(
        returnVoid,
        equalsSource(r'''
          return;
        '''),
      );
    });
  });

  group('for statemnets', () {
    test('should emit a simple for-loop', () {
      expect(
        new ForStatementBuilder(
          'i',
          literal(0),
          reference('i') < reference('items').property('length'),
          [
            reference('i').increment(),
          ],
        ),
        equalsSource(r'''
          for (var i = 0; i < items.length; i++) {}
        '''),
      );
    });

    test('should emit a simple for-each loop', () {
      expect(
        new ForStatementBuilder.forEach(
          'item',
          reference('items'),
        ),
        equalsSource(r'''
          for (var item in items) {}
        '''),
      );
    });
  });

  group('while loop', () {
    test('should emit a simple while loop', () {
      expect(
        literal(true).asWhile(),
        equalsSource(r'''
          while(true) {}
        ''')
      );
    });

    test('should emit a simple do-while loop', () {
      expect(
        literal(true).asWhile(asDo: true),
        equalsSource(r'''
          do {} while (true);
        ''')
      );
    });
  });
}
