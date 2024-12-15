import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_owner_store_state.freezed.dart';
@freezed
class RegisterOwnerStoreState with _$RegisterOwnerStoreState {
  const factory RegisterOwnerStoreState.initial() = Initial;
  const factory RegisterOwnerStoreState.successRegister() = SuccessRegister;
  const factory RegisterOwnerStoreState.failureRegister({required String error}) = FailureRegister;
  const factory RegisterOwnerStoreState.loadingRegister() = LoadingRegister;
    const factory RegisterOwnerStoreState.imageStoreinital() = ImageStoreinital;
  const factory RegisterOwnerStoreState.imageStoreLoading() = ImageStoreLoading;
  const factory RegisterOwnerStoreState.imageStoreSelected({required File image}) = ImageStoreSelected;
    const factory RegisterOwnerStoreState.notSelectedImage() = NotSelectedImage;


}