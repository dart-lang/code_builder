import 'package:analyzer/analyzer.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/tokens.dart';

/// A builder that supports adding annotations as metadata.
abstract class HasParameters {
  /// Lazily adds [parameter] as a builder for a named parameter.
  ///
  /// When the AST is built, [ParameterBuilder] is also built.
  void addNamedParameter(ParameterBuilder parameter);

  /// Lazily adds [parameters] as builders for named parameters.
  ///
  /// When the AST is built, [ParameterBuilder] is also built.
  void addNamedParameters(Iterable<ParameterBuilder> parameters);

  /// Lazily adds [parameter] as a builder for a positional parameter.
  ///
  /// When the AST is built, [ParameterBuilder] is also built.
  void addPositionalParameter(ParameterBuilder parameter);

  /// Lazily adds [parameters] as builders for positional parameters.
  ///
  /// When the AST is built, [ParameterBuilder] is also built.
  void addPositionalParameters(Iterable<ParameterBuilder> parameters);
}

/// Associates a [parameter] with the [kind] that should be emitted.
///
/// Convenience class for users of [HasParametersMixin].
class ParameterWithKind {
  /// Either a named or positional parameter.
  final ParameterKind kind;

  /// Parameter builder.
  final ParameterBuilder parameter;

  ParameterWithKind._positional(this.parameter)
      : kind = ParameterKind.POSITIONAL;

  ParameterWithKind._named(this.parameter) : kind = ParameterKind.NAMED;
}

/// A mixin to add [addAnnotation] and [getAnnotations] to a builder.
abstract class HasParametersMixin implements HasParameters {
  final List<ParameterWithKind> _parameters = <ParameterWithKind>[];

  @override
  void addNamedParameter(ParameterBuilder parameter) {
    _parameters.add(new ParameterWithKind._named(parameter));
  }

  @override
  void addNamedParameters(Iterable<ParameterBuilder> parameters) {
    parameters.forEach(addNamedParameter);
  }

  @override
  void addPositionalParameter(ParameterBuilder parameter) {
    _parameters.add(new ParameterWithKind._positional(parameter));
  }

  @override
  void addPositionalParameters(Iterable<ParameterBuilder> parameters) {
    parameters.forEach(addPositionalParameter);
  }

  /// Clones all added parameters to [mixin].
  void cloneParametersTo(HasParameters mixin) {
    for (final parameter in _parameters) {
      if (parameter.kind == ParameterKind.POSITIONAL) {
        mixin.addPositionalParameter(parameter.parameter);
      } else {
        mixin.addNamedParameter(parameter.parameter);
      }
    }
  }

  /// Returns a built list of [Annotation] ASTs.
  FormalParameterList toFormalParameterList([Scope scope = Scope.identity]) {
    return new FormalParameterList(
      $openParen,
      _parameters.map/*<FormalParameter>*/((p) {
        if (p.kind == ParameterKind.POSITIONAL) {
          return p.parameter.buildPositional(scope);
        } else {
          return p.parameter.buildNamed(scope);
        }
      }).toList(),
      null,
      null,
      $closeParen,
    );
  }
}
