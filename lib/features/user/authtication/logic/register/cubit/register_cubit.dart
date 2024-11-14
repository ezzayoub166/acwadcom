// ignore_for_file: prefer_const_constructors, empty_catches

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../helpers/constants/extenstions.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  // other Atrribute for Login For Stotr Owener ...
  TextEditingController linkOfStore = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterCubit(this._authenticationRepository, this._userRepository)
      : super(RegisterState.initial());

  void emitRegisterStates() async {
    emit(RegisterState.initial());

    try {
      emit(RegisterState.registerLoading());

      //register User
      final userCredential =
          await _authenticationRepository.registerWithEmilAndPassword(
              emailController.text.trim(), passwordController.text.trim());

      //Save in Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          userName: nameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          profilePicture: "",
          userType: "USER",
          storeLink: "");
      final userRepostiry = getIt<UserRepository>();
      await userRepostiry.storeUserRecord(newUser);
      await Future.wait([
        getIt<CacheHelper>().saveValueWithKey("USERNAME", newUser.userName),
        getIt<CacheHelper>()
            .saveValueWithKey("IMAGEURL", newUser.profilePicture),
        getIt<CacheHelper>().saveValueWithKey("EMAIL", newUser.email),
        getIt<CacheHelper>()
            .saveValueWithKey("MOBILENUMBER", newUser.phoneNumber)
      ]);
      // getIt<CacheHelper>().saveValueWithKey("","");
      tYPEUSER = "USER";
      isLoggedInUser = true;
      emit(RegisterState.registerSuccess());
    } catch (error) {
      emit(RegisterState.registerError(error: error.toString()));
    }
  }

  Future<void> emitLogInByGoogle(context) async {
    try {
      emit(RegisterState.registerLoading());
      final userCredential = await _authenticationRepository.singInWithGoogle();

      final isRegister =
          await _userRepository.checkIFLoggedBefore(userCredential?.user?.uid);

      if (isRegister == false) {
        //For Sing in first time and new User .....

        // Save user details in cache concurrently
        await _userRepository.saveUserRecord(userCredential);
        await Future.wait([
          getIt<CacheHelper>()
              .saveValueWithKey("USERNAME", userCredential?.user?.displayName),
          getIt<CacheHelper>()
              .saveValueWithKey("IMAGEURL", userCredential?.user?.photoURL),
          getIt<CacheHelper>()
              .saveValueWithKey("EMAIL", userCredential?.user?.email),
          getIt<CacheHelper>().saveValueWithKey(
              "MOBILENUMBER", userCredential?.user?.phoneNumber ?? ""),
          getIt<CacheHelper>().saveValueWithKey("tYPEUSER", tYPEUSER),
        ]);

        isLoggedInUser = true;
        emit(RegisterState.registerGoogleSuccess());
      } else {
        //this user is exist
        //and we deal on his attribute .... not dialog
        UserModel existUser =
            await _userRepository.fetchStableData(userCredential?.user?.uid);

        await Future.wait([
          getIt<CacheHelper>().saveValueWithKey("USERNAME", existUser.userName),
          getIt<CacheHelper>()
              .saveValueWithKey("IMAGEURL", existUser.profilePicture),
          getIt<CacheHelper>().saveValueWithKey("EMAIL", existUser.email),
          getIt<CacheHelper>()
              .saveValueWithKey("MOBILENUMBER", existUser.phoneNumber),
          getIt<CacheHelper>().saveValueWithKey("tYPEUSER", existUser.userType),
        ]);

        isLoggedInUser = true;
        tYPEUSER = existUser.userType;
        emit(RegisterState.registerGoogleSuccess());
      }
    } catch (error) {
      emit(RegisterState.registerError(error: error.toString()));
    }
  }
}
