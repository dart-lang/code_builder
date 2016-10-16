import 'package:code_builder/code_builder.dart';

/// Meta programming from `dart:core`.
final core = new _DartCore();

class _DartCore {
  _DartCore();

  /// Reference the core `int` type.
  final Int = reference('int', 'dart:core');

  /// Reference the core `List` type.
  final List = reference('List', 'dart:core');

  /// Reference the core `Object` type.
  final Object = reference('Object', 'dart:core');

  /// Reference the core `String` type.
  final String = reference('String', 'dart:core');

  /// Reference the core `void` type.
  final Void = reference('void');
}
