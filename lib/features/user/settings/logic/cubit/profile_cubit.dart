import 'dart:io';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository) : super(const ProfileState.initial());

  TextEditingController nameC = TextEditingController();
  TextEditingController mobileNumberC= TextEditingController();
  final formKey = GlobalKey<FormState>();

  final UserRepository _userRepository;
  // UserModel user;


  Future<void> emitLoadingProfileData() async {
  try {
    // Emit loading state before starting the fetch operation
    emit(const ProfileState.profileLoading());

       // Fetch user details from repository
  var uSerToken= getIt<CacheHelper>().getValueWithKey("userID");
      UserModel user = await _userRepository.fetchStableData(uSerToken);


    // If the fetch is successful, emit the loaded state with the user data
    emit(ProfileState.profileSuccess(user: user));
  } catch (e) {
    print(e.toString());
    // If an error occurs, emit the error state with the error message
    emit(ProfileState.profileError(error: e.toString()));
  }
}

// uploadUserProfilePicture() async {
//   try {
//     final image = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//       maxHeight: 512,
//       maxWidth: 512,
//     );

//     if (image != null) {
//         emit(const ProfileState.changePictureImageLoading());
//         final imageUrl = await _userRepository.uploadImage(
//           'Users/images/Profile/',
//           image,
//         );

//         // Update User Image Record
//         Map<String, dynamic> json = {"profilePicture": imageUrl};
//         await _userRepository.updateStringFiled(json);
//         getIt<CacheHelper>().saveValueWithKey("IMAGEURL", imageUrl);
//         emit(const ProfileState.changePictureImageSuccess());
    
//     }
//   } catch (error) {
//     emit(ProfileState.changePictureImageError(error: error.toString()));
//   }
// }

uploadUserProfilePicture() async {
  var usrid = getIt<CacheHelper>().getValueWithKey("userID");

  try {
    // Step 1: Pick Image
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 512,
      maxWidth: 512,
    );

    // if (pickedImage == null) {
    //   emit(const ProfileState.changePictureImageCancelled());
    //   return;
    // }

    // Step 2: Convert to JPEG if necessary
    File imageFile = File(pickedImage!.path);
    File? jpegImage = await convertToJpeg(imageFile);

    // If conversion failed, return with an error state
    if (jpegImage == null) {
      emit(const ProfileState.changePictureImageError(error: "JPEG conversion failed"));
      return;
    }

    // Step 3: Emit loading state while uploading
    emit(const ProfileState.changePictureImageLoading());

    // Step 4: Upload the converted JPEG image
    final imageUrl = await _userRepository.uploadImage(
      'profile_${usrid}}',
      jpegImage,
    );

    if (imageUrl == null) {
      throw Exception("Failed to upload image");
    }

    // Step 5: Update User Image Record
    Map<String, dynamic> json = {"profilePicture": imageUrl};
    await _userRepository.updateStringFiled(json);

    // Step 6: Cache the image URL
    await getIt<CacheHelper>().saveValueWithKey("IMAGEURL", imageUrl);

    // Step 7: Emit success state
    emit(const ProfileState.changePictureImageSuccess());

  } catch (error) {
    // Emit error state with a descriptive message
    emit(ProfileState.changePictureImageError(error: error.toString()));
  }
}





// Future<XFile> _resizeImage(XFile imageFile) async {
//   List<int> imageBytes = (await FlutterImageCompress.compressWithFile(
//     imageFile.path,
//     minWidth: 800,
//     minHeight: 600,
//     quality: 90,
//   )) as List<int>;

//   String fName = imageFile.name;

//   Directory appDocDir = await getApplicationDocumentsDirectory();
//   String appDocPath = appDocDir.path;
//   String compressedImagePath = '\$appDocPath/\$fName.jpg';
//   await File(compressedImagePath).writeAsBytes(imageBytes);

//   return XFile(compressedImagePath);
// }

  // uploadUserProfilePicture()async {
  //   try{

  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70,maxHeight: 512,maxWidth: 512);
  //     if(image != null){
  //       //Upload image
  //       // imageUploading.value = true;
  //       emit(const ProfileState.changePictureImageLoading());
  //       final imageURl = await _userRepository.uploadImage('Users/images/Profile/', image);
  //       //Update User Image Record
  //       Map<String,dynamic> json = {"profilePicture":imageURl};
  //       await _userRepository.updateStringFiled(json);
  //       getIt<CacheHelper>().saveValueWithKey("IMAGEURL", imageURl);
  //       emit(const ProfileState.changePictureImageSuccess());
  //     }
  //   }
  //   catch(error){
  //     // TLoader.errorSnackBar(title: 'On Snap!',message: "Some thing wrong: $errorM");
  //       emit( ProfileState.changePictureImageError(error:error.toString()));
  //   }
  //   }

    Future<void> updateUserData()async{
      try{
        emit(const ProfileState.profileLoading());

        await _userRepository.updateStringFiled({
          "userName":nameC.text,
          "phoneNumber":mobileNumberC.text
        });

         await _userRepository.fetchUserDetails().then((user) {
           emit(ProfileState.profileSuccess(user: user));
            getIt<CacheHelper>().saveValueWithKey("USERNAME",user.userName );

        });

        

      }catch(error){
        emit(ProfileState.changePictureImageError(error: error.toString()));
         
      }

    }

         void clearUserData() {
    emit(ProfileState.initial());
  }


  


}
