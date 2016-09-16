part of code_builder;

/// Determines an [Identifier] deppending on where it appears.
///
/// __Example use__:
///     void useContext(Scope scope) {
///       // Prints Identifier "i1.Foo"
///       print(scope.getIdentifier('Foo', 'package:foo/foo.dart');
///
///       // Prints Identifier "i1.Bar"
///       print(scope.getIdentifier('Bar', 'package:foo/foo.dart');
///
///       // Prints Identifier "i2.Baz"
///       print(scope.getIdentifier('Baz', 'package:bar/bar.dart');
///     }
abstract class Scope {
  /// Create a default scope context.
  ///
  /// Actual implementation is _not_ guaranteed, only that all import prefixes
  /// will be unique in a given scope (actual implementation may be naive).
  factory Scope() = _IncrementingScope;

  /// Create a context that just de-duplicates imports (no scoping).
  factory Scope.dedupe() = _DeduplicatingScope;

  /// Create a context that does nothing.
  const factory Scope.identity() = _IdentityScope;

  /// Given a [symbol] and its known [importUri], return an [Identifier].
  Identifier getIdentifier(String symbol, String importUri);

  /// Returns a list of all imports needed to resolve identifiers.
  Iterable<ImportBuilder> getImports();
}

class _DeduplicatingScope implements Scope {
  final Set<String> _imports = new Set<String>();

  @override
  Identifier getIdentifier(String symbol, String import) {
    _imports.add(import);
    return _stringId(symbol);
  }

  @override
  Iterable<ImportBuilder> getImports() {
    return _imports.map/*<ImportBuilder*/((i) => new ImportBuilder(i));
  }
}

class _IdentityScope implements Scope {
  const _IdentityScope();

  @override
  Identifier getIdentifier(String symbol, _) => _stringId(symbol);

  @override
  Iterable<ImportBuilder> getImports() => const [];
}

class _IncrementingScope implements Scope {
  final Map<String, int> _imports = <String, int>{};

  int _counter = 0;

  @override
  Identifier getIdentifier(String symbol, String import) {
    var newId = _imports.putIfAbsent(import, () => ++_counter);
    return new PrefixedIdentifier(_stringId('_i$newId'),
        new Token(TokenType.PERIOD, 0), _stringId(symbol));
  }

  @override
  Iterable<ImportBuilder> getImports() {
    return _imports.keys.map/*<ImportBuilder*/(
        (i) => new ImportBuilder(i, as: '_i${_imports[i]}'));
  }
}
