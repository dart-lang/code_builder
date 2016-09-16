// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing/equals_source.dart';
import 'package:test/test.dart';

// Closely mirrors the API you would need to do dependency injection :)
void main() {
  test('Emits a complex generated file', () {
    var clazz = new ClassBuilder(r'Injector', implement: ['App'])
      ..addField(new FieldBuilder.isFinal(
        '_module',
        type: const TypeBuilder('Module'),
      ))
      ..addConstructor(new ConstructorBuilder.initializeFields(
        positionalArguments: ['_module'],
      ))
      ..addMethod(
        new MethodBuilder(
          name: 'getThing',
          returns: const TypeBuilder('Thing'),
        )
          ..addAnnotation(atOverride)
          ..setExpression(new ExpressionBuilder.invoke(
            'new Thing',
            positional: [
              new ExpressionBuilder.invoke('_module.getDep1'),
              new ExpressionBuilder.invoke('_module.getDep2'),
            ],
          )),
      );
    var lib = new LibraryBuilder()
      ..addDirective(
        new ImportBuilder('app.dart'),
      )
      ..addDeclaration(clazz);
    expect(
      lib,
      equalsSource(
        r'''
          import 'app.dart';

          class Injector implements App {
            final Module _module;

            Injector(this._module);

            @override
            Thing getThing() => new Thing(_module.getDep1(), _module.getDep2());
          }
        ''',
      ),
    );
  });

  test('Emits a complex generated file with conflicting imports scoped', () {
    var lib = new LibraryBuilder.scope()
      ..addDeclaration(new MethodBuilder(
        name: 'doThing',
        returns: new TypeBuilder(
          'Thing',
          importFrom: 'package:thing/thing.dart',
        ),
      ))
      ..addDeclaration(new MethodBuilder(
          name: 'doOtherThing',
          returns: new TypeBuilder(
            'Thing',
            importFrom: 'package:thing/alternative.dart',
          ))
        ..addParameter(new ParameterBuilder(
          'thing',
          type: new TypeBuilder(
            'Thing',
            importFrom: 'package:thing/thing.dart',
          ),
        )));
    expect(
      lib,
      equalsSource(
        r'''
          import 'package:thing/thing.dart' as _i1;
          import 'package:thing/alternative.dart' as _i2;

          _i1.Thing doThing() {}
          _i2.Thing doOtherThing(_i1.Thing thing) {}
        ''',
      ),
    );
  });
}
