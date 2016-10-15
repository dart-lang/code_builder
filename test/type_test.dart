import 'package:code_builder/code_builder.dart';
import 'package:code_builder/testing/equals_source.dart';
import 'package:test/test.dart';

void main() {
  test('should emit a type', () {
    expect(reference('List'), equalsSource(r'List'));
  });

  test('should emit a type with a generic type parameter', () {
    expect(
      reference('List').generic([reference('String')]),
      equalsSource(r'''
        List<String>
      '''),
    );
  });

  test('should emit a type with prefixed generic types', () {
    expect(
      reference('SuperList', 'package:super/list.dart').generic([
        reference('Super', 'package:super/super.dart'),
      ]),
      equalsSource(
          r'''
        list.SuperList<super.Super>
      ''',
          scope: simpleNameScope),
    );
  });
}
