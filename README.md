# code_builder

[![Pub package](https://img.shields.io/pub/v/code_builder.svg)](https://pub.dartlang.org/packages/code_builder)
[![Build status](https://travis-ci.org/dart-lang/code_builder.svg)](https://travis-ci.org/dart-lang/code_builder)
[![Latest docs](https://img.shields.io/badge/dartdocs-latest-blue.svg)](https://www.dartdocs.org/documentation/code_builder/latest)
[![Gitter chat](https://badges.gitter.im/dart-lang/source_gen.svg)](https://gitter.im/dart-lang/source_gen)

`code_builder` is a fluent Dart API for generating valid Dart source code.

## Usage

`code_builder` has a narrow and user-friendly API.

See the `example` and `test` folders for additional examples.

For example creating a class with a method:

```dart
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

void main() {
  final animal = new Class((b) => b
    ..name = 'Animal'
    ..extend = refer('Organism')
    ..methods.add(new Method.returnsVoid((b) => b
      ..name = 'eat'
      ..body = const Code('print(\'Yum\')'))));
  final emitter = new DartEmitter();
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
  final library = new Library((b) => b.body.addAll([
        new Method((b) => b
          ..body = const Code('')
          ..name = 'doThing'
          ..returns = refer('Thing', 'package:a/a.dart')),
        new Method((b) => b
          ..body = const Code('')
          ..name = 'doOther'
          ..returns = refer('Other', 'package:b/b.dart')),
      ]));
  final emitter = new DartEmitter(new Allocator.simplePrefixing());
  print(new DartFormatter().format('${library.accept(emitter)}'));
}
```

Outputs:
```dart
import 'package:a/a.dart' as _i1;
import 'package:b/b.dart' as _i2;

_i1.Thing doThing() {}
_i2.Other doOther() {}
```

## Contributing

* Read and help us document common patterns over [at the wiki][wiki].
* Is there a *bug* in the code? [File an issue][issue].

If a feature is missing (the Dart language is always evolving) or you'd like an
easier or better way to do something, consider [opening a pull request][pull].
You can always [file an issue][issue], but generally speaking feature requests
will be on a best-effort basis.

> **NOTE**: Due to the evolving Dart SDK the local `dartfmt` must be used to
> format this repository. You can run it simply from the command-line:
>
> ```sh
> $ pub run dart_style:format -w .
> ```

[wiki]: https://github.com/dart-lang/code_builder/wiki
[issue]: https://github.com/dart-lang/code_builder/issues
[pull]: https://github.com/dart-lang/code_builder/pulls

### Updating generated (`.g.dart`) files

Use [`build_runner`][build_runner]:

```bash
$ pub run build_runner build --delete-conflicting-outputs
```

[build_runner]: https://pub.dartlang.org/packages/build_runner
