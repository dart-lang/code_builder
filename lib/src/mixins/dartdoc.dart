// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_collection/built_collection.dart';

abstract mixin class HasDartDocs {
  /// Dart docs.
  BuiltList<String> get docs;
}

abstract mixin class HasDartDocsBuilder {
  /// Dart docs.
  abstract ListBuilder<String> docs;
}
