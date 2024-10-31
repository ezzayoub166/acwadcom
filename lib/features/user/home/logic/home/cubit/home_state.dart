part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loadingCatgories() = LoadingCatgories;
  const factory HomeState.successFeatchedCatgories(
      {required List<CategoryModel> categories}) = SuccessFeatchedCatgories;
  const factory HomeState.categorySelected(
      {required int index,
      required List<CategoryModel> listofCategories,
      required List<Coupon> listofCoupns}) = CategorySelected;
  const factory HomeState.errorFeatchedCatgories({required String error}) =
      ErrorFeatchedCatgories;
  const factory HomeState.loadingCoupons() = LoadingCoupons;
  const factory HomeState.successFeatchedCoupons(
      {required List<Coupon> coupons}) = SuccessFeatchedCoupons;
  const factory HomeState.errorFeatchedCoupons({required String error}) =
      ErrorFeatchedCoupons;

  const factory HomeState.loadingGetOffers() = LoadingGetOffers;
  const factory HomeState.successGetOffers({required List<OfferModel> offers}) =
      SuccessGetOffers;
  const factory HomeState.faluireGetOffers({required String error}) =
      FaluireGetOffers;
  const factory HomeState.emptyOffers() = EmptyOffers;

}
