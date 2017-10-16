// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.type_reference;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$TypeReference extends TypeReference {
  @override
  final String symbol;
  @override
  final String url;
  @override
  final Reference bound;
  @override
  final BuiltList<Reference> types;

  factory _$TypeReference([void updates(TypeReferenceBuilder b)]) =>
      (new TypeReferenceBuilder()..update(updates)).build() as _$TypeReference;

  _$TypeReference._({this.symbol, this.url, this.bound, this.types})
      : super._() {
    if (symbol == null) throw new ArgumentError.notNull('symbol');
    if (types == null) throw new ArgumentError.notNull('types');
  }

  @override
  TypeReference rebuild(void updates(TypeReferenceBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$TypeReferenceBuilder toBuilder() =>
      new _$TypeReferenceBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! TypeReference) return false;
    return symbol == other.symbol &&
        url == other.url &&
        bound == other.bound &&
        types == other.types;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, symbol.hashCode), url.hashCode), bound.hashCode),
        types.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TypeReference')
          ..add('symbol', symbol)
          ..add('url', url)
          ..add('bound', bound)
          ..add('types', types))
        .toString();
  }
}

class _$TypeReferenceBuilder extends TypeReferenceBuilder {
  _$TypeReference _$v;

  @override
  String get symbol {
    _$this;
    return super.symbol;
  }

  @override
  set symbol(String symbol) {
    _$this;
    super.symbol = symbol;
  }

  @override
  String get url {
    _$this;
    return super.url;
  }

  @override
  set url(String url) {
    _$this;
    super.url = url;
  }

  @override
  Reference get bound {
    _$this;
    return super.bound;
  }

  @override
  set bound(Reference bound) {
    _$this;
    super.bound = bound;
  }

  @override
  ListBuilder<Reference> get types {
    _$this;
    return super.types ??= new ListBuilder<Reference>();
  }

  @override
  set types(ListBuilder<Reference> types) {
    _$this;
    super.types = types;
  }

  _$TypeReferenceBuilder() : super._();

  TypeReferenceBuilder get _$this {
    if (_$v != null) {
      super.symbol = _$v.symbol;
      super.url = _$v.url;
      super.bound = _$v.bound;
      super.types = _$v.types?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypeReference other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$TypeReference;
  }

  @override
  void update(void updates(TypeReferenceBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TypeReference build() {
    final _$result = _$v ??
        new _$TypeReference._(
            symbol: symbol, url: url, bound: bound, types: types?.build());
    replace(_$result);
    return _$result;
  }
}
