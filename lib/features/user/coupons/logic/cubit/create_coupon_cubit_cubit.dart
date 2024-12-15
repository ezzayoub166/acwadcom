// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/util/language_cache_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/home/data/category_repository.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/models/category_model.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:uuid/uuid.dart';

part 'create_coupon_cubit_state.dart';
part 'create_coupon_cubit_cubit.freezed.dart';

class CreateCouponCubit extends Cubit<CreateCouponState> {
  CreateCouponCubit(this.categoryRepository, this.couponRepository, this.userRepository)
      : super(const CreateCouponState.initial());

  final formKey = GlobalKey<FormState>();

  TextEditingController codeTextController = TextEditingController();
  TextEditingController discountRateController = TextEditingController();
  TextEditingController storeLinkController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  // TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController additionalTerms = TextEditingController();
  // TextEditingController numberOfUseController = TextEditingController();

  OptionItem? optionItemSelected;
  DateTime? dateItem;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  File? get selectedImage => _selectedImage;
  String urlLOGO = "";

  final CategoryRepository categoryRepository;
  final CouponRepository couponRepository;
  final UserRepository userRepository;
  // final CouponRequestService couponRequestService;

  DropListModel listOfCategoriesOption = DropListModel([]);

  var locale = LanguageCacheHelper().getCachedLanguageCode();


  void selectDate(DateTime date) {
    dateItem = date;
    emit(CreateCouponState.dateSelected(selectedDate: date));
  }

  // Select category and emit the CategorySelected state
  void selectCategory(OptionItem optionItem) {
    emit(CreateCouponState.categorySelected(optionItemSelected: optionItem));
  }

//** FETGCH CATEGORIES  */
  void fetchCategories() {

    // Assuming bLISTOFCATEGORY is a list of categories you get from the repository
    final categories = bLISTOFCATEGORY.map((item) {
      return OptionItem(title: locale == "en" ? item.title["en"] : item.title["ar"] , id: item.categoryId);
    }).toList();

    listOfCategoriesOption = DropListModel(categories);

    // Emit a state to notify listeners that categories are loaded
    emit(CreateCouponState.categoriesLoaded(
        listOfCategoriesOption: listOfCategoriesOption));
  }

//** CREATE COUBON METHOD */
  void addCoupon() async {
  
    emit(const CreateCouponState.loading());

    if (tYPEUSER == "STOREOWNER") {
      urlLOGO = getIt<CacheHelper>().getValueWithKey("IMAGEURL");
    } else {
      var uniq = Uuid().v1();
      File imageFile = File(_selectedImage!.path);

      urlLOGO = await couponRepository.uploadImage(
          'coupon_${uniq}', imageFile);
    }

    var couponID = const Uuid().v1();
    var userId = getIt<CacheHelper>().getValueWithKey("userID");
    var user = await userRepository.fetchStableData(userId);

    var coupon = Coupon(
        title            : titleController.text,
        couponId         : couponID,
        ownerCouponId    : userId,
        discountRate     : discountRateController.text.trim(),
        storeLink        : storeLinkController.text.trim(),
        storeLogoURL     : urlLOGO,
        category         : CategoryModel(  
        title: {
          "en":optionItemSelected?.title ?? "All",
        }                      ,
        image            : "",
        categoryId       : optionItemSelected?.id),
        endData          : dateItem != null ? Timestamp.fromDate(dateItem!) : Timestamp.now(),
        numberOfUse      : 20,
        additionalTerms  : additionalTerms.text,
        code              : codeTextController.text,
        uploadDate      : Timestamp.now(),
        ownerCoupon     : user 
        );
    try {
      // await couponRepository.addCoupon(coupon);
      await couponRepository.snedCouponRequest(coupon: coupon , userID: userId);
      emit(const CreateCouponState.success());
    } catch (error) {
      emit(CreateCouponState.faluire(error: error.toString()));
    }

//  couponRepository.addCoupon(Cou)
// the argument type string cant be assigned
  }

  void pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(const CreateCouponState.loadingSetLogoStore());
      _selectedImage = File(image.path);
      emit(CreateCouponState.loadedSetLogoStore(imageURL: image));
    }
  }
}
