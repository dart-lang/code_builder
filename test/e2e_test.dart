// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

// Closely mirrors the API you'd need to generate dependency injection :)
void main() {
  test('Should emit a complex generated file', () {
    // Imports from an existing Dart library.
    var appRef = reference('App', 'package:app/app.dart');
    var moduleRef = reference('Module', 'package:app/app.dart');
    var thingRef = reference('Thing', 'package:app/app.dart');

    var clazz = new ClassBuilder('Injector', asImplements: [appRef]);
    clazz
      ..addField(
        new FieldBuilder.asFinal('_module', type: moduleRef),
      )
      ..addConstructor(new ConstructorBuilder()
        ..addPositional(
          new ParameterBuilder('_module'),
          asField: true,
        ))
      ..addMethod(new MethodBuilder(
        'getThing',
        returns: thingRef.newInstance([
          reference('_module').invoke('getDep1', []),
          reference('_module').invoke('getDep2', []),
        ]),
        returnType: thingRef,
      )..addAnnotation(lib$core.override));
    var lib = new LibraryBuilder()
      ..addDirective(
        new ImportBuilder('app.dart'),
      )
      ..addMember(
        clazz,
      );
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
        pretty: true,
      ),
    );
  });

  test('Should emit a complex generated file with scoping applied', () {
    var appRef = reference('App', 'package:app/app.dart');
    var moduleRef = reference('Module', 'package:app/app.dart');
    var thingRef = reference('Thing', 'package:app/thing.dart');
    var lib = new LibraryBuilder.scope()
      ..addMember(new ClassBuilder('Injector', asImplements: [appRef])
        ..addField(
          new FieldBuilder.asFinal(
            '_module',
            type: moduleRef,
          ),
        )
        ..addConstructor(new ConstructorBuilder()
          ..addPositional(
            new ParameterBuilder('_module'),
            asField: true,
          ))
        ..addMethod(new MethodBuilder(
          'getThing',
          returnType: thingRef,
          returns: thingRef.newInstance([
            reference('_module').invoke('getDep1', []),
            reference('_module').invoke('getDep2', []),
          ]),
        )..addAnnotation(lib$core.override))
        ..addMethod(new MethodBuilder(
          'instantiateAndReturnNamedThing',
          returnType: thingRef,
        )
          ..addStatement(
              thingRef.newInstance([], constructor: 'named').asReturn())));
    expect(
      lib,
      equalsSource(
        r'''
          import 'package:app/app.dart' as _i1;
          import 'package:app/thing.dart' as _i2;

          class Injector implements _i1.App {
            final _i1.Module _module;

            Injector(this._module);

            @override
            _i2.Thing getThing() => new _i2.Thing(_module.getDep1(), _module.getDep2());

            _i2.Thing instantiateAndReturnNamedThing() {
              return new _i2.Thing.named();
            }
          }
        ''',
        pretty: true,
      ),
    );
  });
}
