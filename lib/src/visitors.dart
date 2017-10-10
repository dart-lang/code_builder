// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'base.dart';
import 'specs/annotation.dart';
import 'specs/class.dart';
import 'specs/code.dart';
import 'specs/constructor.dart';
import 'specs/directive.dart';
import 'specs/field.dart';
import 'specs/file.dart';
import 'specs/method.dart';
import 'specs/reference.dart';
import 'specs/type_reference.dart';

abstract class SpecVisitor<T> {
  const SpecVisitor._();

  T visitAnnotation(Annotation spec);

  T visitClass(Class spec);

  T visitCode(Code spec);

  T visitConstructor(Constructor spec, String clazz);

  T visitDirective(Directive spec);

  T visitField(Field spec);

  T visitFile(File spec);

  T visitMethod(Method spec);

  T visitReference(Reference spec);

  T visitSpec(Spec spec);

  T visitType(TypeReference spec);

  T visitTypeParameters(Iterable<TypeReference> specs);
}
