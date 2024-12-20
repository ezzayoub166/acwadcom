// ignore_for_file: empty_catches

import 'dart:async';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository, this._userRepository)
      : super(const LoginState.initial());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailControllerForget = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final forgetPasswordFormKey = GlobalKey<FormState>();

  emitLogIn(context) async {
    try {
      emit(const LoginState.loading());
      final UserCredential userCredential =
          await _authenticationRepository.loginWithEmilAndPassword(
              emailController.text.trim(), passwordController.text.trim());
      final fetchedUser =
          await _userRepository.fetchStableData(userCredential.user?.uid);
      // Save user details in cache concurrently
      await Future.wait([
        getIt<CacheHelper>().saveValueWithKey("USERNAME", fetchedUser.userName),
        getIt<CacheHelper>()
            .saveValueWithKey("IMAGEURL", fetchedUser.profilePicture),
        getIt<CacheHelper>().saveValueWithKey("EMAIL", fetchedUser.email),
        getIt<CacheHelper>()
            .saveValueWithKey("MOBILENUMBER", fetchedUser.phoneNumber),
        getIt<CacheHelper>().saveValueWithKey("tYPEUSER", fetchedUser.userType),
      ]);

      isLoggedInUser = true;
      tYPEUSER = fetchedUser.userType;
      emit(const LoginState.success());
    } catch (errorMsg) {
      emit(LoginState.faluire(error: errorMsg.toString()));
    }
  }

  emitLogInOwnerApp(context) async {
    try {
      emit(const LoginState.loading());

      UserCredential userCredential =
          await _authenticationRepository.loginWithEmilAndPassword(
              emailController.text.trim(), passwordController.text.trim());

          final fetchedUser = await _userRepository.fetchStableData(userCredential.user?.uid);

            await Future.wait([
        getIt<CacheHelper>().saveValueWithKey("tYPEUSER", fetchedUser.userType),
      ]);

      isLoggedInUser = true;
      tYPEUSER = fetchedUser.userType;    
      String userId = userCredential.user!.uid;
      emit(LoginState.successForOwner(userId: userId));
    } catch (onError) {
      emit(LoginState.faluire(error: onError.toString()));
    }
  }

  Future<void> emitLogInByGoogle(context) async {
    try {
      emit(const LoginState.loading());
      final userCredential = await _authenticationRepository.singInWithGoogle();

      final isRegister =  await _userRepository.checkIFLoggedBefore(userCredential?.user?.uid);

      if(isRegister == false){
        //For Sing in first time and new User .....
       
       // Save user details in cache concurrently
      await _userRepository.saveUserRecord(userCredential);
      await Future.wait([
        getIt<CacheHelper>().saveValueWithKey("USERNAME", userCredential?.user?.displayName),
        getIt<CacheHelper>()
            .saveValueWithKey("IMAGEURL", userCredential?.user?.photoURL),
        getIt<CacheHelper>().saveValueWithKey("EMAIL", userCredential?.user?.email),
        getIt<CacheHelper>()
            .saveValueWithKey("MOBILENUMBER", userCredential?.user?.phoneNumber ?? ""),
        getIt<CacheHelper>().saveValueWithKey("tYPEUSER", tYPEUSER),
      ]);

      isLoggedInUser = true;
      emit(const LoginState.success());
      }else{

        //this user is exist 
        //and we deal on his attribute .... not dialog 
      UserModel existUser = await _userRepository.fetchStableData(userCredential?.user?.uid);

      await Future.wait([
        getIt<CacheHelper>().saveValueWithKey("USERNAME", existUser.userName),
            getIt<CacheHelper>().saveValueWithKey("IMAGEURL", existUser.profilePicture),
        getIt<CacheHelper>().saveValueWithKey("EMAIL", existUser.email),
        getIt<CacheHelper>()
            .saveValueWithKey("MOBILENUMBER",existUser.phoneNumber),
        getIt<CacheHelper>().saveValueWithKey("tYPEUSER", existUser.userType),
      ]);

      isLoggedInUser = true;
      tYPEUSER = existUser.userType;
      emit(const LoginState.success());
      }

    } catch (error) {
      emit(LoginState.faluire(error: error.toString()));
    }
  }

  sendPasswordResetEmail() async {
    try {
      // Start Loading
      emit(const LoginState.loading());

      await _authenticationRepository
          .sendPasswordResetEmail(emailControllerForget.text.trim());

      // Emit Success State
      emit(const LoginState.success());

      // Optionally, you can also display a message or redirect the user if needed
      // TLoader.successSnackBar(title: 'Email Sent',message: 'Email Link sent to Reset Your Password'.tr);
    } catch (error) {
      // Emit Failure State with the error message
      emit(LoginState.faluire(error: error.toString()));
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      //Start Loading

      emit(const LoginState.loading());
      await _authenticationRepository.sendPasswordResetEmail(email);
      emit(const LoginState.success());
    } catch (error) {
      emit(LoginState.faluire(error: error.toString()));
    }
  }
}
