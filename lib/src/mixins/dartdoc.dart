// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../base.dart';
import '../utils/assert.dart';

abstract class DartDocMixin implements Spec {
  String get dartDoc;
}

abstract class DartDocBuilderMixin implements SpecBuilder<DartDocMixin> {
  @protected
  final dartDoc = new StringBuffer();

  void addDartDoc(String text) => dartDoc.writeln(startsWith(text, '///'));
}
