import 'package:code_builder/dart/core.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/testing/equals_source.dart';
import 'package:test/test.dart';

void main() {
  test('Literals', () {
    test('literal(null) should emit null', () {
      expect(literal(null), equalsSource('null'));
    });

    test('literal(true) should emit true', () {
      expect(literal(true), equalsSource('true'));
    });

    test('literal(false) should emit false', () {
      expect(literal(false), equalsSource('false'));
    });

    test('literal(<string>) should emit a string', () {
      expect(literal('Hello'), equalsSource("'Hello'"));
    });

    test('literal(<non primitive>) should throw', () {
      expect(() => literal(new Object()), throwsArgumentError);
    });
  });

  group('$ExpressionBuilder', () {
    test('asAssert() should emit an assert statement', () {
      expect(literal(true).asAssert(), equalsSource(r'''
        assert(true);
      '''));
    });

    test('assign should emit a setter', () {
      expect(literal(true).assign('fancy'), equalsSource(r'''
        fancy = true
      '''));
    });

    test('asConst should emit assignment to a new const variable', () {
      expect(literal(true).asConst('fancy'), equalsSource(r'''
        const fancy = true;
      '''));
    });

    test('asConst should emit assignment to a new typed const variable', () {
      expect(literal(true).asConst('fancy', typeBool), equalsSource(r'''
        const bool fancy = true;
      '''));
    });

    test('asFinal should emit assignment to a new final variable', () {
      expect(literal(true).asFinal('fancy'), equalsSource(r'''
        final fancy = true;
      '''));
    });

    test('asFinal should emit assignment to a new typed final variable', () {
      expect(literal(true).asFinal('fancy', typeBool), equalsSource(r'''
        final bool fancy = true;
      '''));
    });

    test('asVar should emit assignment to a new var', () {
      expect(literal(true).asVar('fancy'), equalsSource(r'''
        var fancy = true;
      '''));
    });

    group('asIf', () {
      test('should emit a single if-block', () {
        expect(literal(true).asIf(), equalsSource(r'''
          if (true) {}
        '''));
      });

      test('should emit an if-else block', () {
        expect(literal(true).asIf().andElse(literal(false)), equalsSource(r'''
          if (true) {

          }
          else if (false) {

          }
        '''));
      });

      test('should emit an if-else-if-else-else block', () {
        expect(
            literal(1)
                .equals(literal(2))
                .asIf()
                .andElse(literal(2).equals(literal(3)))
                .andElse(literal(3).equals(literal(4)))
                .andElse(),
            equalsSource(r'''
            if (1 == 2) {

            } else if (2 == 3) {

            } else if (3 == 4) {

            } else {

            }
          '''));
      });
    });

    test('asReturn should emit a return statement', () {
      expect(literal(true).asReturn(), equalsSource(r'''
        return true;
      '''));
    });

    test('assign should emit an asssignment expression', () {
      expect(literal(true).assign('fancy'), equalsSource(r'''
        fancy = true
      '''));
    });

    test('asStatement should emit an expression as a statement', () {
      expect(literal(true).asStatement(), equalsSource(r'''
        true;
      '''));
    });

    test('equals should compare two expressions', () {
      expect(literal(true).equals(literal(true)), equalsSource(r'''
        true == true
      '''));
    });

    test('not equals should compare two expressions', () {
      expect(literal(true).notEquals(literal(true)), equalsSource(r'''
        true != true
      '''));
    });

    test('not should negate an expression', () {
      expect(literal(true).not(), equalsSource(r'''
        !true
      '''));
    });

    test('parentheses should wrap an expression', () {
      expect(literal(true).parentheses(), equalsSource(r'''
        (true)
      '''));
    });

    test('+ should emit the sum two expressions', () {
      expect(literal(1) + literal(2), equalsSource(r'''
        1 + 2
      '''));
    });
  });
}
