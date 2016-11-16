# Changelog

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
