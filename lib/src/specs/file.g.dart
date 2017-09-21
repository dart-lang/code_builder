// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.library;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$File extends File {
  @override
  final BuiltList<Directive> directives;
  @override
  final BuiltList<Spec> body;

  factory _$File([void updates(FileBuilder b)]) =>
      (new FileBuilder()..update(updates)).build() as _$File;

  _$File._({this.directives, this.body}) : super._() {
    if (directives == null) throw new ArgumentError.notNull('directives');
    if (body == null) throw new ArgumentError.notNull('body');
  }

  @override
  File rebuild(void updates(FileBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$FileBuilder toBuilder() => new _$FileBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! File) return false;
    return directives == other.directives && body == other.body;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, directives.hashCode), body.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('File')
          ..add('directives', directives)
          ..add('body', body))
        .toString();
  }
}

class _$FileBuilder extends FileBuilder {
  _$File _$v;

  @override
  ListBuilder<Directive> get directives {
    _$this;
    return super.directives ??= new ListBuilder<Directive>();
  }

  @override
  set directives(ListBuilder<Directive> directives) {
    _$this;
    super.directives = directives;
  }

  @override
  ListBuilder<Spec> get body {
    _$this;
    return super.body ??= new ListBuilder<Spec>();
  }

  @override
  set body(ListBuilder<Spec> body) {
    _$this;
    super.body = body;
  }

  _$FileBuilder() : super._();

  FileBuilder get _$this {
    if (_$v != null) {
      super.directives = _$v.directives?.toBuilder();
      super.body = _$v.body?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(File other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$File;
  }

  @override
  void update(void updates(FileBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$File build() {
    final _$result = _$v ??
        new _$File._(directives: directives?.build(), body: body?.build());
    replace(_$result);
    return _$result;
  }
}
