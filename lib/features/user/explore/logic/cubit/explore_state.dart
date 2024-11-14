part of 'explore_cubit.dart';

@freezed
class ExploreState with _$ExploreState {

  const factory ExploreState.initial() = _Initial;
  const factory ExploreState.loadingSpecialStores() = LoadingSpecialStores;
  const factory ExploreState.sucessGetStores({required List<UserModel> stores}) = SucessGetStores;
  const factory ExploreState.sucessGetSpecialStores({required List<UserModel> stores}) = SucessGetSpecialStores;
  const factory ExploreState.faluireGetStores({required String error}) = FaluireGetStores;
  const factory ExploreState.emptyListStores() = EmptyListStores;

  const factory ExploreState.loadingStores() = LoadingStores;

  //For Coupons
   const factory ExploreState.loadingGetCoupons() = LoadingGetCoupons;
   const factory ExploreState.successGetCoupon({required List<Coupon> coupons}) = SuccessGetCoupon;
   const factory ExploreState.errorGetCoupons({required String error}) = ErrorGetCoupons;
   const factory ExploreState.emptyListCoupons() = EmptyListCoupons;

   //For Most Used Coupons 
   const factory ExploreState.loadingGetMostUsedCoupons() = LoadingGetMostUsedCoupons;
   const factory ExploreState.successGetMostUsedCoupons({required List<Coupon> mostUsedCoupons}) = SuccessGetMostUsedCoupons;
   const factory ExploreState.errorGetMostUsedCoupons({required String erro}) = ErrorGetMostUsedCoupons;
   const factory ExploreState.emptyEmptyMostUsedCoupons() = EmptyEmptyMostUsedCoupons;


}
