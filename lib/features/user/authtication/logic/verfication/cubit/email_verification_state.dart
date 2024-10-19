part of 'email_verification_cubit.dart';

@freezed
class EmailVerificationState with _$EmailVerificationState {
  const factory EmailVerificationState.initial() = _Initial;
  const factory EmailVerificationState.loading() = _Loading;
  const factory EmailVerificationState.success({required String message}) = _Success;
  const factory EmailVerificationState.error({required String message}) = _Error;
  const factory EmailVerificationState.verified() = _Verified;
  const factory EmailVerificationState.notVerified() = _NotVerified;
}

