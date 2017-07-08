// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.directive;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Directive
// **************************************************************************

class _$Directive extends Directive {
  @override
  final String as;
  @override
  final String url;
  @override
  final DirectiveType type;

  factory _$Directive([void updates(DirectiveBuilder b)]) =>
      (new DirectiveBuilder()..update(updates)).build() as _$Directive;

  _$Directive._({this.as, this.url, this.type}) : super._() {
    if (url == null) throw new ArgumentError.notNull('url');
    if (type == null) throw new ArgumentError.notNull('type');
  }

  @override
  Directive rebuild(void updates(DirectiveBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$DirectiveBuilder toBuilder() => new _$DirectiveBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Directive) return false;
    return as == other.as && url == other.url && type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, as.hashCode), url.hashCode), type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Directive')
          ..add('as', as)
          ..add('url', url)
          ..add('type', type))
        .toString();
  }
}

class _$DirectiveBuilder extends DirectiveBuilder {
  _$Directive _$v;

  @override
  String get as {
    _$this;
    return super.as;
  }

  @override
  set as(String as) {
    _$this;
    super.as = as;
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
  DirectiveType get type {
    _$this;
    return super.type;
  }

  @override
  set type(DirectiveType type) {
    _$this;
    super.type = type;
  }

  _$DirectiveBuilder() : super._();

  DirectiveBuilder get _$this {
    if (_$v != null) {
      super.as = _$v.as;
      super.url = _$v.url;
      super.type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Directive other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Directive;
  }

  @override
  void update(void updates(DirectiveBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Directive build() {
    final result = _$v ?? new _$Directive._(as: as, url: url, type: type);
    replace(result);
    return result;
  }
}
