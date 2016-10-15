import 'package:code_builder/code_builder.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  test('should emit a simple untyped parameter', () {
    expect(
      parameter('foo'),
      equalsSource('foo'),
    );
  });

  test('should emit a simple typed parameter', () {
    expect(
      parameter('foo', [type('String')]),
      equalsSource('String foo'),
    );
  });

  test('should emit a field-formal parameter', () {
    expect(
      parameter('foo').toField(),
      equalsSource('this.foo'),
    );
  });

  test('should emit a parameter with a default value', () {
    expect(
      parameter('foo', [literal(true)]),
      equalsSource('foo = true'),
    );
  });

  test('shuld emit a field-formal parameter with a default value', () {
    expect(
      parameter('foo', [literal(true)]).toField(),
      equalsSource('this.foo = true'),
    );
  });
}
