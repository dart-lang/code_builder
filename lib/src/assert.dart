// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Returns if `assert(...)` is enabled, i.e. Dart is running in developer mode.
///
/// Certain checks may be disabled if not running in developer mode, with the
/// assumption the client will be testing their code with assertions enabled.
bool assertionsEnabled() {
  var enabled = false;
  assert(enabled = true);
  return enabled;
}

/// Returns [input], checking it for being `null` when [assertionsEnabled].
///
/// Example use:
/// ```dart
/// Future<String> fetchUrl(String url) {
///   return _fetchUrl(notNull(url));
/// }
/// ```
T notNull<T>(T input, [String name]) {
  if (assertionsEnabled()) {
    if (input == null) {
      throw new ArgumentError.notNull(name);
    }
  }
  return input;
}
