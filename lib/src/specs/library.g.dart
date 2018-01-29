// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.library;

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

class _$Library extends Library {
  @override
  final BuiltList<Directive> directives;
  @override
  final BuiltList<Spec> body;

  factory _$Library([void updates(LibraryBuilder b)]) =>
      (new LibraryBuilder()..update(updates)).build() as _$Library;

  _$Library._({this.directives, this.body}) : super._() {
    if (directives == null)
      throw new BuiltValueNullFieldError('Library', 'directives');
    if (body == null) throw new BuiltValueNullFieldError('Library', 'body');
  }

  @override
  Library rebuild(void updates(LibraryBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$LibraryBuilder toBuilder() => new _$LibraryBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Library) return false;
    return directives == other.directives && body == other.body;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, directives.hashCode), body.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Library')
          ..add('directives', directives)
          ..add('body', body))
        .toString();
  }
}

class _$LibraryBuilder extends LibraryBuilder {
  _$Library _$v;

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

  _$LibraryBuilder() : super._();

  LibraryBuilder get _$this {
    if (_$v != null) {
      super.directives = _$v.directives?.toBuilder();
      super.body = _$v.body?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Library other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Library;
  }

  @override
  void update(void updates(LibraryBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Library build() {
    _$Library _$result;
    try {
      _$result = _$v ??
          new _$Library._(directives: directives.build(), body: body.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'directives';
        directives.build();
        _$failedField = 'body';
        body.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Library', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
