import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/register_owner/register_owner_store_state.dart';

class RegisterOwnerStoreCubit extends Cubit<RegisterOwnerStoreState> {
  RegisterOwnerStoreCubit(this._authenticationRepository, this._userRepository)
      : super(const RegisterOwnerStoreState.initial());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  TextEditingController nameOfStoreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  // other Atrribute for Login For Stotr Owener ...
  TextEditingController linkOfStore = TextEditingController();
  TextEditingController deatilsStore = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;
  String url = ""; 

  void emitRegisterStates() async {
    try {
      // emit(RegisterState.registerLoading());
      emit(const RegisterOwnerStoreState.loadingRegister());

      //register User
      final userCredential =
          await _authenticationRepository.registerWithEmilAndPassword(
              emailController.text.trim(), passwordController.text.trim());

      // if(url.selectedImage){
        url = await _userRepository.uploadImage('Users/images/Profile/' , _selectedImage!);
      // }        

      //Save in Firebase Firestore

      final newUser = UserModel(
          id: userCredential.user!.uid,
          userName: nameOfStoreController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          profilePicture:url,
          userType: "STOREOWNER",
          storeLink: linkOfStore.text,
          deatilsForStore: deatilsStore.text.trim()
          );
      // final userRepostiry = getIt<UserRepository>();
      await _userRepository.storeUserRecord(newUser);
          await Future.wait([
        getIt<CacheHelper>().saveValueWithKey("USERNAME", newUser.userName),
        getIt<CacheHelper>().saveValueWithKey("IMAGEURL", newUser.profilePicture),
        getIt<CacheHelper>().saveValueWithKey("EMAIL", newUser.email),
        getIt<CacheHelper>().saveValueWithKey("MOBILENUMBER", newUser.phoneNumber)
      ]);
      emit(const RegisterOwnerStoreState.successRegister());
    } catch (error) {
      emit(RegisterOwnerStoreState.failureRegister(error: error.toString()));
    }
  }

  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
            emit(const RegisterOwnerStoreState.imageStoreLoading());
      _selectedImage = image;
      emit(RegisterOwnerStoreState.imageStoreSelected(image: image));
    }
  }

  
}
