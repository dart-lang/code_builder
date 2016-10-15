import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing/equals_source.dart';
import 'package:test/test.dart';

void main() {
  group('$ClassBuilder', () {
    test('should emit a simple class', () {
      expect(clazz('Animal'), equalsSource(r'''
        class Animal {}
      '''));
    });

    test('should emit an annotated class', () {
      expect(
        clazz('Animal', [
          annotation('deprecated'),
        ]),
        equalsSource(r'''
          @deprecated
          class Animal {}
        '''),
      );
    });
  });

  group('$ConstructorBuilder', () {
    ClassBuilder animal;

    setUp(() => animal = clazz('Animal'));

    test('should emit a simple default constructor', () {
      expect(
        constructor().attachTo(animal),
        equalsSource(r'''
          Animal();
        '''),
      );
    });

    test('should emit a named constructor', () {
      expect(
        constructorNamed('empty').attachTo(animal),
        equalsSource(r'''
          Animal.empty();
        '''),
      );
    });

    test('should emit a constructor with a statement body', () {
      expect(
        constructor([
          printMethod.call([literal('Hello World')]),
        ]).attachTo(animal),
        equalsSource(r'''
          Animal() {
            print('Hello World');
          }
        '''),
      );
    });

    test('should emit a constructor with constructor initializers', () {
      expect(
        constructor([
          initializer('age', literal(0)),
          initializer('delicious', literal(true)),
        ]).attachTo(animal),
        equalsSource(r'''
          Animal()
            : this.age = 0,
              this.delicious = true;
        '''),
      );
    });

    test('should emit a constructor with a parameter', () {
      expect(
        constructor([
          parameter('foo'),
        ]).attachTo(animal),
        equalsSource(r'''
          Animal(foo);
        '''),
      );
    });

    test('should emit a constructor with an optional parameter', () {
      expect(
        constructor([
          parameter('foo').toDefault(),
        ]).attachTo(animal),
        equalsSource(r'''
          Animal([foo]);
        '''),
      );
    });

    test('should emit a constructor with a field formal parameter', () {
      expect(
        constructor([
          parameter('foo').toField(),
        ]).attachTo(animal),
        equalsSource(r'''
          Animal(this.foo);
        '''),
      );
    });

    test('should emit a constructor with a named parameter', () {
      expect(
        new ConstructorBuilder(animal)..addNamedParameter(parameter('foo')),
        equalsSource(r'''
          Animal({foo});
        '''),
      );
    });

    test('should emit a constructor with a named parameter with a value', () {
      expect(
        new ConstructorBuilder(animal)
          ..addNamedParameter(parameter('foo', [literal(true)])),
        equalsSource(r'''
          Animal({foo: true});
        '''),
      );
    });
  });
}
