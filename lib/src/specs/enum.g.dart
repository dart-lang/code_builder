// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Enum extends Enum {
  @override
  final String name;
  @override
  final BuiltList<EnumValue> values;
  @override
  final BuiltList<Expression> annotations;
  @override
  final BuiltList<String> docs;
  @override
  final BuiltList<Reference> implements;
  @override
  final BuiltList<Reference> mixins;
  @override
  final BuiltList<Reference> types;
  @override
  final BuiltList<Constructor> constructors;
  @override
  final BuiltList<Method> methods;
  @override
  final BuiltList<Field> fields;

  factory _$Enum([void Function(EnumBuilder)? updates]) =>
      (new EnumBuilder()..update(updates)).build() as _$Enum;

  _$Enum._(
      {required this.name,
      required this.values,
      required this.annotations,
      required this.docs,
      required this.implements,
      required this.mixins,
      required this.types,
      required this.constructors,
      required this.methods,
      required this.fields})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'Enum', 'name');
    BuiltValueNullFieldError.checkNotNull(values, r'Enum', 'values');
    BuiltValueNullFieldError.checkNotNull(annotations, r'Enum', 'annotations');
    BuiltValueNullFieldError.checkNotNull(docs, r'Enum', 'docs');
    BuiltValueNullFieldError.checkNotNull(implements, r'Enum', 'implements');
    BuiltValueNullFieldError.checkNotNull(mixins, r'Enum', 'mixins');
    BuiltValueNullFieldError.checkNotNull(types, r'Enum', 'types');
    BuiltValueNullFieldError.checkNotNull(
        constructors, r'Enum', 'constructors');
    BuiltValueNullFieldError.checkNotNull(methods, r'Enum', 'methods');
    BuiltValueNullFieldError.checkNotNull(fields, r'Enum', 'fields');
  }

  @override
  Enum rebuild(void Function(EnumBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$EnumBuilder toBuilder() => new _$EnumBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Enum &&
        name == other.name &&
        values == other.values &&
        annotations == other.annotations &&
        docs == other.docs &&
        implements == other.implements &&
        mixins == other.mixins &&
        types == other.types &&
        constructors == other.constructors &&
        methods == other.methods &&
        fields == other.fields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, values.hashCode);
    _$hash = $jc(_$hash, annotations.hashCode);
    _$hash = $jc(_$hash, docs.hashCode);
    _$hash = $jc(_$hash, implements.hashCode);
    _$hash = $jc(_$hash, mixins.hashCode);
    _$hash = $jc(_$hash, types.hashCode);
    _$hash = $jc(_$hash, constructors.hashCode);
    _$hash = $jc(_$hash, methods.hashCode);
    _$hash = $jc(_$hash, fields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Enum')
          ..add('name', name)
          ..add('values', values)
          ..add('annotations', annotations)
          ..add('docs', docs)
          ..add('implements', implements)
          ..add('mixins', mixins)
          ..add('types', types)
          ..add('constructors', constructors)
          ..add('methods', methods)
          ..add('fields', fields))
        .toString();
  }
}

class _$EnumBuilder extends EnumBuilder {
  _$Enum? _$v;

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
  ListBuilder<EnumValue> get values {
    _$this;
    return super.values;
  }

