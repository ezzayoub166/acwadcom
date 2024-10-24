part of 'wihslist_coupons_cubit.dart';

@freezed
class WishListCouponsState with _$WishListCouponsState {
    const factory WishListCouponsState.initial() = _Initial;
  const factory WishListCouponsState.wishlistLoading() = WishlistLoading;

  const factory WishListCouponsState.wishlistLoaded({required List<Coupon> coupons}) = WishlistLoaded;

  const factory WishListCouponsState.wishlistFaluire({required String error}) = WishlistFaluire;
  const factory WishListCouponsState.emptyWishList() = EmptyWishList;
  const factory WishListCouponsState.getNumberOFCouponsInWishList({required int count}) = GetNumberOFCouponsInWishList;

}
