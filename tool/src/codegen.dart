// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:build_runner/build_runner.dart';
import 'package:built_value_generator/built_value_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Returns the [BuildAction] for both `build.dart` and `watch.dart`.
BuildAction buildAction() {
  return new BuildAction(
    new PartBuilder([
      const BuiltValueGenerator(),
    ]),
    'code_builder',
    inputs: const ['lib/src/specs/**.dart'],
  );
}
