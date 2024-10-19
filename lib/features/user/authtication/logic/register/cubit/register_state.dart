part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;

  const factory RegisterState.registerLoading()= RegisterLoading;
  const factory RegisterState.registerSuccess()= RegisterSuccess;
  const factory RegisterState.registerError({required String error})= RegisterError;








}
