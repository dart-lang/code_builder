// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'base.dart';
import 'specs/class.dart';

abstract class SpecVisitor<T> {
  const SpecVisitor._();

  T visitClass(Class spec);

  T visitSpec(Spec spec);
}

class SimpleSpecVisitor<T> implements SpecVisitor<T> {
  const SimpleSpecVisitor();

  @override
  T visitClass(Class spec) => null;

  @override
  T visitSpec(Spec spec) => spec.accept(this);
}

class RecursiveSpecVisitor<T> extends SimpleSpecVisitor<T> {
  const RecursiveSpecVisitor();
}

class GeneralizingSpecVisitor<T> extends RecursiveSpecVisitor<T> {
  const GeneralizingSpecVisitor();
}
