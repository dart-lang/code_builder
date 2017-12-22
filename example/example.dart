// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

final _dartfmt = new DartFormatter();

void main() {
  print('animalClass():\n${'=' * 40}\n${animalClass()}');
  print('scopedLibrary():\n${'=' * 40}\n${scopedLibrary()}');
}

/// Outputs:
///
/// ```dart
/// class Animal extends Organism {
///   void eat() => print('Yum!');
/// }
/// ```
String animalClass() {
  final animal = new Class((b) => b
    ..name = 'Animal'
    ..extend = refer('Organism')
    ..methods.add(new Method.returnsVoid((b) => b
      ..name = 'eat'
      ..body = refer('print').call([literalString('Yum!')]).code)));
  return _dartfmt.format('${animal.accept(new DartEmitter())}');
}

/// Outputs:
///
/// ```dart
/// import 'package:a/a.dart' as _i1;
/// import 'package:b/b.dart' as _i2;
///
/// _i1.Thing doThing() {}
/// _i2.Other doOther() {}
/// ```
String scopedLibrary() {
  final methods = [
    new Method((b) => b
      ..body = const Code('')
      ..name = 'doThing'
      ..returns = refer('Thing', 'package:a/a.dart')),
    new Method((b) => b
      ..body = const Code('')
      ..name = 'doOther'
      ..returns = refer('Other', 'package:b/b.dart')),
  ];
  final library = new Library((b) => b.body.addAll(methods));
  return _dartfmt.format('${library.accept(new DartEmitter.scoped())}');
}
