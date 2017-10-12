// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

void main() {
  final library = new File((b) => b.body.addAll([
        new Method((b) => b
          ..body = const Code('')
          ..name = 'doThing'
          ..returns = refer('Thing', 'package:a/a.dart')),
        new Method((b) => b
          ..body = const Code('')
          ..name = 'doOther'
          ..returns = refer('Other', 'package:b/b.dart')),
      ]));
  final emitter = new DartEmitter(new Allocator.simplePrefixing());
  print(new DartFormatter().format('${library.accept(emitter)}'));
}
