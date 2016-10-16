import 'package:code_builder/code_builder.dart';

/// Meta programming from `dart:core`.
final core = new _DartCore();

// Forcibly namespaces to avoid conflicts when importing this library.
class _DartCore {
  _DartCore();

  /// Reference the core `bool` type.
  final bool = reference('bool', 'dart:core');

  /// Reference the core `identical` function.
  final identical = reference('identical', 'dart:core');

  /// Reference the core `print` function.
  final print = reference('print');

  /// Reference the core `int` type.
  final int = reference('int', 'dart:core');

  /// Reference the core `List` type.
  final List = reference('List', 'dart:core');

  /// Reference the core `Object` type.
  final Object = reference('Object', 'dart:core');

  /// Reference the core `String` type.
  final String = reference('String', 'dart:core');

  /// Reference the core `void` type.
  ///
  /// **NOTE**: As a language limitation, this cannot be named `void`.
  final $void = reference('void');
}
