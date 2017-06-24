// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'specs/class.dart';
import 'visitors.dart';

class DartEmitter extends GeneralizingSpecVisitor<String> {
  const DartEmitter();

  @override
  visitClass(Class spec, [StringBuffer output]) {
    output ??= new StringBuffer();
    spec.docs.forEach(output.writeln);
    if (spec.abstract) {
      output.write('abstract ');
    }
    output.write('class ${spec.name} {}');
    return output.toString();
  }
}
