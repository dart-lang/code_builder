#!/usr/bin/env dart --checked
// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build_runner/build_runner.dart';
import 'package:build_config/build_config.dart';
import 'package:built_value_generator/built_value_generator.dart';
import 'package:source_gen/source_gen.dart';

Future main(List<String> args) => run(args, _actions);

final _actions = <BuilderApplication>[
  applyToRoot(
    new PartBuilder([
      const BuiltValueGenerator(),
    ]),
    generateFor: const InputSet(include: const ['lib/src/specs/**.dart']),
  )
];
