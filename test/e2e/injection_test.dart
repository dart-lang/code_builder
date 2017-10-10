// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should generate a complex generated file', () {
    // Imports from an existing Dart library.
    final $App = const Reference('App', 'package:app/app.dart');
    final $Module = const Reference('Module', 'package:app/module.dart');
    final $Thing = const Reference('Thing', 'package:app/thing.dart');

    final clazz = new ClassBuilder()
      ..name = 'Injector'
      ..implements.add($App)
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
        ..body = new Code.scope(
            (a) => 'new ${a.allocate($Thing)}(_module.get1(), _module.get2())')
        ..lambda = true
        ..returns = $Thing
        ..annotations
            .add(new Annotation((b) => b..code = const Code('override')))));

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
        class Injector implements _1.App {
          Injector(this._module);

          final _2.Module _module;

          @override
          _3.Thing getThing() => new _3.Thing(_module.get1(), _module.get2());
        }
      ''', new DartEmitter(new Allocator.simplePrefixing())),
    );
  });
}
