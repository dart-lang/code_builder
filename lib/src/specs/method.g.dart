// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.method;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Method
// **************************************************************************

// Error: Please make the following changes to use BuiltValue:
//
//        1. Make builder have exactly these fields: url, symbol, annotations, docs, types, optionalParameters, requiredParameters, body, external, lambda, static, name, type, returns
//        2. Make field url a getter.
//        3. Make field url have non-dynamic type.
//        4. Make field symbol a getter.
//        5. Make field symbol have non-dynamic type.

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Parameter
// **************************************************************************

// ignore_for_file: annotate_overrides
class _$Parameter extends Parameter {
  @override
  final Code defaultTo;
  @override
  final String name;
  @override
  final bool named;
  @override
  final bool toThis;
  @override
  final BuiltList<Annotation> annotations;
  @override
  final BuiltList<String> docs;
  @override
  final BuiltList<TypeReference> types;
  @override
  final TypeReference type;

  factory _$Parameter([void updates(ParameterBuilder b)]) =>
      (new ParameterBuilder()..update(updates)).build() as _$Parameter;

  _$Parameter._(
      {this.defaultTo,
      this.name,
      this.named,
      this.toThis,
      this.annotations,
      this.docs,
      this.types,
      this.type})
      : super._() {
    if (name == null) throw new ArgumentError.notNull('name');
    if (named == null) throw new ArgumentError.notNull('named');
    if (toThis == null) throw new ArgumentError.notNull('toThis');
    if (annotations == null) throw new ArgumentError.notNull('annotations');
    if (docs == null) throw new ArgumentError.notNull('docs');
    if (types == null) throw new ArgumentError.notNull('types');
  }

  @override
  Parameter rebuild(void updates(ParameterBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$ParameterBuilder toBuilder() => new _$ParameterBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Parameter) return false;
    return defaultTo == other.defaultTo &&
        name == other.name &&
        named == other.named &&
        toThis == other.toThis &&
        annotations == other.annotations &&
        docs == other.docs &&
        types == other.types &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, defaultTo.hashCode), name.hashCode),
                            named.hashCode),
                        toThis.hashCode),
                    annotations.hashCode),
                docs.hashCode),
            types.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Parameter')
          ..add('defaultTo', defaultTo)
          ..add('name', name)
          ..add('named', named)
          ..add('toThis', toThis)
          ..add('annotations', annotations)
          ..add('docs', docs)
          ..add('types', types)
          ..add('type', type))
        .toString();
  }
}

class _$ParameterBuilder extends ParameterBuilder {
  _$Parameter _$v;

  @override
  Code get defaultTo {
    _$this;
    return super.defaultTo;
  }

  @override
  set defaultTo(Code defaultTo) {
    _$this;
    super.defaultTo = defaultTo;
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

  @override
  bool get named {
    _$this;
    return super.named;
  }

  @override
  set named(bool named) {
    _$this;
    super.named = named;
  }

  @override
  bool get toThis {
    _$this;
    return super.toThis;
  }

  @override
  set toThis(bool toThis) {
    _$this;
    super.toThis = toThis;
  }

  @override
  ListBuilder<Annotation> get annotations {
    _$this;
    return super.annotations ??= new ListBuilder<Annotation>();
  }

  @override
  set annotations(ListBuilder<Annotation> annotations) {
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
  ListBuilder<TypeReference> get types {
    _$this;
    return super.types ??= new ListBuilder<TypeReference>();
  }

  @override
  set types(ListBuilder<TypeReference> types) {
    _$this;
    super.types = types;
  }

  @override
  TypeReference get type {
    _$this;
    return super.type;
  }

  @override
  set type(TypeReference type) {
    _$this;
    super.type = type;
  }

  _$ParameterBuilder() : super._();

  ParameterBuilder get _$this {
    if (_$v != null) {
      super.defaultTo = _$v.defaultTo;
      super.name = _$v.name;
      super.named = _$v.named;
      super.toThis = _$v.toThis;
      super.annotations = _$v.annotations?.toBuilder();
      super.docs = _$v.docs?.toBuilder();
      super.types = _$v.types?.toBuilder();
      super.type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Parameter other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Parameter;
  }

  @override
  void update(void updates(ParameterBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Parameter build() {
    final result = _$v ??
        new _$Parameter._(
            defaultTo: defaultTo,
            name: name,
            named: named,
            toThis: toThis,
            annotations: annotations?.build(),
            docs: docs?.build(),
            types: types?.build(),
            type: type);
    replace(result);
    return result;
  }
}
