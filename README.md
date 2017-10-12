# code_builder

[![pub package](https://img.shields.io/pub/v/code_builder.svg)](https://pub.dartlang.org/packages/code_builder)
[![Build Status](https://travis-ci.org/dart-lang/code_builder.svg)](https://travis-ci.org/dart-lang/code_builder)
[![Coverage Status](https://coveralls.io/repos/github/dart-lang/code_builder/badge.svg?branch=master)](https://coveralls.io/github/dart-lang/code_builder?branch=master)

`code_builder` is a fluent Dart API for generating valid Dart source code.

## Contributing

* Read and help us document common patterns over [at the wiki][wiki].
* Is there a *bug* in the code? [File an issue][issue].

If a feature is missing (the Dart language is always evolving) or you'd like an
easier or better way to do something, consider [opening a pull request][pull].
You can always [file an issue][issue], but generally speaking feature requests
will be on a best-effort basis.

> **NOTE**: Due to the evolving Dart SDK the local `dartfmt` must be used to
> format this repository. You can run it simply from the command-line:

```sh
$ pub run dart_style:format -w .
```

[wiki]: https://github.com/dart-lang/code_builder/wiki
[issue]: https://github.com/dart-lang/code_builder/issues
[pull]: https://github.com/dart-lang/code_builder/pulls

## Usage

`code_builder` has a narrow and user-friendly API.

For example creating a class with a method:

```dart
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

void main() {
  final animal = new Class((b) => b
    ..name = 'Animal'
    ..extend = const Reference('Organism').toType()
    ..methods.add(new Method.returnsVoid((b) => b
      ..name = 'eat'
      ..lambda = true
      ..body = const Code('print(\'Yum\')'))));
  final emitter = const DartEmitter();
  print(new DartFormatter().format('${animal.accept(emitter)}'));
}
```

Outputs:
```dart
class Animal extends Organism {
  void eat() => print('Yum!');
}
```

Have a complicated set of dependencies for your generated code?
`code_builder` supports automatic scoping of your ASTs to automatically
use prefixes to avoid symbol conflicts:

```dart
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

void main() {
  final library = new File((b) => b.body.addAll([
        new Method((b) => b
          ..body = new Code((b) => b.code = '')
          ..name = 'doThing'
          ..returns = const Reference('Thing', 'package:a/a.dart')),
        new Method((b) => b
          ..body = new Code((b) => b..code = '')
          ..name = 'doOther'
          ..returns = const Reference('Other', 'package:b/b.dart')),
      ]));
  final emitter = new DartEmitter(new Allocator.simplePrefixing());
  print(new DartFormatter().format('${library.accept(emitter)}'));
}
```

Outputs:
```dart
import 'package:a/a.dart' as _1;
import 'package:b/b.dart' as _2;

_1.Thing doThing() {}
_2.Other doOther() {}
```