// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Field extends Field {
  @override
  final BuiltList<Expression> annotations;
  @override
  final BuiltList<String> docs;
  @override
  final Code? assignment;
  @override
  final bool static;
  @override
  final bool late;
  @override
  final bool external;
  @override
  final String name;
  @override
  final Reference? type;
  @override
  final FieldModifier modifier;

  factory _$Field([void Function(FieldBuilder)? updates]) =>
      (new FieldBuilder()..update(updates)).build() as _$Field;

  _$Field._(
      {required this.annotations,
        required this.docs,
        this.assignment,
        required this.static,
        required this.late,
        required this.external,
        required this.name,
        this.type,
        required this.modifier})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(annotations, r'Field', 'annotations');
    BuiltValueNullFieldError.checkNotNull(docs, r'Field', 'docs');
    BuiltValueNullFieldError.checkNotNull(static, r'Field', 'static');
    BuiltValueNullFieldError.checkNotNull(late, r'Field', 'late');
    BuiltValueNullFieldError.checkNotNull(external, r'Field', 'external');
    BuiltValueNullFieldError.checkNotNull(name, r'Field', 'name');
    BuiltValueNullFieldError.checkNotNull(modifier, r'Field', 'modifier');
  }

  @override
  Field rebuild(void Function(FieldBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$FieldBuilder toBuilder() => new _$FieldBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Field &&
        annotations == other.annotations &&
        docs == other.docs &&
        assignment == other.assignment &&
        static == other.static &&
        late == other.late &&
        external == other.external &&
        name == other.name &&
        type == other.type &&
        modifier == other.modifier;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, annotations.hashCode);
    _$hash = $jc(_$hash, docs.hashCode);
    _$hash = $jc(_$hash, assignment.hashCode);
    _$hash = $jc(_$hash, static.hashCode);
    _$hash = $jc(_$hash, late.hashCode);
    _$hash = $jc(_$hash, external.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, modifier.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Field')
      ..add('annotations', annotations)
      ..add('docs', docs)
      ..add('assignment', assignment)
      ..add('static', static)
      ..add('late', late)
      ..add('external', external)
      ..add('name', name)
      ..add('type', type)
      ..add('modifier', modifier))
        .toString();
  }
}

class _$FieldBuilder extends FieldBuilder {
  _$Field? _$v;

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
  Code? get assignment {
    _$this;
    return super.assignment;
  }

  @override
  set assignment(Code? assignment) {
    _$this;
    super.assignment = assignment;
  }

  @override
  bool get static {
    _$this;
    return super.static;
  }

  @override
  set static(bool static) {
    _$this;
    super.static = static;
  }

  @override
  bool get late {
    _$this;
    return super.late;
  }

  @override
  set late(bool late) {
    _$this;
    super.late = late;
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
  Reference? get type {
    _$this;
    return super.type;
  }

  @override
  set type(Reference? type) {
    _$this;
    super.type = type;
  }

  @override
  FieldModifier get modifier {
    _$this;
    return super.modifier;
  }

  @override
  set modifier(FieldModifier modifier) {
    _$this;
    super.modifier = modifier;
  }

  _$FieldBuilder() : super._();

  FieldBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.annotations = $v.annotations.toBuilder();
      super.docs = $v.docs.toBuilder();
      super.assignment = $v.assignment;
      super.static = $v.static;
      super.late = $v.late;
      super.external = $v.external;
      super.name = $v.name;
      super.type = $v.type;
      super.modifier = $v.modifier;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Field other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Field;
  }

  @override
  void update(void Function(FieldBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Field build() => _build();

  _$Field _build() {
    _$Field _$result;
    try {
      _$result = _$v ??
          new _$Field._(
              annotations: annotations.build(),
              docs: docs.build(),
              assignment: assignment,
              static: BuiltValueNullFieldError.checkNotNull(
                  static, r'Field', 'static'),
              late:
              BuiltValueNullFieldError.checkNotNull(late, r'Field', 'late'),
              external: BuiltValueNullFieldError.checkNotNull(
                  external, r'Field', 'external'),
              name:
              BuiltValueNullFieldError.checkNotNull(name, r'Field', 'name'),
              type: type,
              modifier: BuiltValueNullFieldError.checkNotNull(
                  modifier, r'Field', 'modifier'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'annotations';
        annotations.build();
        _$failedField = 'docs';
        docs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Field', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
