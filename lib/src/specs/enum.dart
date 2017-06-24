// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/dartdoc.dart';
import '../utils/assert.dart';
import '../visitor.dart';

/// A generated enum definition.
@immutable
class EnumSpec extends Spec with DartDocMixin {
  @override
  final String dartDoc;
  final String name;

  EnumSpec._({
    @required this.dartDoc,
    @required this.name,
  });

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitEnum(this);
}

EnumSpecBuilder enumBuilder(String name) => new EnumSpecBuilder._(
      notNull(name, 'name'),
    );

@immutable
class EnumSpecBuilder extends SpecBuilder<EnumSpec> with DartDocBuilderMixin {
  final String _name;

  EnumSpecBuilder._(this._name);

  @override
  EnumSpec build() => new EnumSpec._(
        name: _name,
        dartDoc: dartDoc.toString(),
      );
}
