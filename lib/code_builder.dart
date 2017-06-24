// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

export 'src/base.dart' show Spec;
export 'src/emitter.dart' show DartEmitter;
export 'src/matchers.dart' show equalsDart;
export 'src/specs/class.dart' show Class, ClassBuilder;
export 'src/specs/code.dart' show Code, CodeBuilder;
export 'src/specs/method.dart'
    show Method, MethodBuilder, Parameter, ParameterBuilder;
export 'src/specs/reference.dart' show Reference;
export 'src/specs/type_reference.dart' show TypeReference, TypeReferenceBuilder;
export 'src/visitors.dart'
    show
        GeneralizingSpecVisitor,
        RecursiveSpecVisitor,
        SpecVisitor,
        SimpleSpecVisitor;
