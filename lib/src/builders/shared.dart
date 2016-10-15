import 'package:code_builder/code_builder.dart';

export 'shared/annotations_mixin.dart';
export 'shared/parameters_mixin.dart';
export 'shared/statements_mixin.dart';

/// Marker interface for valid members of [ConstructorBuilder].
abstract class ValidConstructorMember implements AstBuilder {
  ValidConstructorMember._doNotExtend();
}

/// Marker interface for valid members of a [ParameterBuilder].
abstract class ValidParameterMember implements AstBuilder {
  ValidParameterMember._doNotExtend();
}
