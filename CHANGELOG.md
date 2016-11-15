# Changelog

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