  @override
  set values(ListBuilder<EnumValue> values) {
    _$this;
    super.values = values;
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
  ListBuilder<Reference> get implements {
    _$this;
    return super.implements;
  }

  @override
  set implements(ListBuilder<Reference> implements) {
    _$this;
    super.implements = implements;
  }

  @override
  ListBuilder<Reference> get mixins {
    _$this;
    return super.mixins;
  }

  @override
  set mixins(ListBuilder<Reference> mixins) {
    _$this;
    super.mixins = mixins;
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

  @override
  ListBuilder<Constructor> get constructors {
    _$this;
    return super.constructors;
  }

  @override
  set constructors(ListBuilder<Constructor> constructors) {
    _$this;
    super.constructors = constructors;
  }

  @override
  ListBuilder<Method> get methods {
    _$this;
    return super.methods;
  }

  @override
  set methods(ListBuilder<Method> methods) {
    _$this;
    super.methods = methods;
  }

  @override
  ListBuilder<Field> get fields {
    _$this;
    return super.fields;
  }

  @override
  set fields(ListBuilder<Field> fields) {
    _$this;
    super.fields = fields;
  }

  _$EnumBuilder() : super._();

  EnumBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.name = $v.name;
      super.values = $v.values.toBuilder();
      super.annotations = $v.annotations.toBuilder();
      super.docs = $v.docs.toBuilder();
      super.implements = $v.implements.toBuilder();
      super.mixins = $v.mixins.toBuilder();
      super.types = $v.types.toBuilder();
      super.constructors = $v.constructors.toBuilder();
      super.methods = $v.methods.toBuilder();
      super.fields = $v.fields.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Enum other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Enum;
  }

  @override
  void update(void Function(EnumBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Enum build() => _build();

  _$Enum _build() {
    _$Enum _$result;
    try {
      _$result = _$v ??
          new _$Enum._(
              name:
                  BuiltValueNullFieldError.checkNotNull(name, r'Enum', 'name'),
              values: values.build(),
              annotations: annotations.build(),
              docs: docs.build(),
              implements: implements.build(),
              mixins: mixins.build(),
              types: types.build(),
              constructors: constructors.build(),
              methods: methods.build(),
              fields: fields.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'values';
        values.build();
        _$failedField = 'annotations';
        annotations.build();
        _$failedField = 'docs';
        docs.build();
        _$failedField = 'implements';
        implements.build();
        _$failedField = 'mixins';
        mixins.build();
        _$failedField = 'types';
        types.build();
        _$failedField = 'constructors';
        constructors.build();
        _$failedField = 'methods';
        methods.build();
        _$failedField = 'fields';
        fields.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Enum', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$EnumValue extends EnumValue {
  @override
  final String name;
  @override
  final BuiltList<Expression> annotations;
  @override
  final BuiltList<String> docs;
  @override
  final String? constructorName;
  @override
  final BuiltList<Reference> types;
  @override
  final BuiltList<Expression> arguments;
  @override
  final BuiltMap<String, Expression> namedArguments;

  factory _$EnumValue([void Function(EnumValueBuilder)? updates]) =>
      (new EnumValueBuilder()..update(updates)).build() as _$EnumValue;

  _$EnumValue._(
      {required this.name,
      required this.annotations,
      required this.docs,
      this.constructorName,
      required this.types,
      required this.arguments,
      required this.namedArguments})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'EnumValue', 'name');
    BuiltValueNullFieldError.checkNotNull(
        annotations, r'EnumValue', 'annotations');
    BuiltValueNullFieldError.checkNotNull(docs, r'EnumValue', 'docs');
    BuiltValueNullFieldError.checkNotNull(types, r'EnumValue', 'types');
    BuiltValueNullFieldError.checkNotNull(arguments, r'EnumValue', 'arguments');
    BuiltValueNullFieldError.checkNotNull(
        namedArguments, r'EnumValue', 'namedArguments');
  }

  @override
  EnumValue rebuild(void Function(EnumValueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$EnumValueBuilder toBuilder() => new _$EnumValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EnumValue &&
        name == other.name &&
        annotations == other.annotations &&
        docs == other.docs &&
        constructorName == other.constructorName &&
        types == other.types &&
        arguments == other.arguments &&
        namedArguments == other.namedArguments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, annotations.hashCode);
    _$hash = $jc(_$hash, docs.hashCode);
    _$hash = $jc(_$hash, constructorName.hashCode);
    _$hash = $jc(_$hash, types.hashCode);
    _$hash = $jc(_$hash, arguments.hashCode);
    _$hash = $jc(_$hash, namedArguments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EnumValue')
          ..add('name', name)
          ..add('annotations', annotations)
          ..add('docs', docs)
          ..add('constructorName', constructorName)
          ..add('types', types)
          ..add('arguments', arguments)
          ..add('namedArguments', namedArguments))
        .toString();
  }
}

class _$EnumValueBuilder extends EnumValueBuilder {
  _$EnumValue? _$v;

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
  String? get constructorName {
    _$this;
    return super.constructorName;
  }

  @override
  set constructorName(String? constructorName) {
    _$this;
    super.constructorName = constructorName;
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

  @override
  ListBuilder<Expression> get arguments {
    _$this;
    return super.arguments;
  }

  @override
  set arguments(ListBuilder<Expression> arguments) {
    _$this;
    super.arguments = arguments;
  }

  @override
  MapBuilder<String, Expression> get namedArguments {
    _$this;
    return super.namedArguments;
  }

  @override
  set namedArguments(MapBuilder<String, Expression> namedArguments) {
    _$this;
    super.namedArguments = namedArguments;
  }

  _$EnumValueBuilder() : super._();

  EnumValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.name = $v.name;
      super.annotations = $v.annotations.toBuilder();
      super.docs = $v.docs.toBuilder();
      super.constructorName = $v.constructorName;
      super.types = $v.types.toBuilder();
      super.arguments = $v.arguments.toBuilder();
      super.namedArguments = $v.namedArguments.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EnumValue other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EnumValue;
  }

  @override
  void update(void Function(EnumValueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EnumValue build() => _build();

  _$EnumValue _build() {
    _$EnumValue _$result;
    try {
      _$result = _$v ??
          new _$EnumValue._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'EnumValue', 'name'),
              annotations: annotations.build(),
              docs: docs.build(),
              constructorName: constructorName,
              types: types.build(),
              arguments: arguments.build(),
              namedArguments: namedArguments.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'annotations';
        annotations.build();
        _$failedField = 'docs';
        docs.build();

        _$failedField = 'types';
        types.build();
        _$failedField = 'arguments';
        arguments.build();
        _$failedField = 'namedArguments';
        namedArguments.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'EnumValue', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
