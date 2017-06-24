// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'specs/class.dart';
import 'specs/type_reference.dart';
import 'visitors.dart';

class DartEmitter extends GeneralizingSpecVisitor<StringSink> {
  const DartEmitter();

  @override
  visitClass(Class spec, [StringSink output]) {
    output ??= new StringBuffer();
    spec.docs.forEach(output.writeln);
    if (spec.abstract) {
      output.write('abstract ');
    }
    output.write('class ${spec.name}');
    visitTypeParameters(spec.types, output);
    if (spec.extend != null) {
      output.write(' extends ');
      visitType(spec.extend, output);
    }
    if (spec.mixins.isNotEmpty) {
      output
        ..write(' with ')
        ..writeAll(spec.mixins.map<StringSink>(visitType), ',');
    }
    if (spec.implements.isNotEmpty) {
      output
        ..write(' implements ')
        ..writeAll(spec.implements.map<StringSink>(visitType), ',');
    }
    output.write(' {}');
    return output;
  }

  @override
  visitType(TypeReference spec, [StringSink output]) {
    (output ??= new StringBuffer()).write(spec.symbol);
    if (spec.bound != null) {
      output.write(' extends ');
      visitType(spec.bound, output);
    }
    visitTypeParameters(spec.types, output);
    return output;
  }

  @override
  visitTypeParameters(Iterable<TypeReference> specs, [StringSink output]) {
    output ??= new StringBuffer();
    if (specs.isNotEmpty) {
      output
        ..write('<')
        ..writeAll(specs.map<StringSink>(visitType), ',')
        ..write('>');
    }
    return output;
  }
}
