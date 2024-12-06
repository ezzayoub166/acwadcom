import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:acwadcom/features/ownerStore/features/store_data/logic/store_data_state.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class StoreDataCubit extends Cubit<StoreDataState> {
  StoreDataCubit(this._userRepository, this._couponRepository)
      : super(StoreDataInitial());

  final UserRepository _userRepository;
  final CouponRepository _couponRepository;
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController deatilsStoreController = TextEditingController();
  final TextEditingController storeLinkController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Fetch user data from the repository
  Future<void> fetchUserData() async {
    emit(StoreDataLoading());
    try {
      String userId = getIt<CacheHelper>().getValueWithKey("userID");
      UserModel user = await _userRepository.fetchStableData(userId);
      emit(StoreDataLoaded(user));
    } catch (e) {
      emit(StoreDataError("Failed to fetch user data: ${e.toString()}"));
    }
  }

 // Upload profile picture
Future<void> uploadUserProfilePicture() async {
  try {
    // Step 1: Pick an image
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 512,
      maxWidth: 512,
    );

    // Step 2: Handle case where no image is selected
    if (pickedImage == null) {
      emit(StopLoadingImage());  // Emit StopLoadingImage to indicate no change was made
      return;
    }

    // Emit loading state if an image is selected
    emit(StoreDataImageUploading());

    // Step 3: Proceed with the selected image
    File imageFile = File(pickedImage.path);
    String userId = getIt<CacheHelper>().getValueWithKey("userID");
    var uniqueIdentifier = Uuid().v1();

    // Upload image
    final String imageUrl = await _uploadImage('picture_$userId', imageFile);
    final String couponLogoUrl =
        await _uploadCouponImage('$uniqueIdentifier', imageFile);

    // Update the user's profile picture and coupon store logo in Firestore
    await _updateUserProfile(imageUrl);
    await _updateCouponLogo(userId, couponLogoUrl);

    // Cache the new image URL
    await getIt<CacheHelper>().saveValueWithKey("IMAGEURL", imageUrl);

    // Emit success state
    emit(UserImageUploadSuccess(imageUrl));
  } catch (error) {
    emit(StoreDataError("Failed to upload profile picture: ${error.toString()}"));
  }
}


  // Helper to upload user image
  Future<String> _uploadImage(String path, File imageFile) async {
    return await _userRepository.uploadImage(path, imageFile);
  }

  // Helper to upload coupon logo image
  Future<String> _uploadCouponImage(String path, File imageFile) async {
    return await _couponRepository.uploadImage(path, imageFile);
  }

  // Helper to update user profile image in the repository
  Future<void> _updateUserProfile(String imageUrl) async {
    await _userRepository.updateStringFiled({"profilePicture": imageUrl});
  }

  // Helper to update coupon store logo in the repository
  Future<void> _updateCouponLogo(String userId, String logoUrl) async {
    await _couponRepository.updateStringFiledForCoupon(
        {"StoreLogoURL": logoUrl}, userId);
  }

  // Update user data
  Future<void> updateUserData(
      String userName, String phoneNumber, String deatilsStore, String storeLink) async {
    try {
      emit(StoreDataLoading());

      // Step 1: Update user data in Firestore
      await _userRepository.updateStringFiled({
        "userName": userName,
        "phoneNumber": phoneNumber,
        "deatilsForStore": deatilsStore,
        "storeLink": storeLink,
      });

      // Step 2: Refetch user data after update to reflect the changes
      await fetchUserData();
    } catch (error) {
      emit(StoreDataError("Failed to update user data: ${error.toString()}"));
    }
  }

  // Clear store data
  void clearStoreData() {
    emit(StoreDataInitial());
  }
}
