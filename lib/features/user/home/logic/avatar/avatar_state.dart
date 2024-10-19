part of 'avatar_cubit.dart';

@freezed
class AvatarState with _$AvatarState {
  const factory AvatarState.fetchNameImage({
    required String username,
    required String imageUrl,
  }) = FetchNameImage;
}