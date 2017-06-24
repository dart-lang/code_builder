// GENERATED CODE - DO NOT MODIFY BY HAND

part of code_builder.src.specs.class_;

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Class
// **************************************************************************

class _$Class extends Class {
  @override
  final bool abstract;
  @override
  final BuiltList<String> docs;
  @override
  final String name;

  factory _$Class([void updates(ClassBuilder b)]) =>
      (new ClassBuilder()..update(updates)).build() as _$Class;

  _$Class._({this.abstract, this.docs, this.name}) : super._() {
    if (abstract == null) throw new ArgumentError.notNull('abstract');
    if (docs == null) throw new ArgumentError.notNull('docs');
    if (name == null) throw new ArgumentError.notNull('name');
  }

  @override
  Class rebuild(void updates(ClassBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  _$ClassBuilder toBuilder() => new _$ClassBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Class) return false;
    return abstract == other.abstract &&
        docs == other.docs &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, abstract.hashCode), docs.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Class')
          ..add('abstract', abstract)
          ..add('docs', docs)
          ..add('name', name))
        .toString();
  }
}

class _$ClassBuilder extends ClassBuilder {
  _$Class _$v;

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
  String get name {
    _$this;
    return super.name;
  }

  @override
  set name(String name) {
    _$this;
    super.name = name;
  }

  _$ClassBuilder() : super._();

  ClassBuilder get _$this {
    if (_$v != null) {
      super.abstract = _$v.abstract;
      super.docs = _$v.docs?.toBuilder();
      super.name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Class other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Class;
  }

  @override
  void update(void updates(ClassBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Class build() {
    final result = _$v ??
        new _$Class._(abstract: abstract, docs: docs?.build(), name: name);
    replace(result);
    return result;
  }
}
