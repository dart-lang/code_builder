// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should generate a complex generated file', () {
    // Imports from an existing Dart library.
    final $App = refer('App', 'package:app/app.dart');
    final $Module = refer('Module', 'package:app/module.dart');
    final $Thing = refer('Thing', 'package:app/thing.dart');

    final clazz = new ClassBuilder()
      ..name = 'Injector'
      ..implements.add($App)
      ..fields.add(new Field((b) => b
        ..modifier = FieldModifier.final$
        ..name = '_module'
        ..type = $Module.type))
      ..constructors.add(new Constructor((b) => b
        ..requiredParameters.add(new Parameter((b) => b
          ..name = '_module'
          ..toThis = true))))
      ..methods.add(new Method((b) => b
        ..name = 'getThing'
        ..body = $Thing.newInstance([
          refer('_module').property('get1').call([]),
          refer('_module').property('get2').call([]),
        ]).code
        ..lambda = true
        ..returns = $Thing
        ..annotations.add(refer('override'))));

    expect(
      clazz.build(),
      equalsDart(r'''
        class Injector implements App {
          Injector(this._module);

          final Module _module;

          @override
          Thing getThing() => new Thing(_module.get1(), _module.get2());
        }
      '''),
    );

    expect(
      clazz.build(),
      equalsDart(r'''
        class Injector implements _i1.App {
          Injector(this._module);

          final _i2.Module _module;

          @override
          _i3.Thing getThing() => new _i3.Thing(_module.get1(), _module.get2());
        }
      ''', new DartEmitter(new Allocator.simplePrefixing())),
    );
  });
}
