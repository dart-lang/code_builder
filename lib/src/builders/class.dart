// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/standard_ast_factory.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/field.dart';
import 'package:code_builder/src/builders/file.dart';
import 'package:code_builder/src/builders/method.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/type.dart';
import 'package:code_builder/src/tokens.dart';

/// A more short-hand way of constructing a [ClassBuilder].
ClassBuilder clazz(
  String name, [
  Iterable<ValidClassMember> members = const [],
]) {
  final clazz = new ClassBuilder(name);
  for (final member in members) {
    if (member is AnnotationBuilder) {
      clazz.addAnnotation(member);
    } else if (member is _TypeNameWrapper) {
      if (member.extend) {
        clazz.setExtends(member.type);
      } else if (member.mixin) {
        clazz.addMixin(member.type);
      } else {
        clazz.addImplement(member.type);
      }
    } else if (member is ConstructorBuilder) {
      clazz.addConstructor(member);
    } else if (member is _StaticFieldWrapper) {
      var wrapped = member._member;
      if (wrapped is MethodBuilder) {
        clazz.addMethod(wrapped, asStatic: true);
      } else {
        clazz.addField(wrapped as FieldBuilder, asStatic: true);
      }
    } else if (member is FieldBuilder) {
      clazz.addField(member);
    } else if (member is MethodBuilder) {
      clazz.addMethod(member);
    } else {
      throw new StateError('Invalid AST type: ${member.runtimeType}');
    }
  }
  return clazz;
}

/// Wrap [member] to be emitted as a `static` method or field.
ValidClassMember asStatic(ValidClassMember member) {
  return new _StaticFieldWrapper(member);
}

class _StaticFieldWrapper implements ValidClassMember {
  final ValidClassMember _member;

  _StaticFieldWrapper(this._member);

  @override
  AstNode buildAst([Scope scope]) =>
      throw new UnsupportedError('Use inside varField');
}

/// Returns a wrapper around [type] for use with [clazz].
_TypeNameWrapper extend(TypeBuilder type) {
  return new _TypeNameWrapper(
    type,
    extend: true,
  );
}

/// Returns a wrapper around [type] for use with [clazz].
_TypeNameWrapper implement(TypeBuilder type) {
  return new _TypeNameWrapper(
    type,
    implement: true,
  );
}

/// Returns a wrapper around [type] for use with [clazz].
_TypeNameWrapper mixin(TypeBuilder type) {
  return new _TypeNameWrapper(
    type,
    mixin: true,
  );
}

/// Lazily builds an [ClassDeclaration] AST when [buildClass] is invoked.
abstract class ClassBuilder
    implements AstBuilder<ClassDeclaration>, HasAnnotations, TypeBuilder {
  /// Returns a new [ClassBuilder] with [name].
  factory ClassBuilder(
    String name, {
    bool asAbstract,
    TypeBuilder asExtends,
    Iterable<TypeBuilder> asWith,
    Iterable<TypeBuilder> asImplements,
  }) = _ClassBuilderImpl;

  /// Adds a [constructor].
  void addConstructor(ConstructorBuilder constructor);

  /// Adds a [field].
  void addField(FieldBuilder field, {bool asStatic: false});

  /// Adds an [interface] to implement.
  void addImplement(TypeBuilder interface);

  /// Adds [interfaces] to implement.
  void addImplements(Iterable<TypeBuilder> interfaces);

  /// Adds a [method].
  void addMethod(MethodBuilder method, {bool asStatic: false});

  /// Adds a [mixin].
  void addMixin(TypeBuilder mixin);

  /// Adds [mixins].
  void addMixins(Iterable<TypeBuilder> mixins);

  /// Returns an [ClassDeclaration] AST representing the builder.
  ClassDeclaration buildClass([Scope scope]);

  /// Sets [extend].
  void setExtends(TypeBuilder extend);
}

/// A marker interface for an AST that could be added to [ClassBuilder].
abstract class ValidClassMember implements AstBuilder {}

