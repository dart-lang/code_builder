// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

void main() {
  final animal = new Class((b) => b
    ..name = 'Animal'
    ..extend = const Reference('Organism')
    ..methods.add(new Method.returnsVoid((b) => b
      ..name = 'eat'
      ..lambda = true
      ..body = const Code('print(\'Yum\')'))));
  final emitter = new DartEmitter();
  print(new DartFormatter().format('${animal.accept(emitter)}'));
}
