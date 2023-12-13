# Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

dart run build_runner generate-build-script
dart compile kernel .dart_tool/build/entrypoint/build.dart
dart .dart_tool/build/entrypoint/build.dill build --delete-conflicting-outputs
