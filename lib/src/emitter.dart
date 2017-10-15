// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import 'allocator.dart';
import 'base.dart';
import 'specs/annotation.dart';
import 'specs/class.dart';
import 'specs/code.dart';
import 'specs/constructor.dart';
import 'specs/directive.dart';
import 'specs/expression.dart';
import 'specs/field.dart';
import 'specs/file.dart';
import 'specs/method.dart';
import 'specs/reference.dart';
import 'specs/type_function.dart';
import 'specs/type_reference.dart';
import 'visitors.dart';

/// Helper method improving on [StringSink.writeAll].
///
/// For every `Spec` in [elements], executing [visit].
///
/// If [elements] is at least 2 elements, inserts [separator] delimiting them.
@visibleForTesting
StringSink visitAll<T>(
  Iterable<T> elements,
  StringSink output,
  void visit(T element), [
  String separator = ', ',
]) {
  // Basically, this whole method is an improvement on
  //   output.writeAll(specs.map((s) => s.accept(visitor));
  //
  // ... which would allocate more StringBuffer(s) for a one-time use.
  if (elements.isEmpty) {
    return output;
  }
  final iterator = elements.iterator..moveNext();
  visit(iterator.current);
  while (iterator.moveNext()) {
    output.write(separator);
    visit(iterator.current);
  }
  return output;
}

