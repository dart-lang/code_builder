// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.annotation;

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

class _$Annotation extends Annotation {
  @override
  final Code codeForAnnotation;

  factory _$Annotation([void updates(AnnotationBuilder b)]) =>
      (new AnnotationBuilder()..update(updates)).build() as _$Annotation;

  _$Annotation._({this.codeForAnnotation}) : super._() {
    if (codeForAnnotation == null)
      throw new ArgumentError.notNull('codeForAnnotation');
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
    return codeForAnnotation == other.codeForAnnotation;
  }

  @override
  int get hashCode {
    return $jf($jc(0, codeForAnnotation.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Annotation')
          ..add('codeForAnnotation', codeForAnnotation))
        .toString();
  }
}

class _$AnnotationBuilder extends AnnotationBuilder {
  _$Annotation _$v;

  @override
  Code get codeForAnnotation {
    _$this;
    return super.codeForAnnotation;
  }

  @override
  set codeForAnnotation(Code codeForAnnotation) {
    _$this;
    super.codeForAnnotation = codeForAnnotation;
  }

  _$AnnotationBuilder() : super._();

  AnnotationBuilder get _$this {
    if (_$v != null) {
      super.codeForAnnotation = _$v.codeForAnnotation;
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
    final _$result =
        _$v ?? new _$Annotation._(codeForAnnotation: codeForAnnotation);
    replace(_$result);
    return _$result;
  }
}
