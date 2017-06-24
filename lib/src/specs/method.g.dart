// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.method;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Method
// **************************************************************************

class _$Method extends Method {
  @override
  final BuiltList<String> docs;
  @override
  final BuiltList<TypeReference> types;
  @override
  final Code body;
  @override
  final bool external;
  @override
  final String name;
  @override
  final TypeReference returns;

  factory _$Method([void updates(MethodBuilder b)]) =>
      (new MethodBuilder()..update(updates)).build() as _$Method;

  _$Method._(
      {this.docs,
      this.types,
      this.body,
      this.external,
      this.name,
      this.returns})
      : super._() {
    if (docs == null) throw new ArgumentError.notNull('docs');
    if (types == null) throw new ArgumentError.notNull('types');
    if (external == null) throw new ArgumentError.notNull('external');
    if (name == null) throw new ArgumentError.notNull('name');
  }

  @override
  Method rebuild(void updates(MethodBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$MethodBuilder toBuilder() => new _$MethodBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Method) return false;
    return docs == other.docs &&
        types == other.types &&
        body == other.body &&
        external == other.external &&
        name == other.name &&
        returns == other.returns;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, docs.hashCode), types.hashCode), body.hashCode),
                external.hashCode),
            name.hashCode),
        returns.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Method')
          ..add('docs', docs)
          ..add('types', types)
          ..add('body', body)
          ..add('external', external)
          ..add('name', name)
          ..add('returns', returns))
        .toString();
  }
}

class _$MethodBuilder extends MethodBuilder {
  _$Method _$v;

  @override
  ListBuilder<String> get docs {
    _$this;
    return super.docs ??= new ListBuilder<String>();
  }

  @override
  set docs(ListBuilder<String> docs) {
    _$this;
    super.docs = docs;
  }

  @override
  ListBuilder<TypeReference> get types {
    _$this;
    return super.types ??= new ListBuilder<TypeReference>();
  }

  @override
  set types(ListBuilder<TypeReference> types) {
    _$this;
    super.types = types;
  }

  @override
  Code get body {
    _$this;
    return super.body;
  }

  @override
  set body(Code body) {
    _$this;
    super.body = body;
  }

  @override
  bool get external {
    _$this;
    return super.external;
  }

  @override
  set external(bool external) {
    _$this;
    super.external = external;
  }

  @override
  String get name {
    _$this;
    return super.name;
  }

  @override
  set name(String name) {
    _$this;
    super.name = name;
  }

  @override
  TypeReference get returns {
    _$this;
    return super.returns;
  }

  @override
  set returns(TypeReference returns) {
    _$this;
    super.returns = returns;
  }

  _$MethodBuilder() : super._();

  MethodBuilder get _$this {
    if (_$v != null) {
      super.docs = _$v.docs?.toBuilder();
      super.types = _$v.types?.toBuilder();
      super.body = _$v.body;
      super.external = _$v.external;
      super.name = _$v.name;
      super.returns = _$v.returns;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Method other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Method;
  }

  @override
  void update(void updates(MethodBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Method build() {
    final result = _$v ??
        new _$Method._(
            docs: docs?.build(),
            types: types?.build(),
            body: body,
            external: external,
            name: name,
            returns: returns);
    replace(result);
    return result;
  }
}
