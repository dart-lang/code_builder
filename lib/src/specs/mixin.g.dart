// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mixin.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Mixin extends Mixin {
  @override
  final BuiltList<Expression> annotations;
  @override
  final BuiltList<String> docs;
  @override
  final Reference on;
  @override
  final BuiltList<Reference> implements;
  @override
  final BuiltList<Reference> types;
  @override
  final BuiltList<Method> methods;
  @override
  final String name;

  factory _$Mixin([void Function(MixinBuilder) updates]) =>
      (new MixinBuilder()..update(updates)).build() as _$Mixin;

  _$Mixin._(
      {this.annotations,
      this.docs,
      this.on,
      this.implements,
      this.types,
      this.methods,
      this.name})
      : super._() {
    if (annotations == null) {
      throw new BuiltValueNullFieldError('Mixin', 'annotations');
    }
    if (docs == null) {
      throw new BuiltValueNullFieldError('Mixin', 'docs');
    }
    if (implements == null) {
      throw new BuiltValueNullFieldError('Mixin', 'implements');
    }
    if (types == null) {
      throw new BuiltValueNullFieldError('Mixin', 'types');
    }
    if (methods == null) {
      throw new BuiltValueNullFieldError('Mixin', 'methods');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Mixin', 'name');
    }
  }

  @override
  Mixin rebuild(void Function(MixinBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$MixinBuilder toBuilder() => new _$MixinBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Mixin &&
        annotations == other.annotations &&
        docs == other.docs &&
        on == other.on &&
        implements == other.implements &&
        types == other.types &&
        methods == other.methods &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, annotations.hashCode), docs.hashCode),
                        on.hashCode),
                    implements.hashCode),
                types.hashCode),
            methods.hashCode),
        name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Mixin')
          ..add('annotations', annotations)
          ..add('docs', docs)
          ..add('on', on)
          ..add('implements', implements)
          ..add('types', types)
          ..add('methods', methods)
          ..add('name', name))
        .toString();
  }
}

class _$MixinBuilder extends MixinBuilder {
  _$Mixin _$v;

  @override
  ListBuilder<Expression> get annotations {
    _$this;
    return super.annotations ??= new ListBuilder<Expression>();
  }

  @override
  set annotations(ListBuilder<Expression> annotations) {
    _$this;
    super.annotations = annotations;
  }

  @override
  ListBuilder<String> get docs {
    _$this;
    return super.docs ??= new ListBuilder<String>();
  }

  @override
  set docs(ListBuilder<String> docs) {
    _$this;
    super.docs = docs;
  }

  @override
  Reference get on {
    _$this;
    return super.on;
  }

  @override
  set on(Reference on) {
    _$this;
    super.on = on;
  }

  @override
  ListBuilder<Reference> get implements {
    _$this;
    return super.implements ??= new ListBuilder<Reference>();
  }

  @override
  set implements(ListBuilder<Reference> implements) {
    _$this;
    super.implements = implements;
  }

  @override
  ListBuilder<Reference> get types {
    _$this;
    return super.types ??= new ListBuilder<Reference>();
  }

  @override
  set types(ListBuilder<Reference> types) {
    _$this;
    super.types = types;
  }

  @override
  ListBuilder<Method> get methods {
    _$this;
    return super.methods ??= new ListBuilder<Method>();
  }

  @override
  set methods(ListBuilder<Method> methods) {
    _$this;
    super.methods = methods;
  }

  @override
  String get name {
    _$this;
    return super.name;
  }

  @override
  set name(String name) {
    _$this;
    super.name = name;
  }

  _$MixinBuilder() : super._();

  MixinBuilder get _$this {
    if (_$v != null) {
      super.annotations = _$v.annotations?.toBuilder();
      super.docs = _$v.docs?.toBuilder();
      super.on = _$v.on;
      super.implements = _$v.implements?.toBuilder();
      super.types = _$v.types?.toBuilder();
      super.methods = _$v.methods?.toBuilder();
      super.name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Mixin other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Mixin;
  }

  @override
  void update(void Function(MixinBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Mixin build() {
    _$Mixin _$result;
    try {
      _$result = _$v ??
          new _$Mixin._(
              annotations: annotations.build(),
              docs: docs.build(),
              on: on,
              implements: implements.build(),
              types: types.build(),
              methods: methods.build(),
              name: name);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'annotations';
        annotations.build();
        _$failedField = 'docs';
        docs.build();

        _$failedField = 'implements';
        implements.build();
        _$failedField = 'types';
        types.build();
        _$failedField = 'methods';
        methods.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Mixin', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
