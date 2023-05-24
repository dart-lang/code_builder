// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecordType extends RecordType {
  @override
  final BuiltList<Reference> positionalFieldTypes;
  @override
  final BuiltMap<String, Reference> namedFieldTypes;
  @override
  final bool? isNullable;

  factory _$RecordType([void Function(RecordTypeBuilder)? updates]) =>
      (new RecordTypeBuilder()..update(updates)).build() as _$RecordType;

  _$RecordType._(
      {required this.positionalFieldTypes,
      required this.namedFieldTypes,
      this.isNullable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        positionalFieldTypes, r'RecordType', 'positionalFieldTypes');
    BuiltValueNullFieldError.checkNotNull(
        namedFieldTypes, r'RecordType', 'namedFieldTypes');
  }

  @override
  RecordType rebuild(void Function(RecordTypeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$RecordTypeBuilder toBuilder() => new _$RecordTypeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecordType &&
        positionalFieldTypes == other.positionalFieldTypes &&
        namedFieldTypes == other.namedFieldTypes &&
        isNullable == other.isNullable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, positionalFieldTypes.hashCode);
    _$hash = $jc(_$hash, namedFieldTypes.hashCode);
    _$hash = $jc(_$hash, isNullable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecordType')
          ..add('positionalFieldTypes', positionalFieldTypes)
          ..add('namedFieldTypes', namedFieldTypes)
          ..add('isNullable', isNullable))
        .toString();
  }
}

class _$RecordTypeBuilder extends RecordTypeBuilder {
  _$RecordType? _$v;

  @override
  ListBuilder<Reference> get positionalFieldTypes {
    _$this;
    return super.positionalFieldTypes;
  }

  @override
  set positionalFieldTypes(ListBuilder<Reference> positionalFieldTypes) {
    _$this;
    super.positionalFieldTypes = positionalFieldTypes;
  }

  @override
  MapBuilder<String, Reference> get namedFieldTypes {
    _$this;
    return super.namedFieldTypes;
  }

  @override
  set namedFieldTypes(MapBuilder<String, Reference> namedFieldTypes) {
    _$this;
    super.namedFieldTypes = namedFieldTypes;
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

  _$RecordTypeBuilder() : super._();

  RecordTypeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.positionalFieldTypes = $v.positionalFieldTypes.toBuilder();
      super.namedFieldTypes = $v.namedFieldTypes.toBuilder();
      super.isNullable = $v.isNullable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecordType other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RecordType;
  }

  @override
  void update(void Function(RecordTypeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecordType build() => _build();

  _$RecordType _build() {
    _$RecordType _$result;
    try {
      _$result = _$v ??
          new _$RecordType._(
              positionalFieldTypes: positionalFieldTypes.build(),
              namedFieldTypes: namedFieldTypes.build(),
              isNullable: isNullable);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'positionalFieldTypes';
        positionalFieldTypes.build();
        _$failedField = 'namedFieldTypes';
        namedFieldTypes.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'RecordType', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
