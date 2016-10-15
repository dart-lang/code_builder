import 'package:code_builder/code_builder.dart';
import 'package:code_builder/testing/equals_source.dart';
import 'package:test/test.dart';

void main() {
  group('reference', () {
    test('should emit an identifier', () {
      expect(reference('fooBar'), equalsSource(r'fooBar'));
    });

    test('should emit an expression when used as one', () {
      expect(reference('a').equals(reference('b')), equalsSource(r'''
        a == b
      '''));
    });

    test('should emit a scoped identifier', () {
      expect(
        reference('fooBar', 'package:foo_bar/foo_bar.dart'),
        equalsSource(
            r'''
          foo_bar.fooBar
        ''',
            scope: simpleNameScope),
      );
    });

    test('should emit a method invocation on the reference', () {
      expect(
        reference('print').call(),
        equalsSource(r'''
          print()
        '''),
      );
    });

    test('should emit a method invocation on a method of the refernece', () {
      expect(
        reference('foo').invoke('bar'),
        equalsSource(r'''
          foo.bar()
        '''),
      );
    });

    test('should emit a method invocation with named args', () {
      expect(
        reference('foo').callWith(named: {'bar': literal(true)}),
        equalsSource(r'''
          foo(bar: true)
        '''),
      );
    });

    test('should emit a method invocation on a method with named args', () {
      expect(
        reference('foo').invokeWith('bar', named: {'baz': literal(true)}),
        equalsSource(r'''
          foo.bar(baz: true)
        '''),
      );
    });
  });
}
