// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Switch extends Switch {
  @override
  final Expression condition;
  @override
  final BuiltList<SwitchCase> cases;
  @override
  final Code? default$;
  @override
  final BuiltList<String> docs;

  factory _$Switch([void Function(SwitchBuilder)? updates]) =>
      (new SwitchBuilder()..update(updates)).build() as _$Switch;

  _$Switch._(
      {required this.condition,
      required this.cases,
      this.default$,
      required this.docs})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(condition, r'Switch', 'condition');
    BuiltValueNullFieldError.checkNotNull(cases, r'Switch', 'cases');
    BuiltValueNullFieldError.checkNotNull(docs, r'Switch', 'docs');
  }

  @override
  Switch rebuild(void Function(SwitchBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$SwitchBuilder toBuilder() => new _$SwitchBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Switch &&
        condition == other.condition &&
        cases == other.cases &&
        default$ == other.default$ &&
        docs == other.docs;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, condition.hashCode), cases.hashCode), default$.hashCode),
        docs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Switch')
          ..add('condition', condition)
          ..add('cases', cases)
          ..add('default\$', default$)
          ..add('docs', docs))
        .toString();
  }
}

class _$SwitchBuilder extends SwitchBuilder {
  _$Switch? _$v;

  @override
  Expression? get condition {
    _$this;
    return super.condition;
  }

  @override
  set condition(Expression? condition) {
    _$this;
    super.condition = condition;
  }

  @override
  ListBuilder<SwitchCase> get cases {
    _$this;
    return super.cases;
  }

  @override
  set cases(ListBuilder<SwitchCase> cases) {
    _$this;
    super.cases = cases;
  }

  @override
  Code? get default$ {
    _$this;
    return super.default$;
  }

  @override
  set default$(Code? default$) {
    _$this;
    super.default$ = default$;
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

  _$SwitchBuilder() : super._();

  SwitchBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.condition = $v.condition;
      super.cases = $v.cases.toBuilder();
      super.default$ = $v.default$;
      super.docs = $v.docs.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Switch other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Switch;
  }

  @override
  void update(void Function(SwitchBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Switch build() => _build();

  _$Switch _build() {
    _$Switch _$result;
    try {
      _$result = _$v ??
          new _$Switch._(
              condition: BuiltValueNullFieldError.checkNotNull(
                  condition, r'Switch', 'condition'),
              cases: cases.build(),
              default$: default$,
              docs: docs.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cases';
        cases.build();

        _$failedField = 'docs';
        docs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Switch', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SwitchCase extends SwitchCase {
  @override
  final Expression? condition;
  @override
  final Code? body;
  @override
  final bool? break$;
  @override
  final BuiltList<String> docs;

  factory _$SwitchCase([void Function(SwitchCaseBuilder)? updates]) =>
      (new SwitchCaseBuilder()..update(updates)).build() as _$SwitchCase;

  _$SwitchCase._({this.condition, this.body, this.break$, required this.docs})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(docs, r'SwitchCase', 'docs');
  }

  @override
  SwitchCase rebuild(void Function(SwitchCaseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  _$SwitchCaseBuilder toBuilder() => new _$SwitchCaseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SwitchCase &&
        condition == other.condition &&
        body == other.body &&
        break$ == other.break$ &&
        docs == other.docs;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, condition.hashCode), body.hashCode), break$.hashCode),
        docs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SwitchCase')
          ..add('condition', condition)
          ..add('body', body)
          ..add('break\$', break$)
          ..add('docs', docs))
        .toString();
  }
}

class _$SwitchCaseBuilder extends SwitchCaseBuilder {
  _$SwitchCase? _$v;

  @override
  Expression? get condition {
    _$this;
    return super.condition;
  }

  @override
  set condition(Expression? condition) {
    _$this;
    super.condition = condition;
  }

  @override
  Code? get body {
    _$this;
    return super.body;
  }

  @override
  set body(Code? body) {
    _$this;
    super.body = body;
  }

  @override
  bool? get break$ {
    _$this;
    return super.break$;
  }

  @override
  set break$(bool? break$) {
    _$this;
    super.break$ = break$;
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

  _$SwitchCaseBuilder() : super._();

  SwitchCaseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      super.condition = $v.condition;
      super.body = $v.body;
      super.break$ = $v.break$;
      super.docs = $v.docs.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SwitchCase other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SwitchCase;
  }

  @override
  void update(void Function(SwitchCaseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SwitchCase build() => _build();

  _$SwitchCase _build() {
    _$SwitchCase _$result;
    try {
      _$result = _$v ??
          new _$SwitchCase._(
              condition: condition,
              body: body,
              break$: break$,
              docs: docs.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'docs';
        docs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SwitchCase', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
