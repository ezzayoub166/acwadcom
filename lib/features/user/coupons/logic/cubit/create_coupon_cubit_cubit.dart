// ignore_for_file: depend_on_referenced_packages

import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
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
  TextEditingController numberOfUseController = TextEditingController();

  OptionItem? optionItemSelected;
  DateTime? dateItem;

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;
  String urlLOGO = "";

  final CategoryRepository categoryRepository;
  final CouponRepository couponRepository;
  final UserRepository userRepository;
  // final CouponRequestService couponRequestService;

  DropListModel listOfCategoriesOption = DropListModel([]);

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
      return OptionItem(title: item.title, id: item.categoryId);
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
      urlLOGO = await couponRepository.uploadImage(
          'Users/images/Coupons/', _selectedImage!);
    }
    var couponID = const Uuid().v1();
    var userId = getIt<CacheHelper>().getValueWithKey("userID");
    var user = await userRepository.fetchUserDetails();

    var coupon = Coupon(
        title: titleController.text,
        isFeatured: false,
        isMostUsed: false,
        couponId: couponID,
        ownerCouponId: userId,
        discountRate: discountRateController.text.trim(),
        storeLink: storeLinkController.text.trim(),
        storeLogoURL: urlLOGO,
        category: CategoryModel(
        title: optionItemSelected?.title ?? "All",
        image: "",
        categoryId: optionItemSelected?.id),
        endData: dateItem != null ? Timestamp.fromDate(dateItem!) : Timestamp.now(),
        numberOfUse: int.parse(numberOfUseController.text.trim()),
        additionalTerms: additionalTerms.text,
         code: codeTextController.text,
         uploadDate: Timestamp.now(),
          ownerCoupon: user
          
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
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(const CreateCouponState.loadingSetLogoStore());
      _selectedImage = image;
      emit(CreateCouponState.loadedSetLogoStore(imageURL: image));
    }
  }
}
