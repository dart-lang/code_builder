// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.code;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$Block extends Block {
  @override
  final BuiltList<Code> statements;

  factory _$Block([void updates(BlockBuilder b)]) =>
      (new BlockBuilder()..update(updates)).build() as _$Block;

  _$Block._({this.statements}) : super._() {
    if (statements == null)
      throw new BuiltValueNullFieldError('Block', 'statements');
  }

  @override
  Block rebuild(void updates(BlockBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$BlockBuilder toBuilder() => new _$BlockBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Block) return false;
    return statements == other.statements;
  }

  @override
  int get hashCode {
    return $jf($jc(0, statements.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Block')..add('statements', statements))
        .toString();
  }
}

class _$BlockBuilder extends BlockBuilder {
  _$Block _$v;

  @override
  ListBuilder<Code> get statements {
    _$this;
    return super.statements ??= new ListBuilder<Code>();
  }

  @override
  set statements(ListBuilder<Code> statements) {
    _$this;
    super.statements = statements;
  }

  _$BlockBuilder() : super._();

  BlockBuilder get _$this {
    if (_$v != null) {
      super.statements = _$v.statements?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Block other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Block;
  }

  @override
  void update(void updates(BlockBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Block build() {
    _$Block _$result;
    try {
      _$result = _$v ?? new _$Block._(statements: statements.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'statements';
        statements.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Block', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
