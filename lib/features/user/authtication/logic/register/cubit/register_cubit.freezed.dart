// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegisterState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() registerLoading,
    required TResult Function() registerSuccess,
    required TResult Function(String error) registerError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? registerLoading,
    TResult? Function()? registerSuccess,
    TResult? Function(String error)? registerError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? registerLoading,
    TResult Function()? registerSuccess,
    TResult Function(String error)? registerError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(RegisterLoading value) registerLoading,
    required TResult Function(RegisterSuccess value) registerSuccess,
    required TResult Function(RegisterError value) registerError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(RegisterLoading value)? registerLoading,
    TResult? Function(RegisterSuccess value)? registerSuccess,
    TResult? Function(RegisterError value)? registerError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(RegisterLoading value)? registerLoading,
    TResult Function(RegisterSuccess value)? registerSuccess,
    TResult Function(RegisterError value)? registerError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res, RegisterState>;
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res, $Val extends RegisterState>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'RegisterState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() registerLoading,
    required TResult Function() registerSuccess,
    required TResult Function(String error) registerError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? registerLoading,
    TResult? Function()? registerSuccess,
    TResult? Function(String error)? registerError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? registerLoading,
    TResult Function()? registerSuccess,
    TResult Function(String error)? registerError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(RegisterLoading value) registerLoading,
    required TResult Function(RegisterSuccess value) registerSuccess,
    required TResult Function(RegisterError value) registerError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(RegisterLoading value)? registerLoading,
    TResult? Function(RegisterSuccess value)? registerSuccess,
    TResult? Function(RegisterError value)? registerError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(RegisterLoading value)? registerLoading,
    TResult Function(RegisterSuccess value)? registerSuccess,
    TResult Function(RegisterError value)? registerError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements RegisterState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$RegisterLoadingImplCopyWith<$Res> {
  factory _$$RegisterLoadingImplCopyWith(_$RegisterLoadingImpl value,
          $Res Function(_$RegisterLoadingImpl) then) =
      __$$RegisterLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterLoadingImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterLoadingImpl>
    implements _$$RegisterLoadingImplCopyWith<$Res> {
  __$$RegisterLoadingImplCopyWithImpl(
      _$RegisterLoadingImpl _value, $Res Function(_$RegisterLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RegisterLoadingImpl implements RegisterLoading {
  const _$RegisterLoadingImpl();

  @override
  String toString() {
    return 'RegisterState.registerLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() registerLoading,
    required TResult Function() registerSuccess,
    required TResult Function(String error) registerError,
  }) {
    return registerLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? registerLoading,
    TResult? Function()? registerSuccess,
    TResult? Function(String error)? registerError,
  }) {
    return registerLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? registerLoading,
    TResult Function()? registerSuccess,
    TResult Function(String error)? registerError,
    required TResult orElse(),
  }) {
    if (registerLoading != null) {
      return registerLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(RegisterLoading value) registerLoading,
    required TResult Function(RegisterSuccess value) registerSuccess,
    required TResult Function(RegisterError value) registerError,
  }) {
    return registerLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(RegisterLoading value)? registerLoading,
    TResult? Function(RegisterSuccess value)? registerSuccess,
    TResult? Function(RegisterError value)? registerError,
  }) {
    return registerLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(RegisterLoading value)? registerLoading,
    TResult Function(RegisterSuccess value)? registerSuccess,
    TResult Function(RegisterError value)? registerError,
    required TResult orElse(),
  }) {
    if (registerLoading != null) {
      return registerLoading(this);
    }
    return orElse();
  }
}

abstract class RegisterLoading implements RegisterState {
  const factory RegisterLoading() = _$RegisterLoadingImpl;
}

/// @nodoc
abstract class _$$RegisterSuccessImplCopyWith<$Res> {
  factory _$$RegisterSuccessImplCopyWith(_$RegisterSuccessImpl value,
          $Res Function(_$RegisterSuccessImpl) then) =
      __$$RegisterSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterSuccessImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterSuccessImpl>
    implements _$$RegisterSuccessImplCopyWith<$Res> {
  __$$RegisterSuccessImplCopyWithImpl(
      _$RegisterSuccessImpl _value, $Res Function(_$RegisterSuccessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RegisterSuccessImpl implements RegisterSuccess {
  const _$RegisterSuccessImpl();

  @override
  String toString() {
    return 'RegisterState.registerSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisterSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() registerLoading,
    required TResult Function() registerSuccess,
    required TResult Function(String error) registerError,
  }) {
    return registerSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? registerLoading,
    TResult? Function()? registerSuccess,
    TResult? Function(String error)? registerError,
  }) {
    return registerSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? registerLoading,
    TResult Function()? registerSuccess,
    TResult Function(String error)? registerError,
    required TResult orElse(),
  }) {
    if (registerSuccess != null) {
      return registerSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(RegisterLoading value) registerLoading,
    required TResult Function(RegisterSuccess value) registerSuccess,
    required TResult Function(RegisterError value) registerError,
  }) {
    return registerSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(RegisterLoading value)? registerLoading,
    TResult? Function(RegisterSuccess value)? registerSuccess,
    TResult? Function(RegisterError value)? registerError,
  }) {
    return registerSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(RegisterLoading value)? registerLoading,
    TResult Function(RegisterSuccess value)? registerSuccess,
    TResult Function(RegisterError value)? registerError,
    required TResult orElse(),
  }) {
    if (registerSuccess != null) {
      return registerSuccess(this);
    }
    return orElse();
  }
}

abstract class RegisterSuccess implements RegisterState {
  const factory RegisterSuccess() = _$RegisterSuccessImpl;
}

/// @nodoc
abstract class _$$RegisterErrorImplCopyWith<$Res> {
  factory _$$RegisterErrorImplCopyWith(
          _$RegisterErrorImpl value, $Res Function(_$RegisterErrorImpl) then) =
      __$$RegisterErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$RegisterErrorImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterErrorImpl>
    implements _$$RegisterErrorImplCopyWith<$Res> {
  __$$RegisterErrorImplCopyWithImpl(
      _$RegisterErrorImpl _value, $Res Function(_$RegisterErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$RegisterErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterErrorImpl implements RegisterError {
  const _$RegisterErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'RegisterState.registerError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterErrorImplCopyWith<_$RegisterErrorImpl> get copyWith =>
      __$$RegisterErrorImplCopyWithImpl<_$RegisterErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() registerLoading,
    required TResult Function() registerSuccess,
    required TResult Function(String error) registerError,
  }) {
    return registerError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? registerLoading,
    TResult? Function()? registerSuccess,
    TResult? Function(String error)? registerError,
  }) {
    return registerError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? registerLoading,
    TResult Function()? registerSuccess,
    TResult Function(String error)? registerError,
    required TResult orElse(),
  }) {
    if (registerError != null) {
      return registerError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(RegisterLoading value) registerLoading,
    required TResult Function(RegisterSuccess value) registerSuccess,
    required TResult Function(RegisterError value) registerError,
  }) {
    return registerError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(RegisterLoading value)? registerLoading,
    TResult? Function(RegisterSuccess value)? registerSuccess,
    TResult? Function(RegisterError value)? registerError,
  }) {
    return registerError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(RegisterLoading value)? registerLoading,
    TResult Function(RegisterSuccess value)? registerSuccess,
    TResult Function(RegisterError value)? registerError,
    required TResult orElse(),
  }) {
    if (registerError != null) {
      return registerError(this);
    }
    return orElse();
  }
}

abstract class RegisterError implements RegisterState {
  const factory RegisterError({required final String error}) =
      _$RegisterErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$RegisterErrorImplCopyWith<_$RegisterErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
