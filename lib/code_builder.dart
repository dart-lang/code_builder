// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

export 'src/allocator.dart' show Allocator;
export 'src/base.dart' show Spec;
export 'src/emitter.dart' show DartEmitter;
export 'src/matchers.dart' show equalsDart;
export 'src/specs/annotation.dart' show Annotation, AnnotationBuilder;
export 'src/specs/class.dart' show Class, ClassBuilder;
export 'src/specs/code.dart' show Code, StaticCode, ScopedCode;
export 'src/specs/code/expression.dart'
    show
        Expression,
        literal,
        literalNull,
        literalBool,
        literalTrue,
        literalFalse;
export 'src/specs/constructor.dart' show Constructor, ConstructorBuilder;
export 'src/specs/directive.dart'
    show Directive, DirectiveType, DirectiveBuilder;
export 'src/specs/field.dart' show Field, FieldBuilder, FieldModifier;
export 'src/specs/file.dart' show File, FileBuilder;
export 'src/specs/method.dart'
    show
        Method,
        MethodBuilder,
        MethodModifier,
        MethodType,
        Parameter,
        ParameterBuilder;
export 'src/specs/reference.dart' show Reference;
export 'src/specs/type_reference.dart' show TypeReference, TypeReferenceBuilder;
