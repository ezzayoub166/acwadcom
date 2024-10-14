part of 'create_coupon_cubit_cubit.dart';

@freezed
class CreateCouponState<T> with _$CreateCouponState<T> {
  const factory CreateCouponState.initial() = _Initial;
  const factory CreateCouponState.loading() = Loading;
  const factory CreateCouponState.success() = Success<T>;
  const factory CreateCouponState.faluire({required String error}) = Faluire;
  const factory CreateCouponState.dateSelected({required DateTime selectedDate}) = DateSelected;
  const factory CreateCouponState.categorySelected({required OptionItem optionItemSelected}) = CategorySelected;
  const factory CreateCouponState.categoriesLoaded({required DropListModel listOfCategoriesOption}) = CategoriesLoaded;
  const factory CreateCouponState.loadingSetLogoStore() = LoadingSetLogoStore;
  const factory CreateCouponState.loadedSetLogoStore({required XFile imageURL}) = LoadedSetLogoStore;



  
}