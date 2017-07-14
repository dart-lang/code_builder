// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

void main() {
  final library = new File((b) => b.body.addAll([
        new Method((b) => b
          ..body = new Code((b) => b.code = '')
          ..name = 'doThing'
          ..returns = const Reference('Thing', 'package:a/a.dart')),
        new Method((b) => b
          ..body = new Code((b) => b..code = '')
          ..name = 'doOther'
          ..returns = const Reference('Other', 'package:b/b.dart')),
      ]));
  final emitter = new DartEmitter(new Allocator.simplePrefixing());
  print(new DartFormatter().format('${library.accept(emitter)}'));
}
