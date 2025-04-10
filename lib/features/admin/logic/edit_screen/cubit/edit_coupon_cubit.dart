import 'dart:io';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/features/user/home/data/category_repository.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/models/category_model.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
part 'edit_coupon_state.dart';
part 'edit_coupon_cubit.freezed.dart';

class EditCouponCubit extends Cubit<EditCouponState> {
  final formKey = GlobalKey<FormState>();

  TextEditingController codeTextController = TextEditingController();
  TextEditingController discountRateController = TextEditingController();
  TextEditingController storeLinkController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController additionalTerms = TextEditingController();

  CategoryModel? optionItemSelected;
  DateTime? dateItem;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  EditCouponCubit(
      this.categoryRepository, this.couponRepository, this.userRepository)
      : super(EditCouponState.initialEditCoupon());

  File? get selectedImage => _selectedImage;
  String updatedStoreLogoURL = "";

  final CategoryRepository categoryRepository;
  final CouponRepository couponRepository;
  final UserRepository userRepository;

  DropListModel listOfCategoriesOption = DropListModel([]);

  // var locale = getIt<CacheHelper>().getValueWithKey("LOCALE");

  //** FETGCH CATEGORIES  */
  void fetchCategories() async {
    List<CategoryModel> featchCategories =
        await categoryRepository.getAllCategories();
    // Assuming bLISTOFCATEGORY is a list of categories you get from the repository
    final categories = featchCategories.map((item) {
      return OptionItem(
          title: getIt<CacheHelper>().getChacedLanguageCode() == "en"
              ? item.title["en"]
              : item.title["ar"],
          id: item.categoryId);
    }).toList();
    // print(featchCategories.map((item)=>item.title));

    listOfCategoriesOption = DropListModel(categories);

    // Emit a state to notify listeners that categories are loaded
    emit(EditCouponState.categoriesLoadedEditCoupon(
        listOfCategoriesOption: listOfCategoriesOption));
  }

  // Method to fetch the coupon data for editing
  void fetchCouponData(String couponId) async {
    emit(const EditCouponState.loadingEditCoupon());

    try {
      var coupon = await couponRepository
          .fetchCouponById(couponId); // Fetch coupon from repository
      // Populate fields with the existing coupon data
      titleController.text = coupon.title;
      codeTextController.text = coupon.code;
      discountRateController.text = coupon.discountRate;
      storeLinkController.text = coupon.storeLink;
      additionalTerms.text = coupon.additionalTerms;
      dateItem = coupon.endData.toDate();
      dateController.text = dateItem != null
          ? "${dateItem!.year}-${dateItem!.month.toString().padLeft(2, '0')}-${dateItem!.day.toString().padLeft(2, '0')}"
          : "";

      optionItemSelected = CategoryModel(
          title: coupon.category!.title,
          image: coupon.category!.image,
          categoryId: coupon.categoryID);

      // Emit state with fetched data
      emit(EditCouponState.couponLoadedEditCoupon(coupon: coupon));
    } catch (error) {
      emit(EditCouponState.faluireEditCoupon(error: error.toString()));
    }
  }

