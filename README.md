# code_builder

[![pub package](https://img.shields.io/pub/v/code_builder.svg)](https://pub.dartlang.org/packages/code_builder)
[![Build Status](https://travis-ci.org/dart-lang/code_builder.svg)](https://travis-ci.org/dart-lang/code_builder)
[![Coverage Status](https://coveralls.io/repos/github/dart-lang/code_builder/badge.svg?branch=master)](https://coveralls.io/github/dart-lang/code_builder?branch=master)

`code_builder` is a fluent Dart API for generating valid Dart source code.

Code generation was traditionally done through a series of 
package-specific string concatenations which usually results in messy
and sometimes invalid Dart code that is not easily readable and is very
difficult to refactor.

`code_builder` uses the [analyzer](analyzer) package to create real Dart
language ASTs, which, while not guaranteed to be correct, always follows
the analyzer's own understood format.

[analyzer]: https://pub.dartlang.org/packages/analyzer

## Contributing

* Read and help us document common patterns over [at the wiki][wiki].
* Is there a *bug* in the code? [File an issue][issue].

If a feature is missing (the Dart language is always evolving) or you'd like an
easier or better way to do something, consider [opening a pull request][pull].
You can always [file an issue][issue], but generally speaking feature requests
will be on a best-effort basis.

[wiki]: https://github.com/dart-lang/code_builder/wiki
[issue]: https://github.com/dart-lang/code_builder/issues
[pull]: https://github.com/dart-lang/code_builder/pulls

## Usage

Code builder has a narrow and user-friendly API.

For example creating a class with a method:

```dart
var base = reference('Organism');
var clazz = new ClassBuilder('Animal', asExtends: base);
clazz.addMethod(
  new MethodBuilder.returnVoid(
    'eat',
    returns: reference('print').call([literal('Yum')]),
  ),
);
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
var lib = new LibraryBuilder.scope()
  ..addMembers([
    new MethodBuilder(
      'doThing',
      returnType: reference('Thing', 'package:thing/thing.dart'),
    ),
    new MethodBuilder(
      'doOtherThing',
      returnType: reference('Thing', 'package:thing/alternative.dart'),
    ),
  ]);
```

Outputs:
```dart
import 'package:thing/thing.dart' as _i1;
import 'package:thing/alternative.dart' as _i2;

_i1.Thing doThing() {}
_i2.Thing doOtherThing() {}
```
