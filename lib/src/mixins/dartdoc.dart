// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:built_collection/built_collection.dart';

abstract class HasDartDocs {
  /// Dart docs.
  ///
  /// This list may contain both [String]s and [Reference]s, so that elements
  /// may be properly referenced with a prefix.
  BuiltList<Object> get docs;
}

abstract class HasDartDocsBuilder {
  /// Dart docs.
  ///
  /// This list may contain both [String]s and [Reference]s, so that elements
  /// may be properly referenced with a prefix.
  abstract ListBuilder<Object> docs;
}
