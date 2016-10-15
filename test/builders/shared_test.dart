import 'package:code_builder/src/builders/shared.dart';
import 'package:test/test.dart';

void main() {
  test('stringIdentifier should return a string identifier', () {
    expect(stringIdentifier('Coffee').toSource(), 'Coffee');
  });

  test('stringToken should return a string token', () {
    expect(stringToken('Coffee').value().toString(), 'Coffee');
  });

  test('Scope.identity should return an unprefixed identifier', () {
    expect(Scope.identity.getIdentifier('Coffee').toSource(), 'Coffee');
  });
}