  void editCoupon(String couponId) async {
    emit(EditCouponState.loadingEditCoupon());

    // Fetch the existing coupon
    var coupon = await couponRepository.fetchCouponById(couponId);

    // Flag to determine if updates are necessary
    bool isUpdated = false;

    // Updated fields: compare current form values with existing coupon values
    String updatedDiscountRate =
        discountRateController.text.trim() == coupon.discountRate
            ? coupon.discountRate
            : discountRateController.text.trim();
    String updatedStoreLink =
        storeLinkController.text.trim() == coupon.storeLink
            ? coupon.storeLink
            : storeLinkController.text.trim();
    String updatedTitle = titleController.text == coupon.title
        ? coupon.title
        : titleController.text;
    String updatedCode = codeTextController.text == coupon.code
        ? coupon.code
        : codeTextController.text;
    DateTime updatedEndDate = dateItem ?? coupon.endData.toDate();

    // Check for category updates
    CategoryModel? updatedCategory = optionItemSelected ?? coupon.category; 
        
        // CategoryModel updatedCategory = coupon.category!;

    if (updatedCategory?.categoryId != coupon.category?.categoryId) {
      isUpdated = true;
      updatedCategory = optionItemSelected;
      print("******************************************************************************************************");
      print(updatedCategory!.title["en"]);
      print("******************************************************************************************************");



    }

    // Determine if any field has changed
    if (updatedDiscountRate != coupon.discountRate ||
        updatedStoreLink != coupon.storeLink ||
        updatedTitle != coupon.title ||
        updatedCode != coupon.code ||
        updatedEndDate != coupon.endData.toDate() ||
        updatedCategory?.categoryId != coupon.category?.categoryId) {
      isUpdated = true;
    }

    if (!isUpdated) {
      // Emit success if no changes are detected
      emit(EditCouponState.successEditCoupon());
      return;
    }

    try {
      // Create an updated coupon instance
      var updatedCoupon = Coupon(
        title: updatedTitle,
        couponId: couponId,
        ownerCoupon: coupon.ownerCoupon,
        ownerCouponId: coupon.ownerCouponId,
        discountRate: updatedDiscountRate,
        storeLink: updatedStoreLink,
        storeLogoURL: coupon.storeLogoURL,
        category: updatedCategory,
        categoryID: updatedCategory!.categoryId!,
        endData: Timestamp.fromDate(updatedEndDate),
        additionalTerms: additionalTerms.text,
        code: updatedCode,
        uploadDate: Timestamp.now(),
        numberOfUse: coupon.numberOfUse,
      );
      print("******************************************************************************************************");
      print(updatedCoupon.category!.title["en"]);
     print("******************************************************************************************************");


      // Update the coupon in the repository
      await couponRepository.updateCoupon(updatedCoupon);

      emit(const EditCouponState.successEditCoupon());
    } catch (error) {
      emit(EditCouponState.faluireEditCoupon(error: error.toString()));
    }
  }

  // Upload logo coupon
  Future<void> editLogoForCouponPicture(String couponID) async {
    try {
      emit(const EditCouponState.loadingSetLogoStoreEditCoupon());

      // Step 1: Pick an image
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 512,
        maxWidth: 512,
      );

      //Step 2: Handle case where no image is selected
      if (pickedImage == null) {
        emit(StopLoadingImageEditCoupon());
        _selectedImage ==
            null; // Emit StopLoadingImage to indicate no change was made
        return;
      }

      _selectedImage = File(pickedImage.path);

      // Step 3: Proceed with the selected image
      var uniq = Uuid().v1();
      File imageFile = File(_selectedImage!.path);
      await couponRepository
          .uploadImage('coupon_${uniq}', imageFile)
          .then((url) async {
        updatedStoreLogoURL = url;
        await _updateCouponLogo(updatedStoreLogoURL, couponID);
        emit(EditCouponState.loadedSetLogoStoreEditCoupon(
            imageURL: _selectedImage!));
      });
      // Update the user's profile picture and coupon store logo in Firestore
      // Emit success state
    } catch (error) {
      emit(EditCouponState.faluireEditCoupon(error: error.toString()));
    }
  }

  Future<void> _updateCouponLogo(String logoUrl, String couponID) async {
    await couponRepository
        .updateStringFiled(json: {"StoreLogoURL": logoUrl}, couponID: couponID);
  }

  // Method to pick an image for the coupon
  void pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(const EditCouponState.loadingSetLogoStoreEditCoupon());
      _selectedImage = File(image.path);
      emit(EditCouponState.loadedSetLogoStoreEditCoupon(
          imageURL: _selectedImage!));
    } else {
      _selectedImage = null;
    }
  }

  void selectDate(DateTime date) {
    dateItem = date;
    emit(EditCouponState.dateSelectedEditCoupon(selectedDate: date));
  }

  // Select category and emit the CategorySelected state
  void selectCategory(CategoryModel optionItem) {
    emit(EditCouponState.categorySelectedEditCoupon(
        optionItemSelected: optionItem));
  }
}
