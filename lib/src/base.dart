// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'visitor.dart';

abstract class Spec {
  const Spec();

  R accept<R>(SpecVisitor<R> visitor);
}

abstract class SpecBuilder<T extends Spec> {
  const SpecBuilder();

  T build();
}
