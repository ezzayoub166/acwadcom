part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

    const factory ProfileState.profileLoading()= ProfileLoading;
  const factory ProfileState.profileSuccess({required UserModel user})= ProfileSuccess;
  const factory ProfileState.profileError({required String error})= ProfileError;

    const factory ProfileState.changePictureImageLoading()= ChangePictureImage;
    const factory ProfileState.changePictureImageSuccess()= ChangePictureImageSuccess;
    const factory ProfileState.changePictureImageError({required String error})= ChangePictureImageError;


}
