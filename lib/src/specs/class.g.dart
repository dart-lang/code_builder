// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Class extends Class {
  @override
  final bool abstract;
  @override
  final bool sealed;
  @override
  final bool mixin;
  @override
  final ClassModifier? modifier;
  @override
  final BuiltList<Expression> annotations;
  @override
  final BuiltList<String> docs;
  @override
  final Reference? extend;
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
  @override
  final String name;

  factory _$Class([void Function(ClassBuilder)? updates]) =>
      (new ClassBuilder()..update(updates)).build() as _$Class;

  _$Class._(
      {required this.abstract,
      required this.sealed,
      required this.mixin,
      this.modifier,
      required this.annotations,
      required this.docs,
      this.extend,
      required this.implements,
      required this.mixins,
      required this.types,
      required this.constructors,
      required this.methods,
      required this.fields,
      required this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(abstract, r'Class', 'abstract');
    BuiltValueNullFieldError.checkNotNull(sealed, r'Class', 'sealed');
    BuiltValueNullFieldError.checkNotNull(mixin, r'Class', 'mixin');
    BuiltValueNullFieldError.checkNotNull(annotations, r'Class', 'annotations');
    BuiltValueNullFieldError.checkNotNull(docs, r'Class', 'docs');
    BuiltValueNullFieldError.checkNotNull(implements, r'Class', 'implements');
    BuiltValueNullFieldError.checkNotNull(mixins, r'Class', 'mixins');
    BuiltValueNullFieldError.checkNotNull(types, r'Class', 'types');
    BuiltValueNullFieldError.checkNotNull(
        constructors, r'Class', 'constructors');
    BuiltValueNullFieldError.checkNotNull(methods, r'Class', 'methods');
    BuiltValueNullFieldError.checkNotNull(fields, r'Class', 'fields');
    BuiltValueNullFieldError.checkNotNull(name, r'Class', 'name');
  }

  @override
  Class rebuild(void Function(ClassBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$ClassBuilder toBuilder() => new _$ClassBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Class &&
        abstract == other.abstract &&
        sealed == other.sealed &&
        mixin == other.mixin &&
        modifier == other.modifier &&
        annotations == other.annotations &&
        docs == other.docs &&
        extend == other.extend &&
        implements == other.implements &&
        mixins == other.mixins &&
        types == other.types &&
        constructors == other.constructors &&
        methods == other.methods &&
        fields == other.fields &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, abstract.hashCode);
    _$hash = $jc(_$hash, sealed.hashCode);
    _$hash = $jc(_$hash, mixin.hashCode);
    _$hash = $jc(_$hash, modifier.hashCode);
    _$hash = $jc(_$hash, annotations.hashCode);
    _$hash = $jc(_$hash, docs.hashCode);
    _$hash = $jc(_$hash, extend.hashCode);
    _$hash = $jc(_$hash, implements.hashCode);
    _$hash = $jc(_$hash, mixins.hashCode);
    _$hash = $jc(_$hash, types.hashCode);
    _$hash = $jc(_$hash, constructors.hashCode);
    _$hash = $jc(_$hash, methods.hashCode);
    _$hash = $jc(_$hash, fields.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Class')
          ..add('abstract', abstract)
          ..add('sealed', sealed)
          ..add('mixin', mixin)
          ..add('modifier', modifier)
          ..add('annotations', annotations)
          ..add('docs', docs)
          ..add('extend', extend)
          ..add('implements', implements)
          ..add('mixins', mixins)
          ..add('types', types)
          ..add('constructors', constructors)
          ..add('methods', methods)
          ..add('fields', fields)
          ..add('name', name))
        .toString();
  }
}

class _$ClassBuilder extends ClassBuilder {
  _$Class? _$v;

  @override
  bool get abstract {
    _$this;
    return super.abstract;
  }

  @override
  set abstract(bool abstract) {
    _$this;
    super.abstract = abstract;
  }

  @override
  bool get sealed {
    _$this;
    return super.sealed;
  }

  @override
  set sealed(bool sealed) {
    _$this;
    super.sealed = sealed;
  }

  @override
  bool get mixin {
    _$this;
    return super.mixin;
  }

  @override
  set mixin(bool mixin) {
    _$this;
    super.mixin = mixin;
  }

  @override
  ClassModifier? get modifier {
    _$this;
    return super.modifier;
  }

  @override
  set modifier(ClassModifier? modifier) {
    _$this;
    super.modifier = modifier;
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
  Reference? get extend {
    _$this;
    return super.extend;
  }

  @override
  set extend(Reference? extend) {
    _$this;
    super.extend = extend;
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

  _$ClassBuilder() : super._();

  ClassBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.abstract = $v.abstract;
      super.sealed = $v.sealed;
      super.mixin = $v.mixin;
      super.modifier = $v.modifier;
      super.annotations = $v.annotations.toBuilder();
      super.docs = $v.docs.toBuilder();
      super.extend = $v.extend;
      super.implements = $v.implements.toBuilder();
      super.mixins = $v.mixins.toBuilder();
      super.types = $v.types.toBuilder();
      super.constructors = $v.constructors.toBuilder();
      super.methods = $v.methods.toBuilder();
      super.fields = $v.fields.toBuilder();
      super.name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Class other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Class;
  }

  @override
  void update(void Function(ClassBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Class build() => _build();

  _$Class _build() {
    _$Class _$result;
    try {
      _$result = _$v ??
          new _$Class._(
              abstract: BuiltValueNullFieldError.checkNotNull(
                  abstract, r'Class', 'abstract'),
              sealed: BuiltValueNullFieldError.checkNotNull(
                  sealed, r'Class', 'sealed'),
              mixin: BuiltValueNullFieldError.checkNotNull(
                  mixin, r'Class', 'mixin'),
              modifier: modifier,
              annotations: annotations.build(),
              docs: docs.build(),
              extend: extend,
              implements: implements.build(),
              mixins: mixins.build(),
              types: types.build(),
              constructors: constructors.build(),
              methods: methods.build(),
              fields: fields.build(),
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'Class', 'name'));
    } catch (_) {
      late String _$failedField;
      try {
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
            r'Class', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
