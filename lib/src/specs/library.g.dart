// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Library extends Library {
  @override
  final BuiltList<Expression> annotations;
  @override
  final BuiltList<Directive> directives;
  @override
  final BuiltList<Spec> body;
  @override
  final BuiltList<String?> comments;
  @override
  final BuiltList<String> ignoreForFile;
  @override
  final String? name;

  factory _$Library([void Function(LibraryBuilder)? updates]) =>
      (new LibraryBuilder()..update(updates)).build() as _$Library;

  _$Library._(
      {required this.annotations,
      required this.directives,
      required this.body,
      required this.comments,
      required this.ignoreForFile,
      this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        annotations, r'Library', 'annotations');
    BuiltValueNullFieldError.checkNotNull(directives, r'Library', 'directives');
    BuiltValueNullFieldError.checkNotNull(body, r'Library', 'body');
    BuiltValueNullFieldError.checkNotNull(comments, r'Library', 'comments');
    BuiltValueNullFieldError.checkNotNull(
        ignoreForFile, r'Library', 'ignoreForFile');
  }

  @override
  Library rebuild(void Function(LibraryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$LibraryBuilder toBuilder() => new _$LibraryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Library &&
        annotations == other.annotations &&
        directives == other.directives &&
        body == other.body &&
        comments == other.comments &&
        ignoreForFile == other.ignoreForFile &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annotations.hashCode);
    _$hash = $jc(_$hash, directives.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, comments.hashCode);
    _$hash = $jc(_$hash, ignoreForFile.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Library')
          ..add('annotations', annotations)
          ..add('directives', directives)
          ..add('body', body)
          ..add('comments', comments)
          ..add('ignoreForFile', ignoreForFile)
          ..add('name', name))
        .toString();
  }
}

class _$LibraryBuilder extends LibraryBuilder {
  _$Library? _$v;

  @override
  ListBuilder<Expression> get annotations {
    _$this;
    return super.annotations;
  }

  @override
  set annotations(ListBuilder<Expression> annotations) {
    _$this;
    super.annotations = annotations;
  }

  @override
  ListBuilder<Directive> get directives {
    _$this;
    return super.directives;
  }

  @override
  set directives(ListBuilder<Directive> directives) {
    _$this;
    super.directives = directives;
  }

  @override
  ListBuilder<Spec> get body {
    _$this;
    return super.body;
  }

  @override
  set body(ListBuilder<Spec> body) {
    _$this;
    super.body = body;
  }

  @override
  ListBuilder<String?> get comments {
    _$this;
    return super.comments;
  }

  @override
  set comments(ListBuilder<String?> comments) {
    _$this;
    super.comments = comments;
  }

  @override
  ListBuilder<String> get ignoreForFile {
    _$this;
    return super.ignoreForFile;
  }

  @override
  set ignoreForFile(ListBuilder<String> ignoreForFile) {
    _$this;
    super.ignoreForFile = ignoreForFile;
  }

  @override
  String? get name {
    _$this;
    return super.name;
  }

  @override
  set name(String? name) {
    _$this;
    super.name = name;
  }

  _$LibraryBuilder() : super._();

  LibraryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.annotations = $v.annotations.toBuilder();
      super.directives = $v.directives.toBuilder();
      super.body = $v.body.toBuilder();
      super.comments = $v.comments.toBuilder();
      super.ignoreForFile = $v.ignoreForFile.toBuilder();
      super.name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Library other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Library;
  }

  @override
  void update(void Function(LibraryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Library build() => _build();

  _$Library _build() {
    _$Library _$result;
    try {
      _$result = _$v ??
          new _$Library._(
              annotations: annotations.build(),
              directives: directives.build(),
              body: body.build(),
              comments: comments.build(),
              ignoreForFile: ignoreForFile.build(),
              name: name);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'annotations';
        annotations.build();
        _$failedField = 'directives';
        directives.build();
        _$failedField = 'body';
        body.build();
        _$failedField = 'comments';
        comments.build();
        _$failedField = 'ignoreForFile';
        ignoreForFile.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Library', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
