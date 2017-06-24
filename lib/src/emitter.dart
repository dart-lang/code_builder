// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'specs/class.dart';
import 'specs/code.dart';
import 'specs/method.dart';
import 'specs/reference.dart';
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

  static final Pattern _refReplace = new RegExp(r'{{([^{}]*)}}');

  @override
  visitCode(Code spec, [StringSink output]) {
    output ??= new StringBuffer();
    var code = spec.code;
    if (spec.references.isNotEmpty) {
      code = code.replaceAllMapped(_refReplace, (match) {
        final symbol = spec.references[match.group(1)];
        return visitReference(symbol).toString();
      });
    }
    return output..write(code);
  }

  @override
  visitMethod(Method spec, [StringSink output]) {
    output ??= new StringBuffer();
    if (spec.external) {
      output.write('external ');
    }
    if (spec.returns != null) {
      visitType(spec.returns, output);
      output.write(' ');
    }
    output.write(spec.name);
    visitTypeParameters(spec.types, output);
    output.write('(');
    if (spec.requiredParameters.isNotEmpty) {
      var count = 0;
      for (final p in spec.requiredParameters) {
        count++;
        _visitParameter(p, output);
        if (spec.requiredParameters.length != count ||
            spec.optionalParameters.isNotEmpty) {
          output.write(', ');
        }
      }
    }
    if (spec.optionalParameters.isNotEmpty) {
      final named = spec.optionalParameters.any((p) => p.named);
      if (named) {
        output.write('{');
      } else {
        output.write('[');
      }
      var count = 0;
      for (final p in spec.optionalParameters) {
        count++;
        _visitParameter(p, output, optional: true, named: named);
        if (spec.optionalParameters.length != count) {
          output.write(', ');
        }
      }
      if (named) {
        output.write('}');
      } else {
        output.write(']');
      }
    }
    output.write(')');
    if (spec.body != null) {
      if (spec.lambda) {
        output.write(' => ');
      } else {
        output.write(' { ');
      }
      visitCode(spec.body, output);
      if (spec.lambda) {
        output.write(';');
      } else {
        output.write(' } ');
      }
    } else {
      output.write(';');
    }
    return output;
  }

  // Expose as a first-class visit function only if needed.
  void _visitParameter(
    Parameter spec,
    StringSink output, {
    bool optional: false,
    bool named: false,
  }) {
    if (spec.type != null) {
      visitType(spec.type, output);
      output.write(' ');
    }
    output.write(spec.name);
    if (optional && spec.defaultTo != null) {
      if (spec.named) {
        output.write(': ');
      } else {
        output.write(' = ');
      }
      visitCode(spec.defaultTo, output);
    }
  }

  @override
  visitReference(Reference spec, [StringSink output]) {
    return (output ??= new StringBuffer())..write(spec.symbol);
  }

  @override
  visitType(TypeReference spec, [StringSink output]) {
    output ??= new StringBuffer();
    visitReference(spec, output);
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
