// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import 'base.dart';
import 'mixins/dartdoc.dart';
import 'specs/class.dart';
import 'specs/enum.dart';

abstract class SpecVisitor<R> {
  const SpecVisitor();

  R visitClass(ClassSpec spec) => null;

  @protected
  R visitDartDoc(DartDocMixin spec) => null;

  R visitEnum(EnumSpec spec) => null;

  R visitSpec(Spec spec) => spec.accept(this);
}
