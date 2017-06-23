// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'base.dart';
import 'specs/class.dart';
import 'visitor.dart';

String specToDart(Spec spec) => (new DartEmitter()..visitSpec(spec)).toString();

class DartEmitter extends SpecVisitor<Null> {
  final _buffer = new StringBuffer();

  @override
  visitClassSpec(ClassSpec spec) {
    _buffer.writeln('class ${spec.name} {}');
  }

  @override
  String toString() => _buffer.toString();
}
