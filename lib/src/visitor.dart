// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'base.dart';

import 'specs/class.dart';

abstract class SpecVisitor<R> {
  const SpecVisitor();

  R visitClassSpec(ClassSpec spec) => null;

  R visitSpec(Spec spec) => spec.accept(this);
}
