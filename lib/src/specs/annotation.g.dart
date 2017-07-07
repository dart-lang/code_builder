// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.annotation;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Annotation
// **************************************************************************

// ignore_for_file: annotate_overrides
class _$Annotation extends Annotation {
  @override
  final Code code;

  factory _$Annotation([void updates(AnnotationBuilder b)]) =>
      (new AnnotationBuilder()..update(updates)).build() as _$Annotation;

  _$Annotation._({this.code}) : super._() {
    if (code == null) throw new ArgumentError.notNull('code');
  }

  @override
  Annotation rebuild(void updates(AnnotationBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$AnnotationBuilder toBuilder() => new _$AnnotationBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Annotation) return false;
    return code == other.code;
  }

  @override
  int get hashCode {
    return $jf($jc(0, code.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Annotation')..add('code', code))
        .toString();
  }
}

class _$AnnotationBuilder extends AnnotationBuilder {
  _$Annotation _$v;

  @override
  Code get code {
    _$this;
    return super.code;
  }

  @override
  set code(Code code) {
    _$this;
    super.code = code;
  }

  _$AnnotationBuilder() : super._();

  AnnotationBuilder get _$this {
    if (_$v != null) {
      super.code = _$v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Annotation other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Annotation;
  }

  @override
  void update(void updates(AnnotationBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Annotation build() {
    final result = _$v ?? new _$Annotation._(code: code);
    replace(result);
    return result;
  }
}
