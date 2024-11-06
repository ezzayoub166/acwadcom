
// UserState.dart
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/models/user_model.dart';

abstract class StoreDataState {}

class StoreDataInitial extends StoreDataState {}

class StoreDataLoading extends StoreDataState {}

class StoreDataLoaded extends StoreDataState {
  final UserModel user;
  StoreDataLoaded(this.user);
}

class StoreDataError extends StoreDataState {
  final String message;
  StoreDataError(this.message);
}

class StoreDataImageUploading extends StoreDataState {}

class UserImageUploadSuccess extends StoreDataState {
  final UserModel userModel;
  UserImageUploadSuccess(this.userModel);
}