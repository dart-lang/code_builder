// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_reference.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TypeReference extends TypeReference {
  @override
  final String symbol;
  @override
  final String? url;
  @override
  final Reference? bound;
  @override
  final BuiltList<Reference> types;
  @override
  final bool? isNullable;

  factory _$TypeReference([void Function(TypeReferenceBuilder)? updates]) =>
      (new TypeReferenceBuilder()..update(updates)).build() as _$TypeReference;

  _$TypeReference._(
      {required this.symbol,
      this.url,
      this.bound,
      required this.types,
      this.isNullable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(symbol, r'TypeReference', 'symbol');
    BuiltValueNullFieldError.checkNotNull(types, r'TypeReference', 'types');
  }

  @override
  TypeReference rebuild(void Function(TypeReferenceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$TypeReferenceBuilder toBuilder() =>
      new _$TypeReferenceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypeReference &&
        symbol == other.symbol &&
        url == other.url &&
        bound == other.bound &&
        types == other.types &&
        isNullable == other.isNullable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, bound.hashCode);
    _$hash = $jc(_$hash, types.hashCode);
    _$hash = $jc(_$hash, isNullable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TypeReference')
          ..add('symbol', symbol)
          ..add('url', url)
          ..add('bound', bound)
          ..add('types', types)
          ..add('isNullable', isNullable))
        .toString();
  }
}

class _$TypeReferenceBuilder extends TypeReferenceBuilder {
  _$TypeReference? _$v;

  @override
  String? get symbol {
    _$this;
    return super.symbol;
  }

  @override
  set symbol(String? symbol) {
    _$this;
    super.symbol = symbol;
  }

  @override
  String? get url {
    _$this;
    return super.url;
  }

  @override
  set url(String? url) {
    _$this;
    super.url = url;
  }

  @override
  Reference? get bound {
    _$this;
    return super.bound;
  }

  @override
  set bound(Reference? bound) {
    _$this;
    super.bound = bound;
  }

  @override
  ListBuilder<Reference> get types {
    _$this;
    return super.types;
  }

  @override
  set types(ListBuilder<Reference> types) {
    _$this;
    super.types = types;
  }

  @override
  bool? get isNullable {
    _$this;
    return super.isNullable;
  }

  @override
  set isNullable(bool? isNullable) {
    _$this;
    super.isNullable = isNullable;
  }

  _$TypeReferenceBuilder() : super._();

  TypeReferenceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.symbol = $v.symbol;
      super.url = $v.url;
      super.bound = $v.bound;
      super.types = $v.types.toBuilder();
      super.isNullable = $v.isNullable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypeReference other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TypeReference;
  }

  @override
  void update(void Function(TypeReferenceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TypeReference build() => _build();

  _$TypeReference _build() {
    _$TypeReference _$result;
    try {
      _$result = _$v ??
          new _$TypeReference._(
              symbol: BuiltValueNullFieldError.checkNotNull(
                  symbol, r'TypeReference', 'symbol'),
              url: url,
              bound: bound,
              types: types.build(),
              isNullable: isNullable);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'types';
        types.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TypeReference', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
