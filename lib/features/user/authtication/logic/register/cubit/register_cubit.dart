// ignore_for_file: prefer_const_constructors, empty_catches

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {


  final AuthenticationRepository _authenticationRepository;

  
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
 // other Atrribute for Login For Stotr Owener ...
  TextEditingController linkOfStore = TextEditingController();   
  final formKey = GlobalKey<FormState>();



  RegisterCubit(this._authenticationRepository) : super(RegisterState.initial());


  void emitRegisterStates() async{
    try {
    emit(RegisterState.registerLoading());

    //register User 
    final userCredential = await _authenticationRepository.registerWithEmilAndPassword(emailController.text.trim(), passwordController.text.trim());

    //Save in Firebase Firestore 
    final newUser = UserModel(id: userCredential.user!.uid, userName: nameController.text.trim(), email: emailController.text.trim(), phoneNumber: phoneController.text.trim(), profilePicture: "", userType: "USER" , storeLink: "");
    final userRepostiry = getIt<UserRepository>();
    await userRepostiry.storeUserRecord(newUser);
  await Future.wait([
        getIt<CacheHelper>().saveValueWithKey("USERNAME", newUser.userName),
        getIt<CacheHelper>().saveValueWithKey("IMAGEURL", newUser.profilePicture),
        getIt<CacheHelper>().saveValueWithKey("EMAIL", newUser.email),
        getIt<CacheHelper>().saveValueWithKey("MOBILENUMBER", newUser.phoneNumber)
      ]);
    // getIt<CacheHelper>().saveValueWithKey("","");
    emit(RegisterState.registerSuccess());
    }catch(error){
      emit(RegisterState.registerError(error: error.toString()));
    }

  }
}

