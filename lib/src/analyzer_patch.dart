// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/src/generated/java_core.dart';

/// Implements both old-API [PrintWriter] and new-API [StringBuffer].
///
/// This makes it easier to re-use our `pretty_printer` until analyzer updates.
class PrintBuffer implements PrintWriter, StringBuffer {
  final StringBuffer _impl = new StringBuffer();

  @override
  bool get isEmpty => _impl.isEmpty;

  @override
  bool get isNotEmpty => _impl.isNotEmpty;

  @override
  int get length => _impl.length;

  @override
  void clear() {}

  @override
  void newLine() {
    _impl.writeln();
  }

  @override
  void print(x) {
    _impl.write(x);
  }

  @override
  void printf(String fmt, List args) => throw new UnimplementedError();

  @override
  void println(String s) {
    _impl.writeln(s);
  }

  @override
  String toString() => _impl.toString();

  @override
  void write(Object obj) {
    _impl.write(obj);
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    _impl.writeAll(objects);
  }

  @override
  void writeCharCode(int charCode) {
    _impl.writeCharCode(charCode);
  }

  @override
  void writeln([Object obj = ""]) {
    _impl.writeln(obj);
  }
}
