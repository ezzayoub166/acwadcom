// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'avatar_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AvatarState {
  String get username => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username, String imageUrl) fetchNameImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username, String imageUrl)? fetchNameImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username, String imageUrl)? fetchNameImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchNameImage value) fetchNameImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchNameImage value)? fetchNameImage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchNameImage value)? fetchNameImage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AvatarStateCopyWith<AvatarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvatarStateCopyWith<$Res> {
  factory $AvatarStateCopyWith(
          AvatarState value, $Res Function(AvatarState) then) =
      _$AvatarStateCopyWithImpl<$Res, AvatarState>;
  @useResult
  $Res call({String username, String imageUrl});
}

/// @nodoc
class _$AvatarStateCopyWithImpl<$Res, $Val extends AvatarState>
    implements $AvatarStateCopyWith<$Res> {
  _$AvatarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchNameImageImplCopyWith<$Res>
    implements $AvatarStateCopyWith<$Res> {
  factory _$$FetchNameImageImplCopyWith(_$FetchNameImageImpl value,
          $Res Function(_$FetchNameImageImpl) then) =
      __$$FetchNameImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String imageUrl});
}

/// @nodoc
class __$$FetchNameImageImplCopyWithImpl<$Res>
    extends _$AvatarStateCopyWithImpl<$Res, _$FetchNameImageImpl>
    implements _$$FetchNameImageImplCopyWith<$Res> {
  __$$FetchNameImageImplCopyWithImpl(
      _$FetchNameImageImpl _value, $Res Function(_$FetchNameImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? imageUrl = null,
  }) {
    return _then(_$FetchNameImageImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FetchNameImageImpl implements FetchNameImage {
  const _$FetchNameImageImpl({required this.username, required this.imageUrl});

  @override
  final String username;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'AvatarState.fetchNameImage(username: $username, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchNameImageImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchNameImageImplCopyWith<_$FetchNameImageImpl> get copyWith =>
      __$$FetchNameImageImplCopyWithImpl<_$FetchNameImageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username, String imageUrl) fetchNameImage,
  }) {
    return fetchNameImage(username, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String username, String imageUrl)? fetchNameImage,
  }) {
    return fetchNameImage?.call(username, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username, String imageUrl)? fetchNameImage,
    required TResult orElse(),
  }) {
    if (fetchNameImage != null) {
      return fetchNameImage(username, imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchNameImage value) fetchNameImage,
  }) {
    return fetchNameImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchNameImage value)? fetchNameImage,
  }) {
    return fetchNameImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchNameImage value)? fetchNameImage,
    required TResult orElse(),
  }) {
    if (fetchNameImage != null) {
      return fetchNameImage(this);
    }
    return orElse();
  }
}

abstract class FetchNameImage implements AvatarState {
  const factory FetchNameImage(
      {required final String username,
      required final String imageUrl}) = _$FetchNameImageImpl;

  @override
  String get username;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$FetchNameImageImplCopyWith<_$FetchNameImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
