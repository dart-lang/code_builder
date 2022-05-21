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
    BuiltValueNullFieldError.checkNotNull(name, 'Enum', 'name');
    BuiltValueNullFieldError.checkNotNull(values, 'Enum', 'values');
    BuiltValueNullFieldError.checkNotNull(annotations, 'Enum', 'annotations');
    BuiltValueNullFieldError.checkNotNull(docs, 'Enum', 'docs');
    BuiltValueNullFieldError.checkNotNull(implements, 'Enum', 'implements');
    BuiltValueNullFieldError.checkNotNull(mixins, 'Enum', 'mixins');
    BuiltValueNullFieldError.checkNotNull(types, 'Enum', 'types');
    BuiltValueNullFieldError.checkNotNull(constructors, 'Enum', 'constructors');
    BuiltValueNullFieldError.checkNotNull(methods, 'Enum', 'methods');
    BuiltValueNullFieldError.checkNotNull(fields, 'Enum', 'fields');
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
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc($jc(0, name.hashCode), values.hashCode),
                                    annotations.hashCode),
                                docs.hashCode),
                            implements.hashCode),
                        mixins.hashCode),
                    types.hashCode),
                constructors.hashCode),
            methods.hashCode),
        fields.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Enum')
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
  _$Enum build() {
    _$Enum _$result;
    try {
      _$result = _$v ??
          new _$Enum._(
              name: BuiltValueNullFieldError.checkNotNull(name, 'Enum', 'name'),
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
            'Enum', _$failedField, e.toString());
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
  final String? targetName;
  @override
  final BuiltList<Expression> arguments;

  factory _$EnumValue([void Function(EnumValueBuilder)? updates]) =>
      (new EnumValueBuilder()..update(updates)).build() as _$EnumValue;

  _$EnumValue._(
      {required this.name,
      required this.annotations,
      required this.docs,
      this.targetName,
      required this.arguments})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'EnumValue', 'name');
    BuiltValueNullFieldError.checkNotNull(
        annotations, 'EnumValue', 'annotations');
    BuiltValueNullFieldError.checkNotNull(docs, 'EnumValue', 'docs');
    BuiltValueNullFieldError.checkNotNull(arguments, 'EnumValue', 'arguments');
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
        targetName == other.targetName &&
        arguments == other.arguments;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, name.hashCode), annotations.hashCode),
                docs.hashCode),
            targetName.hashCode),
        arguments.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EnumValue')
          ..add('name', name)
          ..add('annotations', annotations)
          ..add('docs', docs)
          ..add('targetName', targetName)
          ..add('arguments', arguments))
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
  String? get targetName {
    _$this;
    return super.targetName;
  }

  @override
  set targetName(String? targetName) {
    _$this;
    super.targetName = targetName;
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

  _$EnumValueBuilder() : super._();

  EnumValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.name = $v.name;
      super.annotations = $v.annotations.toBuilder();
      super.docs = $v.docs.toBuilder();
      super.targetName = $v.targetName;
      super.arguments = $v.arguments.toBuilder();
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
  _$EnumValue build() {
    _$EnumValue _$result;
    try {
      _$result = _$v ??
          new _$EnumValue._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, 'EnumValue', 'name'),
              annotations: annotations.build(),
              docs: docs.build(),
              targetName: targetName,
              arguments: arguments.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'annotations';
        annotations.build();
        _$failedField = 'docs';
        docs.build();

        _$failedField = 'arguments';
        arguments.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'EnumValue', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
