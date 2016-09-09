# code_builder

Code builder is a fluent Dart API for generating valid Dart source code.

Generally speaking, code generation usually is done through a series of
string concatenation which results in messy and sometimes invalid code
that is not easily readable.

Code builder uses the [analyzer](analyzer) package to create real Dart
language ASTs, which, while not guaranteed to be correct, always follows
the analyzer's own understood format.

[analyzer]: https://pub.dartlang.org/packages/analyzer

Code builder also adds a more narrow and user-friendly API. For example
creating a class with a method is an easy affair:

```dart
new ClassBuilder('Animal', extends: 'Organism')
  ..addMethod(new MethodBuilder.returnVoid('eat')
    ..setExpression(new ExpressionBuilder.invoke('print',
      positional: [new LiteralString('Yum!')])));
```

Outputs:
```dart
class Animal extends Organism {
  void eat() => print('Yum!');
}
```

This package is in development and APIs are subject to frequent change.
