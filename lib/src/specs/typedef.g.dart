// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typedef.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TypeDef extends TypeDef {
  @override
  final String name;
  @override
  final Expression definition;
  @override
  final BuiltList<Expression> annotations;
  @override
  final BuiltList<String> docs;
  @override
  final BuiltList<Reference> types;

  factory _$TypeDef([void Function(TypeDefBuilder)? updates]) =>
      (new TypeDefBuilder()..update(updates)).build() as _$TypeDef;

  _$TypeDef._(
      {required this.name,
      required this.definition,
      required this.annotations,
      required this.docs,
      required this.types})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'TypeDef', 'name');
    BuiltValueNullFieldError.checkNotNull(definition, r'TypeDef', 'definition');
    BuiltValueNullFieldError.checkNotNull(
        annotations, r'TypeDef', 'annotations');
    BuiltValueNullFieldError.checkNotNull(docs, r'TypeDef', 'docs');
    BuiltValueNullFieldError.checkNotNull(types, r'TypeDef', 'types');
  }

  @override
  TypeDef rebuild(void Function(TypeDefBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$TypeDefBuilder toBuilder() => new _$TypeDefBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TypeDef &&
        name == other.name &&
        definition == other.definition &&
        annotations == other.annotations &&
        docs == other.docs &&
        types == other.types;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, definition.hashCode);
    _$hash = $jc(_$hash, annotations.hashCode);
    _$hash = $jc(_$hash, docs.hashCode);
    _$hash = $jc(_$hash, types.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TypeDef')
          ..add('name', name)
          ..add('definition', definition)
          ..add('annotations', annotations)
          ..add('docs', docs)
          ..add('types', types))
        .toString();
  }
}

class _$TypeDefBuilder extends TypeDefBuilder {
  _$TypeDef? _$v;

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

  @override
  Expression? get definition {
    _$this;
    return super.definition;
  }

  @override
  set definition(Expression? definition) {
    _$this;
    super.definition = definition;
  }

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
  ListBuilder<String> get docs {
    _$this;
    return super.docs;
  }

  @override
  set docs(ListBuilder<String> docs) {
    _$this;
    super.docs = docs;
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

  _$TypeDefBuilder() : super._();

  TypeDefBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.name = $v.name;
      super.definition = $v.definition;
      super.annotations = $v.annotations.toBuilder();
      super.docs = $v.docs.toBuilder();
      super.types = $v.types.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TypeDef other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TypeDef;
  }

  @override
  void update(void Function(TypeDefBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TypeDef build() => _build();

  _$TypeDef _build() {
    _$TypeDef _$result;
    try {
      _$result = _$v ??
          new _$TypeDef._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'TypeDef', 'name'),
              definition: BuiltValueNullFieldError.checkNotNull(
                  definition, r'TypeDef', 'definition'),
              annotations: annotations.build(),
              docs: docs.build(),
              types: types.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'annotations';
        annotations.build();
        _$failedField = 'docs';
        docs.build();
        _$failedField = 'types';
        types.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TypeDef', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
