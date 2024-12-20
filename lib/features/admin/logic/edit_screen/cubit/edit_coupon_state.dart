part of 'edit_coupon_cubit.dart';

@freezed
class EditCouponState with _$EditCouponState {
    const factory EditCouponState.initialEditCoupon() = _InitialEditCoupon;
  const factory EditCouponState.loadingEditCoupon() = LoadingEditCoupon;
  const factory EditCouponState.successEditCoupon() = SuccessEditCoupon;
  const factory EditCouponState.faluireEditCoupon({required String error}) = FaluireEditCoupon;
  const factory EditCouponState.dateSelectedEditCoupon({required DateTime selectedDate}) = DateSelectedEditCoupon;
  const factory EditCouponState.categorySelectedEditCoupon({required OptionItem optionItemSelected}) = CategorySelectedEditCoupon;
  const factory EditCouponState.categoriesLoadedEditCoupon({required DropListModel listOfCategoriesOption}) = CategoriesLoadedEditCoupon;
  const factory EditCouponState.loadingSetLogoStoreEditCoupon() = LoadingSetLogoStoreEditCoupon;
  const factory EditCouponState.loadedSetLogoStoreEditCoupon({required File imageURL}) = LoadedSetLogoStoreEditCoupon;
  const factory EditCouponState.notSelectedLogoStoreEditCoupon() = NotSelectedLogoStoreEditCoupon;
  const factory EditCouponState.emptyLogoStoreEditCoupon() = EmptyLogoStoreEditCoupon;
  const factory EditCouponState.couponLoadedEditCoupon({required Coupon coupon}) = CouponLoadedEditCoupon;  // Added state for coupon loaded
const factory EditCouponState.stopLoadingImageEditCoupon() = StopLoadingImageEditCoupon;
}
