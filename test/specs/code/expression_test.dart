// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

import '../../common.dart';

void main() {
  useDartfmt();

  test('should emit a simple expression', () {
    expect(literalNull, equalsDart('null'));
  });

  test('should emit a String', () {
    expect(literalString(r'$monkey'), equalsDart(r"'$monkey'"));
  });

  test('should emit a raw String', () {
    expect(literalString(r'$monkey', raw: true), equalsDart(r"r'$monkey'"));
  });

  test('should escape single quotes in a String', () {
    expect(literalString(r"don't"), equalsDart(r"'don\'t'"));
  });

  test('does not allow single quote in raw string', () {
    expect(() => literalString(r"don't", raw: true), throwsArgumentError);
  });

  test('should escape a newline in a string', () {
    expect(literalString('some\nthing'), equalsDart(r"'some\nthing'"));
  });

  test('should emit a && expression', () {
    expect(literalTrue.and(literalFalse), equalsDart('true && false'));
  });

  test('should emit a || expression', () {
    expect(literalTrue.or(literalFalse), equalsDart('true || false'));
  });

  test('should emit a ! expression', () {
    expect(literalTrue.negate(), equalsDart('!true'));
  });

  test('should emit a list', () {
    expect(literalList([]), equalsDart('[]'));
  });

  test('should emit a const list', () {
    expect(literalConstList([]), equalsDart('const []'));
  });

  test('should emit an explicitly typed list', () {
    expect(literalList([], refer('int')), equalsDart('<int>[]'));
  });

  test('should emit a set', () {
    // ignore: prefer_collection_literals
    expect(literalSet(Set()), equalsDart('{}'));
  });

  test('should emit a const set', () {
    // ignore: prefer_collection_literals
    expect(literalConstSet(Set()), equalsDart('const {}'));
  });

  test('should emit an explicitly typed set', () {
    // ignore: prefer_collection_literals
    expect(literalSet(Set(), refer('int')), equalsDart('<int>{}'));
  });

  test('should emit a map', () {
    expect(literalMap({}), equalsDart('{}'));
  });

  test('should emit a const map', () {
    expect(literalConstMap({}), equalsDart('const {}'));
  });

  test('should emit an explicitly typed map', () {
    expect(
      literalMap({}, refer('int'), refer('bool')),
      equalsDart('<int, bool>{}'),
    );
  });

  test('should emit a map of other literals and expressions', () {
    expect(
      literalMap({
        1: 'one',
        2: refer('two'),
        refer('three'): 3,
        refer('Map').newInstance([]): null,
      }),
      equalsDart(r"{1: 'one', 2: two, three: 3, Map(): null, }"),
    );
  });

  test('should emit a map with spreads', () {
    expect(
      literalMap({
        literalSpread(): refer('one'),
        2: refer('two'),
        literalNullSafeSpread(): refer('three'),
        refer('Map').newInstance([]): null,
      }),
      equalsDart('{...one, 2: two, ...?three, Map(): null, }'),
    );
  });

  test('should emit a list of other literals and expressions', () {
    expect(
      literalList([
        <dynamic>[],
        // ignore: prefer_collection_literals
        Set<dynamic>(),
        true,
        null,
        refer('Map').newInstance([])
      ]),
      equalsDart('[[], {}, true, null, Map(), ]'),
    );
  });

  test('should emit a set of other literals and expressions', () {
    expect(
      // ignore: prefer_collection_literals
      literalSet([
        <dynamic>[],
        // ignore: prefer_collection_literals
        Set<dynamic>(),
        true,
        null,
        refer('Map').newInstance([])
      ]),
      equalsDart('{[], {}, true, null, Map(), }'),
    );
  });

  test('should emit an empty record', () {
    expect(literalRecord([], {}), equalsDart('()'));
  });

  test('should emit a const empty record', () {
    expect(literalConstRecord([], {}), equalsDart('const ()'));
  });

  test('should emit a record with only positional fields', () {
    expect(literalRecord([1, ''], {}), equalsDart("(1, '')"));
  });

  test('should correctly emit a record with a single positional field', () {
    expect(literalRecord([1], {}), equalsDart('(1,)'));
  });

  test('should emit a record with only named fields', () {
    expect(literalRecord([], {'named': 1, 'other': []}),
        equalsDart('(named: 1, other: [])'));
  });

  test('should emit a record with both positional and named fields', () {
    expect(literalRecord([0], {'x': true, 'y': 0}),
        equalsDart('(0, x: true, y: 0)'));
  });

  test('should emit a record of other literals and expressions', () {
    expect(
        literalRecord([
          1,
          refer('one'),
          'one'
        ], {
          'named': refer('Foo').newInstance([literalNum(1)])
        }),
        equalsDart("(1, one, 'one', named: Foo(1))"));
  });

  test('should emit a type as an expression', () {
    expect(refer('Map'), equalsDart('Map'));
  });

  test('should emit a scoped type as an expression', () {
    expect(
      refer('Foo', 'package:foo/foo.dart'),
      equalsDart(
          '_i1.Foo', DartEmitter(allocator: Allocator.simplePrefixing())),
    );
  });

  test('should emit invoking Type()', () {
    expect(
      refer('Map').newInstance([]),
      equalsDart('Map()'),
    );
  });

  test('should emit invoking named constructor', () {
    expect(
      refer('Foo').newInstanceNamed('bar', []),
      equalsDart('Foo.bar()'),
    );
  });

  test('should emit invoking const Type()', () {
    expect(
      refer('Object').constInstance([]),
      equalsDart('const Object()'),
    );
  });

  test('should emit invoking a property accessor', () {
    expect(refer('foo').property('bar'), equalsDart('foo.bar'));
  });

  test('should emit invoking a cascade property accessor', () {
    expect(refer('foo').cascade('bar'), equalsDart('foo..bar'));
  });

  test('should emit invoking a null safe property accessor', () {
    expect(refer('foo').nullSafeProperty('bar'), equalsDart('foo?.bar'));
  });

  test('should emit invoking a method with a single positional argument', () {
    expect(
      refer('foo').call([
        literal(1),
      ]),
      equalsDart('foo(1)'),
    );
  });

  test('should emit invoking a method with positional arguments', () {
    expect(
      refer('foo').call([
        literal(1),
        literal(2),
        literal(3),
      ]),
      equalsDart('foo(1, 2, 3, )'),
    );
  });

  test('should emit invoking a method with a single named argument', () {
    expect(
      refer('foo').call([], {
        'bar': literal(1),
      }),
      equalsDart('foo(bar: 1)'),
    );
  });

  test('should emit invoking a method with named arguments', () {
    expect(
      refer('foo').call([], {
        'bar': literal(1),
        'baz': literal(2),
      }),
      equalsDart('foo(bar: 1, baz: 2, )'),
    );
  });

  test('should emit invoking a method with positional and named arguments', () {
    expect(
      refer('foo').call([
        literal(1)
      ], {
        'bar': literal(2),
        'baz': literal(3),
      }),
      equalsDart('foo(1, bar: 2, baz: 3, )'),
    );
  });

  test('should emit invoking a method with a single type argument', () {
    expect(
      refer('foo').call(
        [],
        {},
        [
          refer('String'),
        ],
      ),
      equalsDart('foo<String>()'),
    );
  });

  test('should emit invoking a method with type arguments', () {
    expect(
      refer('foo').call(
        [],
        {},
        [
          refer('String'),
          refer('int'),
        ],
      ),
      equalsDart('foo<String, int>()'),
    );
  });

  test('should emit a function type', () {
    expect(
      FunctionType((b) => b.returnType = refer('void')),
      equalsDart('void Function()'),
    );
  });

  test('should emit a typedef statement', () {
    expect(
      FunctionType((b) => b.returnType = refer('void')).toTypeDef('Void0'),
      equalsDart('typedef Void0 = void Function();'),
    );
  });

  test('should emit a function type with type parameters', () {
    expect(
      FunctionType((b) => b
        ..returnType = refer('T')
        ..types.add(refer('T'))),
      equalsDart('T Function<T>()'),
    );
  });

  test('should emit a function type a single parameter', () {
    expect(
      FunctionType((b) => b..requiredParameters.add(refer('String'))),
      equalsDart('Function(String)'),
    );
  });

  test('should emit a function type with parameters', () {
    expect(
      FunctionType((b) => b
        ..requiredParameters.add(refer('String'))
        ..optionalParameters.add(refer('int'))),
      equalsDart('Function(String, [int, ])'),
    );
  });

  test('should emit a function type with named parameters', () {
    expect(
      FunctionType((b) => b
        ..namedParameters.addAll({
          'x': refer('int'),
          'y': refer('int'),
        })),
      equalsDart('Function({int x, int y, })'),
    );
  });

  test(
      'should emit a function type with named required and optional parameters',
      () {
    expect(
      FunctionType((b) => b
        ..namedRequiredParameters.addAll({
          'x': refer('int'),
        })
        ..namedParameters.addAll({
          'y': refer('int'),
        })),
      equalsDart('Function({required int x, int y, })'),
    );
  });

  test('should emit a function type with named required parameters', () {
    expect(
      FunctionType((b) => b
        ..namedRequiredParameters.addAll({
          'x': refer('int'),
          'y': refer('int'),
        })),
      equalsDart('Function({required int x, required int y, })'),
    );
  });

  test('should emit a nullable function type in a Null Safety library', () {
    final emitter = DartEmitter.scoped(useNullSafetySyntax: true);
    expect(
      FunctionType((b) => b
        ..requiredParameters.add(refer('String'))
        ..isNullable = true),
      equalsDart('Function(String)?', emitter),
    );
  });

  test('should emit a nullable function type in pre-Null Safety library', () {
    expect(
      FunctionType((b) => b
        ..requiredParameters.add(refer('String'))
        ..isNullable = true),
      equalsDart('Function(String)'),
    );
  });

  test('should emit a non-nullable function type in a Null Safety library', () {
    final emitter = DartEmitter.scoped(useNullSafetySyntax: true);
    expect(
      FunctionType((b) => b
        ..requiredParameters.add(refer('String'))
        ..isNullable = false),
      equalsDart('Function(String)', emitter),
    );
  });

  test('should emit a non-nullable function type in pre-Null Safety library',
      () {
    expect(
      FunctionType((b) => b
        ..requiredParameters.add(refer('String'))
        ..isNullable = false),
      equalsDart('Function(String)'),
    );
  });

  test('should emit a closure', () {
    expect(
      refer('map').property('putIfAbsent').call([
        literalString('foo'),
        Method((b) => b..body = literalTrue.code).closure,
      ]),
      equalsDart("map.putIfAbsent('foo', () => true, )"),
    );
  });

  test('should emit a generic closure', () {
    expect(
      refer('map').property('putIfAbsent').call([
        literalString('foo'),
        Method((b) => b
          ..types.add(refer('T'))
          ..body = literalTrue.code).genericClosure,
      ]),
      equalsDart("map.putIfAbsent('foo', <T>() => true, )"),
    );
  });

  test('should emit an assignment', () {
    expect(
      refer('foo').assign(literalTrue),
      equalsDart('foo = true'),
    );
  });

  test('should emit an if null assignment', () {
    expect(
      refer('foo').ifNullThen(literalTrue),
      equalsDart('foo ?? true'),
    );
  });

  test('should emit a null check', () {
    expect(refer('foo').nullChecked, equalsDart('foo!'));
  });

  test('should emit an if null index operator set', () {
    expect(
      refer('bar')
          .index(literalTrue)
          .ifNullThen(literalFalse)
          // ignore: deprecated_member_use_from_same_package
          .assignVar('foo')
          .statement,
      equalsDart('var foo = bar[true] ?? false;'),
    );
  });

  test('should emit a null-aware assignment', () {
    expect(
      refer('foo').assignNullAware(literalTrue),
      equalsDart('foo ??= true'),
    );
  });

  test('should emit an index operator', () {
    expect(
      // ignore: deprecated_member_use_from_same_package
      refer('bar').index(literalString('key')).assignVar('foo').statement,
      equalsDart("var foo = bar['key'];"),
    );
  });

  test('should emit an index operator set', () {
    expect(
      refer('bar')
          .index(literalString('key'))
          .assign(literalFalse)
          // ignore: deprecated_member_use_from_same_package
          .assignVar('foo')
          .statement,
      equalsDart("var foo = bar['key'] = false;"),
    );
  });

  test('should emit a null-aware index operator set', () {
    expect(
      refer('bar')
          .index(literalTrue)
          .assignNullAware(literalFalse)
          // ignore: deprecated_member_use_from_same_package
          .assignVar('foo')
          .statement,
      equalsDart('var foo = bar[true] ??= false;'),
    );
  });

  test('should emit assigning to a var', () {
    expect(
      // ignore: deprecated_member_use_from_same_package
      literalTrue.assignVar('foo'),
      equalsDart('var foo = true'),
    );
  });

  test('should emit assigning to a type', () {
    expect(
      // ignore: deprecated_member_use_from_same_package
      literalTrue.assignVar('foo', refer('bool')),
      equalsDart('bool foo = true'),
    );
  });

  test('should emit assigning to a final', () {
    expect(
      // ignore: deprecated_member_use_from_same_package
      literalTrue.assignFinal('foo'),
      equalsDart('final foo = true'),
    );
  });

  test('should emit assigning to a const', () {
    expect(
      // ignore: deprecated_member_use_from_same_package
      literalTrue.assignConst('foo'),
      equalsDart('const foo = true'),
    );
  });

  test('should emit await', () {
    expect(
      refer('future').awaited,
      equalsDart('await future'),
    );
  });

  test('should emit return', () {
    expect(
      literalNull.returned,
      equalsDart('return null'),
    );
  });

  test('should emit spread', () {
    expect(
      refer('foo').spread,
      equalsDart('...foo'),
    );
  });

  test('should emit null safe spread', () {
    expect(
      refer('foo').nullSafeSpread,
      equalsDart('...?foo'),
    );
  });

  test('should emit throw', () {
    expect(
      literalNull.thrown,
      equalsDart('throw null'),
    );
  });

  test('should emit an explicit cast', () {
    expect(
      refer('foo').asA(refer('String')).property('length'),
      equalsDart('(foo as String).length'),
    );
  });

  test('should emit an is check', () {
    expect(
      refer('foo').isA(refer('String')),
      equalsDart('foo is String'),
    );
  });

  test('should emit an is! check', () {
    expect(
      refer('foo').isNotA(refer('String')),
      equalsDart('foo is! String'),
    );
  });

  test('should emit an equality check', () {
    expect(
      refer('foo').equalTo(literalString('bar')),
      equalsDart("foo == 'bar'"),
    );
  });

  test('should emit an inequality check', () {
    expect(
      refer('foo').notEqualTo(literalString('bar')),
      equalsDart("foo != 'bar'"),
    );
  });

  test('should emit an greater than check', () {
    expect(
      refer('foo').greaterThan(literalString('bar')),
      equalsDart("foo > 'bar'"),
    );
  });

  test('should emit an less than check', () {
    expect(
      refer('foo').lessThan(literalString('bar')),
      equalsDart("foo < 'bar'"),
    );
  });

  test('should emit an greater or equals check', () {
    expect(
      refer('foo').greaterOrEqualTo(literalString('bar')),
      equalsDart("foo >= 'bar'"),
    );
  });

  test('should emit an less or equals check', () {
    expect(
      refer('foo').lessOrEqualTo(literalString('bar')),
      equalsDart("foo <= 'bar'"),
    );
  });

  test('should emit a conditional', () {
    expect(
      refer('foo').conditional(literal(1), literal(2)),
      equalsDart('foo ? 1 : 2'),
    );
  });

  test('should emit an operator add call', () {
    expect(refer('foo').operatorAdd(refer('foo2')), equalsDart('foo + foo2'));
  });

  test('should emit an operator subtract call', () {
    expect(
      refer('foo').operatorSubtract(refer('foo2')),
      equalsDart('foo - foo2'),
    );
  });

  test('should emit an operator divide call', () {
    expect(
        refer('foo').operatorDivide(refer('foo2')), equalsDart('foo / foo2'));
  });

  test('should emit an operator multiply call', () {
    expect(
        refer('foo').operatorMultiply(refer('foo2')), equalsDart('foo * foo2'));
  });

  test('should emit an euclidean modulo operator call', () {
    expect(refer('foo').operatorEuclideanModulo(refer('foo2')),
        equalsDart('foo % foo2'));
  });

  test('should emit an int divide operator call', () {
    expect(
      refer('foo').operatorIntDivide(refer('foo2')),
      equalsDart('foo ~/ foo2'),
    );
  });

  test('should emit an unary prefix increment operator call', () {
    expect(refer('foo').operatorUnaryPrefixIncrement(), equalsDart('++foo'));
  });

  test('should emit an unary postfix increment operator call', () {
    expect(refer('foo').operatorUnaryPostfixIncrement(), equalsDart('foo++'));
  });

  test('should emit an unary prefix minus operator call', () {
    expect(refer('foo').operatorUnaryMinus(), equalsDart('-foo'));
  });

  test('should emit an unary prefix decrement operator call', () {
    expect(refer('foo').operatorUnaryPrefixDecrement(), equalsDart('--foo'));
  });

  test('should emit an unary postfix decrement operator call', () {
    expect(refer('foo').operatorUnaryPostfixDecrement(), equalsDart('foo--'));
  });

  test('should emit a bitwise and operator call', () {
    expect(
      refer('foo').operatorBitwiseAnd(refer('foo2')),
      equalsDart('foo & foo2'),
    );
  });

  test('should emit a bitwise or operator call', () {
    expect(
      refer('foo').operatorBitwiseOr(refer('foo2')),
      equalsDart('foo | foo2'),
    );
  });

  test('should emit a bitwise xor operator call', () {
    expect(
      refer('foo').operatorBitwiseXor(refer('foo2')),
      equalsDart('foo ^ foo2'),
    );
  });

  test('should emit a unary bitwise complement operator call', () {
    expect(
      refer('foo').operatorUnaryBitwiseComplement(),
      equalsDart('~foo'),
    );
  });

  test('should emit a shift left operator call', () {
    expect(
      refer('foo').operatorShiftLeft(refer('foo2')),
      equalsDart('foo << foo2'),
    );
  });

  test('should emit a shift right operator call', () {
    expect(
      refer('foo').operatorShiftRight(refer('foo2')),
      equalsDart('foo >> foo2'),
    );
  });

  test('should emit a shift right unsigned operator call', () {
    expect(
      refer('foo').operatorShiftRightUnsigned(refer('foo2')),
      equalsDart('foo >>> foo2'),
    );
  });

  test('should emit a const variable declaration', () {
    expect(declareConst('foo').assign(refer('bar')),
        equalsDart('const foo = bar'));
  });

  test('should emit a typed const variable declaration', () {
    expect(declareConst('foo', type: refer('String')).assign(refer('bar')),
        equalsDart('const String foo = bar'));
  });

  test('should emit a final variable declaration', () {
    expect(declareFinal('foo').assign(refer('bar')),
        equalsDart('final foo = bar'));
  });

  test('should emit a typed final variable declaration', () {
    expect(declareFinal('foo', type: refer('String')).assign(refer('bar')),
        equalsDart('final String foo = bar'));
  });

  test('should emit a nullable typed final variable declaration', () {
    final emitter = DartEmitter.scoped(useNullSafetySyntax: true);
    expect(
        declareFinal('foo',
            type: TypeReference((b) => b
              ..symbol = 'String'
              ..isNullable = true)).assign(refer('bar')),
        equalsDart('final String? foo = bar', emitter));
  }, skip: 'https://github.com/dart-lang/code_builder/issues/315');

  test('should emit a late final variable declaration', () {
    expect(declareFinal('foo', late: true).assign(refer('bar')),
        equalsDart('late final foo = bar'));
  });

  test('should emit a late typed final variable declaration', () {
    expect(
        declareFinal('foo', type: refer('String'), late: true)
            .assign(refer('bar')),
        equalsDart('late final String foo = bar'));
  });

  test('should emit a variable declaration', () {
    expect(declareVar('foo').assign(refer('bar')), equalsDart('var foo = bar'));
  });

  test('should emit a typed variable declaration', () {
    expect(declareVar('foo', type: refer('String')).assign(refer('bar')),
        equalsDart('String foo = bar'));
  });

  test('should emit a late variable declaration', () {
    expect(declareVar('foo', late: true).assign(refer('bar')),
        equalsDart('late var foo = bar'));
  });

  test('should emit a late typed variable declaration', () {
    expect(
        declareVar('foo', type: refer('String'), late: true)
            .assign(refer('bar')),
        equalsDart('late String foo = bar'));
  });

  test('should emit a perenthesized epression', () {
    expect(
        refer('foo').ifNullThen(refer('FormatException')
            .newInstance([literalString('missing foo')])
            .thrown
            .parenthesized),
        equalsDart('foo ?? (throw FormatException(\'missing foo\'))'));
  });

  test('should emit an addition assigment expression', () {
    expect(
      refer('foo').assignAdd(refer('bar')),
      equalsDart('foo += bar'),
    );
  });

  test('should emit an subtraction assigment expression', () {
    expect(
      refer('foo').assignSubtract(refer('bar')),
      equalsDart('foo -= bar'),
    );
  });

  test('should emit an multiplication assigment expression', () {
    expect(
      refer('foo').assignMultiply(refer('bar')),
      equalsDart('foo *= bar'),
    );
  });

  test('should emit an division assigment expression', () {
    expect(
      refer('foo').assignDivide(refer('bar')),
      equalsDart('foo /= bar'),
    );
  });

  test('should emit an int division assigment expression', () {
    expect(
      refer('foo').assignIntDivide(refer('bar')),
      equalsDart('foo ~/= bar'),
    );
  });

  test('should emit an euclidean modulo assigment expression', () {
    expect(
      refer('foo').assignEuclideanModulo(refer('bar')),
      equalsDart('foo %= bar'),
    );
  });

  test('should emit an shift left assigment expression', () {
    expect(
      refer('foo').assignShiftLeft(refer('bar')),
      equalsDart('foo <<= bar'),
    );
  });

  test('should emit an shift right assigment expression', () {
    expect(
      refer('foo').assignShiftRight(refer('bar')),
      equalsDart('foo >>= bar'),
    );
  });

  test('should emit an shift right unsigned assigment expression', () {
    expect(
      refer('foo').assignShiftRightUnsigned(refer('bar')),
      equalsDart('foo >>>= bar'),
    );
  });

  test('should emit an bitwise and assigment expression', () {
    expect(
      refer('foo').assignBitwiseAnd(refer('bar')),
      equalsDart('foo &= bar'),
    );
  });

  test('should emit an bitwise xor assigment expression', () {
    expect(
      refer('foo').assignBitwiseXor(refer('bar')),
      equalsDart('foo ^= bar'),
    );
  });

  test('should emit an bitwise or assigment expression', () {
    expect(
      refer('foo').assignBitwiseOr(refer('bar')),
      equalsDart('foo |= bar'),
    );
  });
}
