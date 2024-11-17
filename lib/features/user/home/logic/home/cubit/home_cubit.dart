import 'package:acwadcom/features/user/home/data/category_repository.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/models/category_model.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/offer_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._categoryRepository, this._couponRepository) : super(const HomeState.initial());




  final CategoryRepository _categoryRepository;
  final CouponRepository _couponRepository;
   List<CategoryModel> featchedCategories = [];
   List<Coupon> featchedCoupons = [];

  @override
  void emit(HomeState state) {
    // TODO: implement emit
    if(!isClosed){
      super.emit(state);
    }
  }

  void emitGetCategories()async{
    try{
        emit(const HomeState.loadingCatgories());
        List<CategoryModel> categories = await _categoryRepository.getAllCategories();
        bLISTOFCATEGORY = categories;
        featchedCategories = categories;
        emit(HomeState.successFeatchedCatgories(categories: categories));

         // Automatically select the first category after categories are loaded
      emitSelectedCategory(0);
    }catch(error){
      emit(HomeState.errorFeatchedCatgories(error: error.toString()));
    }
  }


  void emitGetOffers()async{
    try{
      emit(const HomeState.loadingGetOffers());
      List<OfferModel> offers = await _categoryRepository.getTheOffers();
      if(offers.isNotEmpty){
      emit(HomeState.successGetOffers(offers: offers));

      }else{
        emit(const HomeState.emptyOffers());

      }
    }catch(error){
      emit(HomeState.faluireGetOffers(error: error.toString()));

    }
  }


  void emitGetDiscoverCoupons()async{
    try{
      emit(const HomeState.loadingCoupons());
        await _couponRepository.fetchDiscoverCoupons().then((coupons){
          featchedCoupons = coupons;
     emit(HomeState.successFeatchedCoupons(coupons: coupons));
      });
    }catch(onError){
      emit(HomeState.errorFeatchedCoupons(error: onError.toString()));
    }
  }


  void emitGetAllCoupons()async{
    try{
      emit(const HomeState.loadingCoupons());
        await _couponRepository.fetchAllCoupons().then((coupons){
          featchedCoupons = coupons;
     emit(HomeState.successFeatchedCoupons(coupons: coupons));
      });
    }catch(onError){
      emit(HomeState.errorFeatchedCoupons(error: onError.toString()));
    }
  }

void emitSelectedCategory(int index) {

  List<Coupon>  filteredCoupons = [];
  // Update the selected state of categories
  for (int i = 0; i < featchedCategories.length; i++) {
    featchedCategories[i].isSelected = i == index; // Set isSelected for the category
  }
  // Assuming featchedCoupons is a list of CouponModel objects and each has a categoryId property
  // Get the selected category ID
  String selectedCategoryId = featchedCategories[index].categoryId!;

  // Filter coupons based on the selected category
  if(index == 0){
     emit(HomeState.successFeatchedCoupons(coupons: featchedCoupons));

  }else{
filteredCoupons = featchedCoupons
      .where((coupon) => coupon.category?.categoryId == selectedCategoryId)
      .toList();
      if(filteredCoupons.isEmpty){
        emit(const HomeState.emptyCoupons());
      }else{
        emit(HomeState.successFeatchedCoupons(coupons: filteredCoupons));

      }

  }
  // Emit the updated state with selected index and filtered coupons
  emit(HomeState.categorySelected(index: index, listofCategories: featchedCategories, listofCoupns: filteredCoupons));///! remove the third parm...
}

  
}
