// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

String _format(String source) {
  final formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  );

  try {
    return formatter.format(source);
  } on FormatterException catch (_) {
    return formatter.formatStatement(source);
  }
}

/// Should be invoked in `main()` of every test in `test/**_test.dart`.
void useDartfmt() => EqualsDart.format = _format;
