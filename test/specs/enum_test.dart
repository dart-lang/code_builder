// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  useDartfmt();

  test('should create an enum', () {
    expect(
        Enum((b) => b
          ..name = 'E'
          ..values.addAll([
            EnumValue((b) => b..name = 'a'),
            EnumValue((b) => b..name = 'b'),
          ])),
        equalsDart(r'''
      enum E {
        a,
        b
      }
    '''));
  });

  test('should create an enum with annotations', () {
    expect(
        Enum((b) => b
          ..annotations.addAll([
            refer('deprecated'),
            refer('Deprecated').call([literalString('This is an old enum')])
          ])
          ..name = 'V'
          ..values.addAll([
            EnumValue((b) => b..name = 'x'),
          ])),
        equalsDart(r'''
      @deprecated
      @Deprecated('This is an old enum')
      enum V {
        x
      }
    '''));
  });

  test('should create an enum with annotated values', () {
    expect(
        Enum((b) => b
          ..name = 'Status'
          ..values.addAll([
            EnumValue((b) => b
              ..name = 'okay'
              ..annotations.addAll([
                refer('deprecated'),
                refer('Deprecated').call([literalString('use Good insted')]),
              ])),
            EnumValue((b) => b
              ..name = 'good'
              ..annotations.addAll([
                refer('JsonKey').call([literalString('good')])
              ])),
          ])),
        equalsDart(r'''
      enum Status {
        @deprecated
        @Deprecated('use Good insted')
        okay,
        @JsonKey('good')
        good
      }
    '''));
  });

  test('should create an enum which mixes in and implements specs', () {
    final myEnum = Enum((b) => b
      ..name = 'MyEnum'
      ..implements.addAll(const [
        Reference('InterfaceA'),
        Reference('InterfaceB'),
      ])
      ..mixins.addAll(const [
        Reference('Mixin1'),
        Reference('Mixin2'),
      ])
      ..values.addAll([
        EnumValue((v) => v..name = 'a'),
        EnumValue((v) => v..name = 'b'),
        EnumValue((v) => v..name = 'c'),
      ]));
    expect(myEnum, equalsDart('''
    enum MyEnum with Mixin1, Mixin2 implements InterfaceA, InterfaceB {
      a,
      b,
      c
    }
    '''));
  });

  test('should create an enum which targets a named constructor', () {
    final myEnum = Enum((b) => b
      ..name = 'MyEnum'
      ..constructors.addAll([
        Constructor((c) => c..constant = true),
        Constructor((c) => c
          ..constant = true
          ..name = 'target'),
      ])
      ..values.addAll([
        EnumValue((v) => v..name = 'a'),
        EnumValue((v) => v
          ..name = 'b'
          ..targetName = 'target'),
        EnumValue((v) => v..name = 'c'),
      ]));
    expect(myEnum, equalsDart('''
    enum MyEnum {
      a,
      b.target(),
      c;

      const MyEnum();
      const MyEnum.target();
    }
    '''));
  });

  test('should create an enum which targets a redirecting constructor', () {
    final myEnum = Enum((b) => b
      ..name = 'MyEnum'
      ..constructors.addAll([
        Constructor((c) => c..constant = true),
        Constructor((c) => c
          ..constant = true
          ..name = 'redirect'
          ..initializers.add(
            refer('this').call([]).code,
          )),
      ])
      ..values.addAll([
        EnumValue((v) => v..name = 'a'),
        EnumValue((v) => v
          ..name = 'b'
          ..targetName = 'redirect'),
        EnumValue((v) => v..name = 'c'),
      ]));
    expect(myEnum, equalsDart('''
    enum MyEnum {
      a,
      b.redirect(),
      c;

      const MyEnum();
      const MyEnum.redirect() : this();
    }
    '''));
  });

  test('should create an enum which targets a redirecting factory constructor',
      () {
    final myEnum = Enum((b) => b
      ..name = 'MyEnum'
      ..constructors.addAll([
        Constructor((c) => c..constant = true),
        Constructor((c) => c
          ..constant = true
          ..factory = true
          ..name = 'redirect'
          ..redirect = refer('MyOtherEnum.target')
          ..optionalParameters.addAll([
            Parameter((p) => p
              ..type = refer('int?')
              ..name = 'myInt'),
            Parameter((p) => p
              ..type = refer('String?')
              ..name = 'myString')
          ]))
      ])
      ..values.addAll([
        EnumValue((v) => v..name = 'a'),
        EnumValue((v) => v
          ..name = 'b'
          ..targetName = 'redirect'
          ..arguments.addAll([
            literalNum(1),
            literalString('abc'),
          ])),
        EnumValue((v) => v
          ..name = 'c'
          ..targetName = 'redirect'),
      ]));
    expect(myEnum, equalsDart('''
    enum MyEnum {
      a,
      b.redirect(1, 'abc'),
      c.redirect();

      const MyEnum();
      const factory MyEnum.redirect([int? myInt, String? myString]) = MyOtherEnum.target;
    }
    '''));
  });

  test('should create an enum which targets an unnamed constructor', () {
    final myEnum = Enum((b) => b
      ..name = 'MyEnum'
      ..constructors.add(Constructor((c) => c
        ..constant = true
        ..optionalParameters.addAll([
          Parameter((p) => p
            ..toThis = true
            ..name = 'myInt'),
          Parameter((p) => p
            ..toThis = true
            ..name = 'myString')
        ])))
      ..fields.addAll([
        Field((f) => f
          ..modifier = FieldModifier.final$
          ..type = refer('int?')
          ..name = 'myInt'),
        Field((f) => f
          ..modifier = FieldModifier.final$
          ..type = refer('String?')
          ..name = 'myString')
      ])
      ..values.addAll([
        EnumValue((v) => v..name = 'a'),
        EnumValue((v) => v
          ..name = 'b'
          ..arguments.addAll([
            literalNum(1),
            literalString('abc'),
          ])),
        EnumValue((v) => v..name = 'c'),
      ]));
    expect(myEnum, equalsDart('''
    enum MyEnum {
      a,
      b(1, 'abc'),
      c;

      const MyEnum([this.myInt, this.myString]);

      final int? myInt;
      final String? myString;
    }
    '''));
  });

  test('should create an enum with generics', () {
    final myEnum = Enum((b) => b
      ..name = 'MyEnum'
      ..types.add(const Reference('T'))
      ..constructors.add(Constructor((c) => c
        ..constant = true
        ..requiredParameters.add(Parameter((p) => p
          ..toThis = true
          ..name = 'value'))))
      ..fields.add(
        Field((f) => f
          ..modifier = FieldModifier.final$
          ..type = refer('T')
          ..name = 'value'),
      )
      ..values.addAll([
        EnumValue((v) => v
          ..name = 'a'
          ..types.add(const Reference('int'))
          ..arguments.add(literalNum(123))),
        EnumValue((v) => v
          ..name = 'b'
          ..types.add(const Reference('String'))
          ..arguments.add(literalString('abc'))),
        EnumValue((v) => v
          ..name = 'c'
          ..types.add(const Reference('MyEnum'))
          ..arguments.add(refer('MyEnum').property('a'))),
      ]));
    expect(myEnum, equalsDart('''
    enum MyEnum<T> {
      a<int>(123), 
      b<String>('abc'), 
      c<MyEnum>(MyEnum.a);
  
      const MyEnum(this.value);
  
      final T value;
    }
    '''));
  });

  test('should create an enum with fields', () {
    final myEnum = Enum((b) => b
      ..name = 'MyEnum'
      ..constructors.add(Constructor((c) => c
        ..constant = true
        ..optionalParameters.add(Parameter((p) => p
          ..toThis = true
          ..name = 'myInt'))))
      ..fields.addAll([
        Field((f) => f
          ..modifier = FieldModifier.final$
          ..type = refer('int?')
          ..name = 'myInt'),
        Field((f) => f
          ..static = true
          ..modifier = FieldModifier.constant
          ..type = refer('String')
          ..name = 'myString'
          ..assignment = literalString('abc').code),
      ])
      ..values.addAll([
        EnumValue((v) => v..name = 'a'),
        EnumValue((v) => v..name = 'b'),
        EnumValue((v) => v..name = 'c'),
      ]));
    expect(myEnum, equalsDart('''
    enum MyEnum {
      a,
      b,
      c;

      const MyEnum([this.myInt]);

      final int? myInt;
      static const String myString = 'abc';
    }
    '''));
  });

  test('should create an enum with methods', () {
    final myEnum = Enum((b) => b
      ..name = 'MyEnum'
      ..methods.addAll([
        Method((m) => m
          ..returns = refer('int')
          ..type = MethodType.getter
          ..name = 'myInt'
          ..body = literalNum(123).code),
        Method((m) => m
          ..returns = refer('Iterable<String>')
          ..name = 'myStrings'
          ..modifier = MethodModifier.syncStar
          ..body = Block.of(const [
            Code("yield 'a';"),
            Code("yield 'b';"),
            Code("yield 'c';"),
          ]))
      ])
      ..values.addAll([
        EnumValue((v) => v..name = 'a'),
        EnumValue((v) => v..name = 'b'),
        EnumValue((v) => v..name = 'c'),
      ]));
    expect(myEnum, equalsDart('''
    enum MyEnum {
      a,
      b,
      c;

      int get myInt => 123;
      Iterable<String> myStrings() sync* {
        yield 'a';
        yield 'b';
        yield 'c';
      }
    }
    '''));
  });
}
