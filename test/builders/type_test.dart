import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  group('new instance', () {
    test('emits a new List', () {
      expect(
        core.List.newInstance([]),
        equalsSource(r'''
          new List()
        '''),
      );
    });

    test('emits a new List.from', () {
      expect(
        core.List.newInstanceWith('from', [
          literal([1, 2, 3]),
        ]),
        equalsSource(r'''
          new List.from([1, 2, 3])
        '''),
      );
    });

    test('emits a new const Point', () {
      expect(
        reference('Point').constInstance([
          literal(1),
          literal(2),
        ]),
        equalsSource(r'''
          const Point(1, 2)
        '''),
      );
    });

    test('emits a const constructor as an annotation', () {
      expect(
        clazz('Animal', [
          core.Deprecated.constInstance([literal('Animals are out of style')]),
        ]),
        equalsSource(r'''
          @Deprecated('Animals are out of style')
          class Animal {}
        '''),
      );
    });

    test('emits a named const constructor as an annotation', () {
      expect(
        clazz('Animal', [
          reference('Component').constInstanceWith(
            'stateful',
            [],
            {
              'selector': literal('animal'),
            },
          ),
        ]),
        equalsSource(r'''
          @Component.stateful(selector: 'animal')
          class Animal {}
        '''),
      );
    });
  });
}
