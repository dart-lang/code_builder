## 1.0.0-alpha+8

- Fix an import scoping bug in `return` statements and named constructor invocations.

## 1.0.0-alpha+7

- Make use of new analyzer API in preparation for analyzer version 0.30.

## 1.0.0-alpha+6

- `MethodBuilder.closure` emits properly as a top-level function

## 1.0.0-alpha+5

- MethodBuilder with no statements will create an empty block instead of
  a semicolon.

```dart
// main() {}
method('main')
```

- Fix lambdas and closures to not include a trailing semicolon when used
  as an expression.

```dart
 // () => false
 new MethodBuilder.closure(returns: literal(false));
```

## 1.0.0-alpha+4

- Add support for latest `pkg/analyzer`.

## 1.0.0-alpha+3

- BREAKING CHANGE: Added generics support to `TypeBuilder`:

`importFrom` becomes a _named_, not positional argument, and the named
argument `genericTypes` is added (`Iterable<TypeBuilder>`).

```dart
// List<String>
new TypeBuilder('List', genericTypes: [reference('String')])
```

- Added generic support to `ReferenceBuilder`:

```dart
// List<String>
reference('List').toTyped([reference('String')])
```

- Fixed a bug where `ReferenceBuilder.buildAst` was not implemented
- Added `and` and `or` methods to `ExpressionBuilder`:

```dart
// true || false
literal(true).or(literal(false));

// true && false
literal(true).and(literal(false));
```

- Added support for creating closures - `MethodBuilder.closure`:

```dart
// () => true
new MethodBuilder.closure(
  returns: literal(true),
  returnType: lib$core.bool,
)
```

## 1.0.0-alpha+2

- Added `returnVoid` to well, `return;`
- Added support for top-level field assignments:

```dart
new LibraryBuilder()..addMember(literal(false).asConst('foo'))
```

- Added support for specifying a `target` when using `asAssign`:

```dart
// Outputs bank.bar = goldBar
reference('goldBar').asAssign('bar', target: reference('bank'))
```

- Added support for the cascade operator:

```dart
// Outputs foo..doThis()..doThat()
reference('foo').cascade((c) => <ExpressionBuilder> [
  c.invoke('doThis', []),
  c.invoke('doThat', []),
]);
```

- Added support for accessing a property

```dart
// foo.bar
reference('foo').property('bar');
```

## 1.0.0-alpha+1

- Slight updates to confusing documentation.
- Added support for null-aware assignments.
- Added `show` and `hide` support to `ImportBuilder`
- Added `deferred` support to `ImportBuilder`
- Added `ExportBuilder`
- Added `list` and `map` literals that support generic types

## 1.0.0-alpha

- Large refactor that makes the library more feature complete.

## 0.1.1

- Add concept of `Scope` and change `toAst` to support it

Now your entire AST tree can be scoped and import directives
automatically added to a `LibraryBuilder` for you if you use
`LibraryBuilder.scope`.

## 0.1.0

- Initial version
