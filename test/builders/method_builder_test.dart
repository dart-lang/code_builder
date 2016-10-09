// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing/equals_source.dart';
import 'package:test/test.dart';

void main() {
  test('should emit a simple "void" method', () {
    expect(
      new MethodBuilder.returnVoid(name: 'main'),
      equalsSource('void main() {}'),
    );
  });

  test('should emit a method returning a String', () {
    expect(
      new MethodBuilder(name: 'toString', returns: typeString),
      equalsSource('String toString() {}'),
    );
  });

  test('should emit a method returning a scoped Type', () {
    expect(
        new MethodBuilder(
          name: 'toFoo',
          returns: new TypeBuilder('Foo', importFrom: 'package:foo/foo.dart'),
        )
          ..addParameter(new ParameterBuilder(
            'context',
            type:
                new TypeBuilder('Context', importFrom: 'package:bar/bar.dart'),
          )),
        equalsSource(
          r'''
            foo.Foo toFoo(bar.Context context) {}
          ''',
          scope: simpleNameScope,
        ));
  });

  test('should emit a method returning a scoped Type and scoped Param', () {
    expect(
        new MethodBuilder(
          name: 'toFoo',
          returns: new TypeBuilder('Foo', importFrom: 'package:foo/foo.dart'),
        ),
        equalsSource(
          r'''
            foo.Foo toFoo() {}
          ''',
          scope: simpleNameScope,
        ));
  });

  test('should emit a method annotated', () {
    expect(
        new MethodBuilder(name: 'oldMethod')..addAnnotation(atDeprecated()),
        equalsSource(
          r'''
          @deprecated
          oldMethod() {}
        ''',
        ));
  });

  group('with an expression', () {
    test('should return true', () {
      expect(
        new MethodBuilder(name: 'isSupported', returns: typeBool)
          ..setExpression(literalTrue),
        equalsSource(
          r'''
          bool isSupported() => true;
          ''',
        ),
      );
    });

    test('should return false', () {
      expect(
        new MethodBuilder(name: 'isSupported', returns: typeBool)
          ..setExpression(literalFalse),
        equalsSource(
          r'''
          bool isSupported() => false;
          ''',
        ),
      );
    });

    test('should return null', () {
      expect(
        new MethodBuilder(name: 'isSupported')..setExpression(literalNull),
        equalsSource(
          r'''
          isSupported() => null;
          ''',
        ),
      );
    });

    test('should return "Hello World"', () {
      expect(
        new MethodBuilder(name: 'sayHello', returns: typeString)
          ..setExpression(
            const LiteralString('Hello World'),
          ),
        equalsSource(
          r'''
          String sayHello() => 'Hello World';
          ''',
        ),
      );
    });

    group('with statements', () {
      test('should work with an expression', () {
        expect(
          new MethodBuilder.returnVoid(name: 'main')
            ..addStatement(const LiteralString('Hello World').toStatement()),
          equalsSource(r'''
          void main() {
            'Hello World';
          }
        '''),
        );
      });

      test('should work with an assignment', () {
        expect(
          new MethodBuilder.returnVoid(name: 'main')
            ..addStatement(new ExpressionBuilder.assignment(
              'foo',
              const LiteralString('Hello World'),
            )
                .toStatement()),
          equalsSource(r'''
        void main() {
          foo = 'Hello World';
        }
      '''),
        );
      });

      test('should work with a null-aware assignment', () {
        expect(
          new MethodBuilder.returnVoid(name: 'main')
            ..addStatement(new ExpressionBuilder.assignment(
              'foo',
              const LiteralString('Hello World'),
              nullAware: true,
            )
                .toStatement()),
          equalsSource(r'''
        void main() {
          foo ??= 'Hello World';
        }
      '''),
        );
      });

      test('should work invoking an expression', () {
        expect(
          new MethodBuilder.returnVoid(name: 'main')
            ..addStatement(
              new ExpressionBuilder.invoke('print', positional: [
                const LiteralString('Hello World').invokeSelf(
                  'substring',
                  positional: [const LiteralInt(1)],
                )
              ]).toStatement(),
            ),
          equalsSource(r'''
            void main() {
              print('Hello World'.substring(1));
            }
          '''),
        );
      });
    });

    group('with parameters:', () {
      MethodBuilder method;

      setUp(() {
        method = new MethodBuilder.returnVoid(name: 'main');
      });

      test('single required parameter', () {
        method.addParameter(new ParameterBuilder('name', type: typeString));
        expect(
          method,
          equalsSource(
            r'''
              void main(String name) {}
            ''',
          ),
        );
      });

      test('two required parameters', () {
        method
          ..addParameter(new ParameterBuilder('a', type: typeInt))
          ..addParameter(new ParameterBuilder('b', type: typeInt));
        expect(
          method,
          equalsSource(
            r'''
              void main(int a, int b) {}
            ''',
          ),
        );
      });

      test('one optional parameter', () {
        method.addParameter(new ParameterBuilder.optional(
          'name',
          type: typeString,
        ));
        expect(
          method,
          equalsSource(
            r'''
              void main([String name]) {}
            ''',
          ),
        );
      });

      test('one optional parameter with a default value', () {
        method.addParameter(new ParameterBuilder.optional(
          'enabled',
          type: typeBool,
          defaultTo: literalTrue,
        ));
        expect(
          method,
          equalsSource(
            r'''
              void main([bool enabled = true]) {}
            ''',
          ),
        );
      });

      test('one optional named parameter with a default value', () {
        method.addParameter(new ParameterBuilder.named(
          'enabled',
          type: typeBool,
          defaultTo: literalTrue,
        ));
        expect(
          method,
          equalsSource(
            r'''
              void main({bool enabled: true}) {}
            ''',
          ),
        );
      });

      test('one optional named parameter with an annotation', () {
        method.addParameter(new ParameterBuilder.named(
          'enabled',
          type: typeBool,
          defaultTo: literalTrue,
        )..addAnnotation(atDeprecated()));
        expect(
          method,
          equalsSource(
            r'''
              void main({@deprecated bool enabled: true}) {}
            ''',
          ),
        );
      });
    });

    group('invoking method', () {
      MethodBuilder method;

      setUp(() {
        method = new MethodBuilder(name: 'forward', returns: typeInt);
      });

      test('should call another method with one argument', () {
        method.setExpression(new ExpressionBuilder.invoke(
          'forwardImpl',
          positional: [const LiteralInt(666)],
        ));
        expect(
          method,
          equalsSource(r'''
            int forward() => forwardImpl(666);
          '''),
        );
      });

      test('should call another method with two arguments', () {
        method.setExpression(new ExpressionBuilder.invoke(
          'sum',
          positional: [const LiteralInt(1), const LiteralInt(2)],
        ));
        expect(
          method,
          equalsSource(r'''
            int forward() => sum(1, 2);
          '''),
        );
      });

      test('should call another method with a named arguments', () {
        method.setExpression(new ExpressionBuilder.invoke(
          'forwardImpl',
          named: {'value': const LiteralInt(666)},
        ));
        expect(
          method,
          equalsSource(r'''
            int forward() => forwardImpl(value: 666);
          '''),
        );
      });

      test('should call another method with many arguments', () {
        method.setExpression(new ExpressionBuilder.invoke(
          'forwardImpl',
          positional: const [const LiteralInt(3), const LiteralInt(4)],
          named: {'a': const LiteralInt(1), 'b': const LiteralInt(2)},
        ));
        expect(
          method,
          equalsSource(r'''
          int forward() => forwardImpl(3, 4, a: 1, b: 2);
        '''),
        );
      });
    });
  });

  test('should be able to emit a closure', () {
    var assertion = (new MethodBuilder()
        ..addStatement(literalTrue.asReturnStatement()))
        .toClosure()
        .asAssert();
    expect(
      new MethodBuilder.returnVoid(name: 'main')..addStatement(assertion),
      equalsSource(r'''
        void main() {
          assert(() {
            return true;
          });
        }
      '''),
    );
  });
}
