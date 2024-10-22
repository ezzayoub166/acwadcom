part of 'wishlist_cubit.dart';

@freezed
class WishlistState with _$WishlistState {
  const factory WishlistState.initial() = _Initial;
  const factory WishlistState.wishlistLoading() = WishlistLoading;
  const factory WishlistState.wishlistLoaded({required List<Coupon> coupons}) = WishlistLoaded;
    const factory WishlistState.wishlistStoresLoaded({required List<UserModel> stores}) = WishlistStoresLoaded;

  const factory WishlistState.wishlistFaluire({required String error}) = WishlistFaluire;
  const factory WishlistState.emptyWishList() = EmptyWishList;



  const factory WishlistState.addToWishList({required Coupon coupon}) = AddToWishList;
  const factory WishlistState.removeToWishList({required Coupon coupon}) = RemoveFromWishList;


}