class DartEmitter extends Object
    with CodeEmitter, ExpressionEmitter
    implements SpecVisitor<StringSink> {
  @override
  final Allocator allocator;

  /// Creates a new instance of [DartEmitter].
  ///
  /// May specify an [Allocator] to use for symbols, otherwise uses a no-op.
  DartEmitter([this.allocator = Allocator.none]);

  /// Creates a new instance of [DartEmitter] with simple automatic imports.
  factory DartEmitter.scoped() {
    return new DartEmitter(new Allocator.simplePrefixing());
  }

  @override
  visitAnnotation(Annotation spec, [StringSink output]) {
    (output ??= new StringBuffer()).write('@');
    spec.code.accept(this, output);
    output.write(' ');
    return output;
  }

  @override
  visitClass(Class spec, [StringSink output]) {
    output ??= new StringBuffer();
    spec.docs.forEach(output.writeln);
    spec.annotations.forEach((a) => visitAnnotation(a, output));
    if (spec.abstract) {
      output.write('abstract ');
    }
    output.write('class ${spec.name}');
    visitTypeParameters(spec.types.map((r) => r.type), output);
    if (spec.extend != null) {
      output.write(' extends ');
      visitType(spec.extend.type, output);
    }
    if (spec.mixins.isNotEmpty) {
      output
        ..write(' with ')
        ..writeAll(spec.mixins.map<StringSink>((m) => visitType(m.type)), ',');
    }
    if (spec.implements.isNotEmpty) {
      output
        ..write(' implements ')
        ..writeAll(
            spec.implements.map<StringSink>((m) => visitType(m.type)), ',');
    }
    output.write(' {');
    spec.constructors.forEach((c) {
      visitConstructor(c, spec.name, output);
      output.writeln();
    });
    spec.fields.forEach((f) {
      visitField(f, output);
      output.writeln();
    });
    spec.methods.forEach((m) {
      visitMethod(m, output);
      if (m.lambda) {
        output.write(';');
      }
      output.writeln();
    });
    output.writeln(' }');
    return output;
  }

  @override
  visitConstructor(Constructor spec, String clazz, [StringSink output]) {
    output ??= new StringBuffer();
    spec.docs.forEach(output.writeln);
    spec.annotations.forEach((a) => visitAnnotation(a, output));
    if (spec.external) {
      output.write('external ');
    }
    if (spec.factory) {
      output.write('factory ');
    }
    if (spec.constant) {
      output.write('const ');
    }
    output.write(clazz);
    if (spec.name != null) {
      output..write('.')..write(spec.name);
    }
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
    if (spec.initializers.isNotEmpty) {
      output.write(' : ');
      var count = 0;
      for (final initializer in spec.initializers) {
        count++;
        initializer.accept(this, output);
        if (count != spec.initializers.length) {
          output.write(', ');
        }
      }
    }
    if (spec.redirect != null) {
      output.write(' = ');
      visitType(spec.redirect.type, output);
      output.write(';');
    } else if (spec.body != null) {
      if (spec.lambda) {
        output.write(' => ');
        spec.body.accept(this, output);
        output.write(';');
      } else {
        output.write(' { ');
        spec.body.accept(this, output);
        output.write(' }');
      }
    } else {
      output.write(';');
    }
    output.writeln();
    return output;
  }

  @override
  visitDirective(Directive spec, [StringSink output]) {
    output ??= new StringBuffer();
    if (spec.type == DirectiveType.import) {
      output.write('import ');
    } else {
      output.write('export ');
    }
    output.write("'${spec.url}'");
    if (spec.as != null) {
      if (spec.deferred) {
        output.write(' deferred ');
      }
      output.write(' as ${spec.as}');
    }
    if (spec.show.isNotEmpty) {
      output
        ..write(' show ')
        ..writeAll(spec.show, ', ');
    } else if (spec.hide.isNotEmpty) {
      output
        ..write(' hide ')
        ..writeAll(spec.hide, ', ');
    }
    output.write(';');
    return output;
  }

  @override
  visitField(Field spec, [StringSink output]) {
    output ??= new StringBuffer();
    spec.docs.forEach(output.writeln);
    spec.annotations.forEach((a) => visitAnnotation(a, output));
    if (spec.static) {
      output.write('static ');
    }
    switch (spec.modifier) {
      case FieldModifier.var$:
        if (spec.type == null) {
          output.write('var ');
        }
        break;
      case FieldModifier.final$:
        output.write('final ');
        break;
      case FieldModifier.constant:
        output.write('const ');
        break;
    }
    if (spec.type != null) {
      visitType(spec.type.type, output);
      output.write(' ');
    }
    output.write(spec.name);
    if (spec.assignment != null) {
      output.write(' = ');
      spec.assignment.accept(this, output);
    }
    output.writeln(';');
    return output;
  }

  @override
  visitFile(File spec, [StringSink output]) {
    output ??= new StringBuffer();
    // Process the body first in order to prime the allocators.
    final body = new StringBuffer();
    for (final spec in spec.body) {
      body.write(visitSpec(spec));
      if (spec is Method && spec.lambda) {
        output.write(';');
      }
    }
    // TODO: Allow some sort of logical ordering.
    for (final directive in spec.directives) {
      visitDirective(directive, output);
    }
    for (final directive in allocator.imports) {
      visitDirective(directive, output);
    }
    output.write(body);
    return output;
  }

  @override
  visitFunctionType(FunctionType spec, [StringSink output]) {
    output ??= new StringBuffer();
    if (spec.returnType != null) {
      spec.returnType.accept(this, output);
      output.write(' ');
    }
    output.write('Function');
    if (spec.types.isNotEmpty) {
      output.write('<');
      visitAll<Reference>(spec.types, output, (spec) {
        spec.accept(this, output);
      });
      output.write('>');
    }
    output.write('(');
    visitAll<Reference>(spec.requiredParameters, output, (spec) {
      spec.accept(this, output);
    });
    if (spec.optionalParameters.isNotEmpty ||
        spec.namedParameters.isNotEmpty &&
        spec.requiredParameters.isNotEmpty) {
      output.write(', ');
    }
    if (spec.optionalParameters.isNotEmpty) {
      output.write('[');
      visitAll<Reference>(spec.optionalParameters, output, (spec) {
        spec.accept(this, output);
      });
      output.write(']');
    } else if (spec.namedParameters.isNotEmpty) {
      output.write('{');
      visitAll<String>(spec.namedParameters.keys, output, (name) {
        spec.namedParameters[name].accept(this, output);
        output
          ..write(' ')
          ..write(name);
      });
      output.write('}');
    }
    return output..write(')');
  }

  @override
  visitMethod(Method spec, [StringSink output]) {
    output ??= new StringBuffer();
    spec.docs.forEach(output.writeln);
    spec.annotations.forEach((a) => visitAnnotation(a, output));
    if (spec.external) {
      output.write('external ');
    }
    if (spec.static) {
      output.write('static ');
    }
    if (spec.returns != null) {
      visitType(spec.returns.type, output);
      output.write(' ');
    }
    if (spec.type == MethodType.getter) {
      output..write('get ')..write(spec.name);
    } else {
      if (spec.type == MethodType.setter) {
        output.write('set ');
      }
      if (spec.name != null) {
        output.write(spec.name);
      }
      visitTypeParameters(spec.types.map((r) => r.type), output);
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
    }
    if (spec.body != null) {
      if (spec.modifier != null) {
        switch (spec.modifier) {
          case MethodModifier.async:
            output.write(' async ');
            break;
          case MethodModifier.asyncStar:
            output.write(' async* ');
            break;
          case MethodModifier.syncStar:
            output.write(' sync* ');
            break;
        }
      }
      if (spec.lambda) {
        output.write(' => ');
      } else {
        output.write(' { ');
      }
      spec.body.accept(this, output);
      if (!spec.lambda) {
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
    spec.docs.forEach(output.writeln);
    spec.annotations.forEach((a) => visitAnnotation(a, output));
    if (spec.type != null) {
      visitType(spec.type.type, output);
      output.write(' ');
    }
    if (spec.toThis) {
      output.write('this.');
    }
    output.write(spec.name);
    if (optional && spec.defaultTo != null) {
      if (spec.named) {
        output.write(': ');
      } else {
        output.write(' = ');
      }
      spec.defaultTo.accept(this, output);
    }
  }

  @override
  visitReference(Reference spec, [StringSink output]) {
    return (output ??= new StringBuffer())..write(allocator.allocate(spec));
  }

  @override
  visitSpec(Spec spec, [StringSink output]) => spec.accept(this, output);

  @override
  visitType(TypeReference spec, [StringSink output]) {
    output ??= new StringBuffer();
    visitReference(spec, output);
    if (spec.bound != null) {
      output.write(' extends ');
      visitType(spec.bound.type, output);
    }
    visitTypeParameters(spec.types.map((r) => r.type), output);
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
