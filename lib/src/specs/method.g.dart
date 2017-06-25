// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.method;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Method
// **************************************************************************

class _$Method extends Method {
  @override
  final BuiltList<Annotation> annotations;
  @override
  final BuiltList<String> docs;
  @override
  final BuiltList<TypeReference> types;
  @override
  final BuiltList<Parameter> optionalParameters;
  @override
  final BuiltList<Parameter> requiredParameters;
  @override
  final Code body;
  @override
  final bool external;
  @override
  final bool lambda;
  @override
  final bool static;
  @override
  final String name;
  @override
  final MethodType type;
  @override
  final TypeReference returns;

  factory _$Method([void updates(MethodBuilder b)]) =>
      (new MethodBuilder()..update(updates)).build() as _$Method;

  _$Method._(
      {this.annotations,
      this.docs,
      this.types,
      this.optionalParameters,
      this.requiredParameters,
      this.body,
      this.external,
      this.lambda,
      this.static,
      this.name,
      this.type,
      this.returns})
      : super._() {
    if (annotations == null) throw new ArgumentError.notNull('annotations');
    if (docs == null) throw new ArgumentError.notNull('docs');
    if (types == null) throw new ArgumentError.notNull('types');
    if (optionalParameters == null)
      throw new ArgumentError.notNull('optionalParameters');
    if (requiredParameters == null)
      throw new ArgumentError.notNull('requiredParameters');
    if (external == null) throw new ArgumentError.notNull('external');
    if (lambda == null) throw new ArgumentError.notNull('lambda');
    if (static == null) throw new ArgumentError.notNull('static');
    if (name == null) throw new ArgumentError.notNull('name');
  }

  @override
  Method rebuild(void updates(MethodBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$MethodBuilder toBuilder() => new _$MethodBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Method) return false;
    return annotations == other.annotations &&
        docs == other.docs &&
        types == other.types &&
        optionalParameters == other.optionalParameters &&
        requiredParameters == other.requiredParameters &&
        body == other.body &&
        external == other.external &&
        lambda == other.lambda &&
        static == other.static &&
        name == other.name &&
        type == other.type &&
        returns == other.returns;
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
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, annotations.hashCode),
                                                docs.hashCode),
                                            types.hashCode),
                                        optionalParameters.hashCode),
                                    requiredParameters.hashCode),
                                body.hashCode),
                            external.hashCode),
                        lambda.hashCode),
                    static.hashCode),
                name.hashCode),
            type.hashCode),
        returns.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Method')
          ..add('annotations', annotations)
          ..add('docs', docs)
          ..add('types', types)
          ..add('optionalParameters', optionalParameters)
          ..add('requiredParameters', requiredParameters)
          ..add('body', body)
          ..add('external', external)
          ..add('lambda', lambda)
          ..add('static', static)
          ..add('name', name)
          ..add('type', type)
          ..add('returns', returns))
        .toString();
  }
}

class _$MethodBuilder extends MethodBuilder {
  _$Method _$v;

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
  ListBuilder<Parameter> get optionalParameters {
    _$this;
    return super.optionalParameters ??= new ListBuilder<Parameter>();
  }

  @override
  set optionalParameters(ListBuilder<Parameter> optionalParameters) {
    _$this;
    super.optionalParameters = optionalParameters;
  }

  @override
  ListBuilder<Parameter> get requiredParameters {
    _$this;
    return super.requiredParameters ??= new ListBuilder<Parameter>();
  }

  @override
  set requiredParameters(ListBuilder<Parameter> requiredParameters) {
    _$this;
    super.requiredParameters = requiredParameters;
  }

  @override
  Code get body {
    _$this;
    return super.body;
  }

  @override
  set body(Code body) {
    _$this;
    super.body = body;
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
  bool get lambda {
    _$this;
    return super.lambda;
  }

  @override
  set lambda(bool lambda) {
    _$this;
    super.lambda = lambda;
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
  MethodType get type {
    _$this;
    return super.type;
  }

  @override
  set type(MethodType type) {
    _$this;
    super.type = type;
  }

  @override
  TypeReference get returns {
    _$this;
    return super.returns;
  }

  @override
  set returns(TypeReference returns) {
    _$this;
    super.returns = returns;
  }

  _$MethodBuilder() : super._();

  MethodBuilder get _$this {
    if (_$v != null) {
      super.annotations = _$v.annotations?.toBuilder();
      super.docs = _$v.docs?.toBuilder();
      super.types = _$v.types?.toBuilder();
      super.optionalParameters = _$v.optionalParameters?.toBuilder();
      super.requiredParameters = _$v.requiredParameters?.toBuilder();
      super.body = _$v.body;
      super.external = _$v.external;
      super.lambda = _$v.lambda;
      super.static = _$v.static;
      super.name = _$v.name;
      super.type = _$v.type;
      super.returns = _$v.returns;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Method other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Method;
  }

  @override
  void update(void updates(MethodBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Method build() {
    final result = _$v ??
        new _$Method._(
            annotations: annotations?.build(),
            docs: docs?.build(),
            types: types?.build(),
            optionalParameters: optionalParameters?.build(),
            requiredParameters: requiredParameters?.build(),
            body: body,
            external: external,
            lambda: lambda,
            static: static,
            name: name,
            type: type,
            returns: returns);
    replace(result);
    return result;
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Parameter
// **************************************************************************

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
