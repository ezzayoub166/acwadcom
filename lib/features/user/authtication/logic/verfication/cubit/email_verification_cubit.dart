import 'dart:async';

import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_verification_state.dart';
part 'email_verification_cubit.freezed.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final AuthenticationRepository _authenticationRepository;

  EmailVerificationCubit(this._authenticationRepository) : super(EmailVerificationState.initial());

  Future<void> sendEmailVerification() async {
    try {
      emit(EmailVerificationState.loading());
      await _authenticationRepository.sendEmailVerification();
      emit(EmailVerificationState.success(message: "Verification email sent"));
    } catch (e) {
      emit(EmailVerificationState.error(message: e.toString()));
    }
  }

  void startEmailVerificationTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        emit(EmailVerificationState.verified());
      }
    });
  }

  Future<void> checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;

      if (updatedUser!.emailVerified) {
        emit(EmailVerificationState.verified());
      } else {
        emit(EmailVerificationState.notVerified());
      }
    } else {
      emit(EmailVerificationState.error(message: "No current user"));
    }
  }
}