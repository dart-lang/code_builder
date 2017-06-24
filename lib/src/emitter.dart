// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import 'base.dart';
import 'mixins/dartdoc.dart';
import 'specs/class.dart';
import 'specs/enum.dart';
import 'visitor.dart';

String specToDart(Spec spec) => (new DartEmitter()..visitSpec(spec)).toString();

class DartEmitter extends SpecVisitor<Null> {
  final _buffer = new StringBuffer();

  @protected
  @override
  visitDartDoc(DartDocMixin spec) {
    if (spec.dartDoc.isNotEmpty) {
      _buffer.writeln(spec.dartDoc);
    }
  }

  @override
  visitEnum(EnumSpec spec) {
    visitDartDoc(spec);
    _buffer.writeln('enum ${spec.name} {}');
  }

  @override
  visitClass(ClassSpec spec) {
    if (spec.dartDoc.isNotEmpty) {
      _buffer.writeln(spec.dartDoc);
    }
    if (spec.isAbstract) {
      _buffer.write('abstract ');
    }
    _buffer.writeln('class ${spec.name} {}');
  }

  @override
  String toString() => _buffer.toString();
}
