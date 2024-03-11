// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

import '../common.dart';

void main() {
  useDartfmt();

  test('minimum extension type', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar')),
      equalsDart(r'''
        extension type Foo(int bar) { }
      '''),
    );
  });

  test('const extension type', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..constant = true
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar')),
      equalsDart(r'''
        extension type const Foo(int bar) { }
      '''),
    );
  });

  test('extension type with metadata', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar')
        ..docs.add(
          '/// My favorite extension type.',
        )
        ..annotations.addAll([
          refer('deprecated'),
          refer('Deprecated')
              .call([literalString('This is an old extension type')])
        ])),
      equalsDart(r'''
        /// My favorite extension type.
        @deprecated
        @Deprecated('This is an old extension type')
        extension type Foo(int bar) { }
      '''),
    );
  });

  test('extension type with generics', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..types.addAll([
          TypeReference((b) => b..symbol = 'T'),
          TypeReference((b) => b..symbol = 'U')
        ])
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'T')
          ..name = 'bar')),
      equalsDart(r'''
        extension type Foo<T,U>(T bar) { }
      '''),
    );
  });

  test('extension type with generics bound', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..types.add(TypeReference((b) => b
          ..symbol = 'T'
          ..bound = TypeReference((b) => b..symbol = 'num')))
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'T')
          ..name = 'bar')),
      equalsDart(r'''
        extension type Foo<T extends num>(T bar) { }
      '''),
    );
  });

  test('extension type with named primary constructor', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..primaryConstructorName = 'named'
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar')),
      equalsDart(r'''
        extension type Foo.named(int bar) { }
      '''),
    );
  });

  test('extension type with metadata on field', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar'
          ..docs.add(
            '/// My favorite representation declaration.',
          )
          ..annotations.addAll([
            refer('deprecated'),
            refer('Deprecated').call(
                [literalString('This is an old representation declaration')])
          ]))),
      equalsDart(r'''
        extension type Foo(/// My favorite representation declaration.
          @deprecated
          @Deprecated('This is an old representation declaration')
          int bar) { }
      '''),
    );
  });

  test('extension type with implements', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..implements.add(TypeReference((b) => b.symbol = 'num'))
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar')),
      equalsDart(r'''
        extension type Foo(int bar) implements num { }
      '''),
    );
  });

  test('extension type with multiple implements', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..implements.addAll([
          TypeReference((b) => b.symbol = 'num'),
          TypeReference((b) => b.symbol = 'Object')
        ])
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar')),
      equalsDart(r'''
        extension type Foo(int bar) implements num,Object { }
      '''),
    );
  });

  test('extension type with constructors', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..primaryConstructorName = '_'
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar')
        ..constructors.addAll([
          Constructor((b) => b.requiredParameters.add(Parameter((b) => b
            ..toThis = true
            ..name = 'bar'))),
          Constructor((b) => b
            ..name = 'named'
            ..factory = true
            ..requiredParameters.add(Parameter((b) => b
              ..type = TypeReference((b) => b.symbol = 'int')
              ..name = 'baz'))
            ..body = const Code('return Foo(baz);'))
        ])),
      equalsDart(r'''
        extension type Foo._(int bar) {
          Foo(this.bar);

          factory Foo.named(int baz) {
            return Foo(baz);
          }
        }
      '''),
    );
  });

  test('extension type with external field', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar')
        ..fields.add(Field((b) => b
          ..external = true
          ..type = TypeReference((b) => b.symbol = 'int')
          ..name = 'property'))),
      equalsDart(r'''
        extension type Foo(int bar) {
          external int property;
        }
      '''),
    );
  });

  test('extension type with methods', () {
    expect(
      ExtensionType((b) => b
        ..name = 'Foo'
        ..representationDeclaration = RepresentationDeclaration((b) => b
          ..declaredRepresentationType = TypeReference((b) => b.symbol = 'int')
          ..name = 'bar')
        ..methods.addAll([
          Method((b) => b
            ..type = MethodType.getter
            ..returns = TypeReference((b) => b.symbol = 'int')
            ..name = 'value'
            ..body = const Code('return this.bar;')),
          Method((b) => b
            ..returns = TypeReference((b) => b.symbol = 'int')
            ..name = 'getValue'
            ..lambda = true
            ..body = const Code('this.bar'))
        ])),
      equalsDart(r'''
        extension type Foo(int bar) {
          int get value { return this.bar; }
          int getValue() => this.bar;
        }
      '''),
    );
  });
}
