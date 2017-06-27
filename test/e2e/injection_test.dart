// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should generate a complex generated file', () {
    // Imports from an existing Dart library.
    final $App = const Reference('App', 'package:app/app.dart');
    final $Module = const Reference('Module', 'package:app/app.dart');
    final $Thing = const Reference('Thing', 'package:app/app.dart');

    final clazz = new ClassBuilder()
      ..name = 'Injector'
      ..implements.add($App.toType())
      ..fields.add(new Field((b) => b
        ..modifier = FieldModifier.final$
        ..name = '_module'
        ..type = $Module.toType()))
      ..constructors.add(new Constructor((b) => b
        ..requiredParameters.add(new Parameter((b) => b
          ..name = '_module'
          ..toThis = true))))
      ..methods.add(new Method((b) => b
        ..name = 'getThing'
        ..body = new Code((b) => b
          ..code = 'new {{ThingRef}}(_module.get1(), _module.get2())'
          ..specs['ThingRef'] = () => $Thing)
        ..lambda = true
        ..returns = $Thing.toType()
        ..annotations.add(new Annotation(
            (b) => b..code = new Code((b) => b.code = 'override')))));

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
  });
}
