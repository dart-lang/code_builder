// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

export 'src/allocator.dart' show Allocator;
export 'src/base.dart' show Spec, lazySpec;
export 'src/emitter.dart' show DartEmitter;
export 'src/matchers.dart' show EqualsDart, equalsDart;
export 'src/specs/class.dart' show Class, ClassBuilder, ClassModifier;
export 'src/specs/code.dart'
    show Block, BlockBuilder, Code, ScopedCode, StaticCode, lazyCode;
export 'src/specs/constructor.dart' show Constructor, ConstructorBuilder;
export 'src/specs/directive.dart'
    show Directive, DirectiveBuilder, DirectiveType;
export 'src/specs/enum.dart'
    show Enum, EnumBuilder, EnumValue, EnumValueBuilder;
export 'src/specs/expression.dart'
    show
        BinaryExpression,
        CodeExpression,
        Expression,
        ExpressionEmitter,
        ExpressionVisitor,
        InvokeExpression,
        InvokeExpressionType,
        LiteralExpression,
        LiteralListExpression,
        ParenthesizedExpression,
        ToCodeExpression,
        declareConst,
        declareFinal,
        declareVar,
        literal,
        literalBool,
        literalConstList,
        literalConstMap,
        literalConstRecord,
        literalConstSet,
        literalFalse,
        literalList,
        literalMap,
        literalNull,
        literalNullSafeSpread,
        literalNum,
        literalRecord,
        literalSet,
        literalSpread,
        literalString,
        literalTrue;
export 'src/specs/extension.dart' show Extension, ExtensionBuilder;
export 'src/specs/extension_type.dart' show ExtensionType, ExtensionTypeBuilder;
export 'src/specs/field.dart' show Field, FieldBuilder, FieldModifier;
export 'src/specs/library.dart' show Library, LibraryBuilder;
export 'src/specs/method.dart'
    show
        Method,
        MethodBuilder,
        MethodModifier,
        MethodType,
        Parameter,
        ParameterBuilder;
export 'src/specs/mixin.dart' show Mixin, MixinBuilder;
export 'src/specs/reference.dart' show Reference, refer;
export 'src/specs/type_function.dart' show FunctionType, FunctionTypeBuilder;
export 'src/specs/type_record.dart' show RecordType, RecordTypeBuilder;
export 'src/specs/type_reference.dart' show TypeReference, TypeReferenceBuilder;
export 'src/specs/typedef.dart' show TypeDef, TypeDefBuilder;
