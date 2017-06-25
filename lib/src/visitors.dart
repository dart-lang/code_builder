// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'base.dart';
import 'specs/class.dart';
import 'specs/code.dart';
import 'specs/constructor.dart';
import 'specs/method.dart';
import 'specs/reference.dart';
import 'specs/type_reference.dart';

abstract class SpecVisitor<T> {
  const SpecVisitor._();

  T visitClass(Class spec);

  T visitCode(Code spec);

  T visitConstructor(Constructor spec, String clazz);

  T visitMethod(Method spec);

  T visitReference(Reference spec);

  T visitSpec(Spec spec);

  T visitType(TypeReference spec);

  T visitTypeParameters(Iterable<TypeReference> specs);
}

class SimpleSpecVisitor<T> implements SpecVisitor<T> {
  const SimpleSpecVisitor();

  @override
  T visitClass(Class spec) => null;

  @override
  T visitConstructor(Constructor spec, String clazz) => null;

  @override
  T visitCode(Code spec) => null;

  @override
  T visitMethod(Method spec) => null;

  @override
  T visitReference(Reference spec) => null;

  @override
  T visitSpec(Spec spec) => spec.accept(this);

  @override
  T visitType(TypeReference spec) => null;

  @override
  T visitTypeParameters(Iterable<TypeReference> specs) => null;
}

class RecursiveSpecVisitor<T> extends SimpleSpecVisitor<T> {
  const RecursiveSpecVisitor();
}

class GeneralizingSpecVisitor<T> extends RecursiveSpecVisitor<T> {
  const GeneralizingSpecVisitor();
}