class _ClassBuilderImpl extends Object
    with AbstractTypeBuilderMixin, HasAnnotationsMixin
    implements ClassBuilder {
  final _constructors = <ConstructorBuilder>[];
  final _fields = <FieldBuilder, bool>{};
  final _methods = <MethodBuilder, bool>{};

  TypeBuilder _extends;
  final List<TypeBuilder> _with;
  final List<TypeBuilder> _implements;

  final bool _asAbstract;
  final String _name;

  _ClassBuilderImpl(
    this._name, {
    bool asAbstract: false,
    TypeBuilder asExtends,
    Iterable<TypeBuilder> asWith: const [],
    Iterable<TypeBuilder> asImplements: const [],
  })
      : _asAbstract = asAbstract,
        _extends = asExtends,
        _with = asWith.toList(),
        _implements = asImplements.toList();

  @override
  void addConstructor(ConstructorBuilder constructor) {
    _constructors.add(constructor);
  }

  @override
  void addField(FieldBuilder field, {bool asStatic: false}) {
    _fields[field] = asStatic;
  }

  @override
  void addImplement(TypeBuilder interface) {
    _implements.add(interface);
  }

  @override
  void addImplements(Iterable<TypeBuilder> interfaces) {
    _implements.addAll(interfaces);
  }

  @override
  void addMethod(MethodBuilder method, {bool asStatic: false}) {
    _methods[method] = asStatic;
  }

  @override
  void addMixin(TypeBuilder mixin) {
    _with.add(mixin);
  }

  @override
  void addMixins(Iterable<TypeBuilder> mixins) {
    _with.addAll(mixins);
  }

  @override
  ClassDeclaration buildAst([Scope scope]) => buildClass(scope);

  @override
  ClassDeclaration buildClass([Scope scope]) {
    var extend = _extends;
    if (extend == null && _with.isNotEmpty) {
      extend = lib$core.Object;
    }
    final clazz = astFactory.classDeclaration(
      null,
      buildAnnotations(scope),
      _asAbstract ? $abstract : null,
      $class,
      stringIdentifier(_name),
      null,
      extend != null
          ? astFactory.extendsClause(
              $extends,
              extend.buildType(scope),
            )
          : null,
      _with.isNotEmpty
          ? astFactory.withClause(
              $with,
              _with.map/*<TypeName>*/((w) => w.buildType(scope)).toList(),
            )
          : null,
      _implements.isNotEmpty
          ? astFactory.implementsClause(
              $implements,
              _implements.map/*<TypeName>*/((i) => i.buildType(scope)).toList(),
            )
          : null,
      null,
      null,
      null,
    );
    _fields.forEach((field, static) {
      clazz.members.add(field.buildField(static, scope));
    });
    _constructors.forEach((constructor) {
      clazz.members.add(constructor.buildConstructor(
        this,
        scope,
      ));
    });
    _methods.forEach((method, static) {
      clazz.members.add(method.buildMethod(static, scope));
    });
    return clazz;
  }

  @override
  TypeName buildType([Scope scope]) {
    return new TypeBuilder(_name).buildType(scope);
  }

  @override
  void setExtends(TypeBuilder extend) {
    _extends = extend;
  }

  @override
  ExportBuilder toExportBuilder() {
    throw new UnsupportedError('Not supported for ClassBuilder');
  }

  @override
  ImportBuilder toImportBuilder({bool deferred: false, String prefix}) {
    throw new UnsupportedError('Not supported for ClassBuilder');
  }
}

class _TypeNameWrapper implements ValidClassMember {
  final bool extend;
  final bool implement;
  final bool mixin;
  final TypeBuilder type;

  _TypeNameWrapper(
    this.type, {
    this.extend: false,
    this.implement: false,
    this.mixin: false,
  });

  @override
  AstNode buildAst([_]) => throw new UnsupportedError('Use within clazz');
}
