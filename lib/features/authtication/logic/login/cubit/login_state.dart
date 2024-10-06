part of 'login_cubit.dart';


@freezed
class LoginState<T> with _$LoginState<T> {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = Loading;
  const factory LoginState.success() = Success<T>;
  const factory LoginState.faluire({required String error}) = Error;

  
}
