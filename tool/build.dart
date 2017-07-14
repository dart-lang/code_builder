// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build_runner/build_runner.dart';
import 'package:built_value_generator/built_value_generator.dart';
import 'package:source_gen/source_gen.dart';

Future<Null> main() async {
  await build(
    new PhaseGroup.singleAction(
      new GeneratorBuilder([
        new BuiltValueGenerator(),
      ]),
      new InputSet('code_builder', const ['lib/src/specs/**.dart']),
    ),
    deleteFilesByDefault: true,
  );
}
