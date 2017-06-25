// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.code;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Code
// **************************************************************************

class _$Code extends Code {
  @override
  final String code;
  @override
  final BuiltMap<String, LazySpec> specs;

  factory _$Code([void updates(CodeBuilder b)]) =>
      (new CodeBuilder()..update(updates)).build() as _$Code;

  _$Code._({this.code, this.specs}) : super._() {
    if (code == null) throw new ArgumentError.notNull('code');
    if (specs == null) throw new ArgumentError.notNull('specs');
  }

  @override
  Code rebuild(void updates(CodeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$CodeBuilder toBuilder() => new _$CodeBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Code) return false;
    return code == other.code && specs == other.specs;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, code.hashCode), specs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Code')
          ..add('code', code)
          ..add('specs', specs))
        .toString();
  }
}

class _$CodeBuilder extends CodeBuilder {
  _$Code _$v;

  @override
  String get code {
    _$this;
    return super.code;
  }

  @override
  set code(String code) {
    _$this;
    super.code = code;
  }

  @override
  MapBuilder<String, LazySpec> get specs {
    _$this;
    return super.specs ??= new MapBuilder<String, LazySpec>();
  }

  @override
  set specs(MapBuilder<String, LazySpec> specs) {
    _$this;
    super.specs = specs;
  }

  _$CodeBuilder() : super._();

  CodeBuilder get _$this {
    if (_$v != null) {
      super.code = _$v.code;
      super.specs = _$v.specs?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Code other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Code;
  }

  @override
  void update(void updates(CodeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Code build() {
    final result = _$v ?? new _$Code._(code: code, specs: specs?.build());
    replace(result);
    return result;
  }
}
