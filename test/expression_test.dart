import 'package:code_builder/dart/core.dart';
import 'package:code_builder/src/builders/expression/expression.dart';
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
  });
}
