import 'dart:io';

import 'package:acwadcom/features/ownerStore/features/store_data/logic/store_data_state.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:acwadcom/helpers/util/extenstions.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class StoreDataCubit extends Cubit<StoreDataState> {
  StoreDataCubit(this._userRepository) : super(StoreDataInitial());

  final UserRepository _userRepository;
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController deatilsStoreController = TextEditingController();
  final TextEditingController storeLinkController = TextEditingController();

  Future<void> fetchUserData() async {
    emit(StoreDataLoading());
    try {
      var uSerToken = getIt<CacheHelper>().getValueWithKey("userID");
      UserModel user = await _userRepository.fetchStableData(uSerToken);
      emit(StoreDataLoaded(user));
    } catch (e) {
      emit(StoreDataError(e.toString()));
    }
  }

  // Future<void> uploadUserProfilePicture() async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 70,
  //       maxHeight: 512,
  //       maxWidth: 512,
  //     );
  //     if (image != null) {
  //       emit(StoreDataImageUploading());
  //       final imageURL = await _userRepository.uploadImage('Users/images/Profile/', image);
  //       await _userRepository.updateStringFiled({"profilePicture": imageURL});
  //       getIt<CacheHelper>().saveValueWithKey("IMAGEURL", imageURL);
  //       emit(UserImageUploadSuccess(imageURL));
  //     }
  //   } catch (error) {
  //     emit(StoreDataError(error.toString()));
  //   }
  // }

  Future<void> uploadUserProfilePicture() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 512,
        maxWidth: 512,
      );

      File imageFile = File(pickedImage!.path);
      File? jpegImage = await convertToJpeg(imageFile);

      if (jpegImage != null) {
        emit(StoreDataImageUploading());
        final imageUrl = await _userRepository.uploadImage(
          'Users/images/Profile/',
          jpegImage,
        );
        // Step 5: Update User Image Record
        Map<String, dynamic> json = {"profilePicture": imageUrl};
        await _userRepository.updateStringFiled(json);

        // Step 6: Cache the image URL
        await getIt<CacheHelper>().saveValueWithKey("IMAGEURL", imageUrl);
        UserModel updatedUser = await _userRepository.fetchStableData(
            await getIt<CacheHelper>().getValueWithKey("userID"));
        emit(StoreDataLoaded(updatedUser));
      }
    } catch (error) {
      emit(StoreDataError(error.toString()));
    }
  }

  Future<void> updateUserData(String userName, String phoneNumber,
      String deatilsStore, String storeLink) async {
    try {
      emit(StoreDataLoading());
      await _userRepository.updateStringFiled({
        "userName": userName,
        "phoneNumber": phoneNumber,
        "deatilsForStore": deatilsStore,
        "storeLink": storeLink
      });
      UserModel updatedUser = await _userRepository.fetchUserDetails();
      emit(StoreDataLoaded(updatedUser));
      getIt<CacheHelper>().saveValueWithKey("USERNAME", updatedUser.userName);
    } catch (error) {
      emit(StoreDataError(error.toString()));
    }
  }

  void clearStoreData() {
    emit(StoreDataInitial());
  }
}
