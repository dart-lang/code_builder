import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  group('if statements', () {
    test('should emit a simple if statement', () {
      expect(
        ifThen(literal(true), [
          core.print.call([literal('Hello World')]),
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
          core.print.call([literal('TRUE')]),
          elseThen([
            core.print.call([literal('FALSE')]),
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
          core.print.call([literal('Was 1')]),
          elseIf(ifThen(a.equals(literal(2)), [
            core.print.call([literal('Was 2')]),
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
            core.print.call([literal('Was 1')]),
            elseIf(ifThen(a.equals(literal(2)), [
              core.print.call([literal('Was 2')]),
              elseThen([
                core.print.call([literal('Was ') + a]),
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
  });
}
