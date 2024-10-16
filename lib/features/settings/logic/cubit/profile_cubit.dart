import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository) : super(const ProfileState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final UserRepository _userRepository;
  // UserModel user;


  Future<void> emitLoadingProfileData() async {
  try {
    // Emit loading state before starting the fetch operation
    emit(const ProfileState.profileLoading());

    // Fetch user details from repository
    final user = await _userRepository.fetchUserDetails();

    // If the fetch is successful, emit the loaded state with the user data
    emit(ProfileState.profileSuccess(user: user));
  } catch (e) {
    // If an error occurs, emit the error state with the error message
    emit(ProfileState.profileError(error: e.toString()));
  }
}

  uploadUserProfilePicture()async {
    try{

      final image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70,maxHeight: 512,maxWidth: 512);
      if(image != null){
        //Upload image
        // imageUploading.value = true;
        emit(const ProfileState.changePictureImageLoading());
        final imageURl = await _userRepository.uploadImage('Users/images/Profile/', image);
        //Update User Image Record
        Map<String,dynamic> json = {"profilePicture":imageURl};
        await _userRepository.updateStringFiled(json);
        getIt<CacheHelper>().saveValueWithKey("IMAGEURL", imageURl);
        emit(const ProfileState.changePictureImageSuccess());
      }
    }
    catch(error){
      // TLoader.errorSnackBar(title: 'On Snap!',message: "Some thing wrong: $errorM");
        emit( ProfileState.changePictureImageError(error:error.toString()));
    }

    }

  


}
