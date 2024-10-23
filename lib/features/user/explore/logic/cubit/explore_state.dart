part of 'explore_cubit.dart';

@freezed
class ExploreState with _$ExploreState {

  const factory ExploreState.initial() = _Initial;
  const factory ExploreState.loadingStores() = LoadingStores;
  const factory ExploreState.sucessGetStores({required List<UserModel> stores}) = SucessGetStores;
  const factory ExploreState.sucessGetSpecialStores({required List<UserModel> stores}) = SucessGetSpecialStores;
  const factory ExploreState.faluireGetStores({required String error}) = FaluireGetStores;


  //For Coupons

   const factory ExploreState.loadingGetCoupons() = LoadingGetCoupons;
   const factory ExploreState.successGetCoupon({required List<Coupon> coupons}) = SuccessGetCoupon;
   const factory ExploreState.errorGetCoupons({required String error}) = ErrorGetCoupons;
   const factory ExploreState.emptyListCoupons() = EmptyListCoupons;


  


}
