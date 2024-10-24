part of 'wishlist_cubit.dart';

@freezed
class WishListStoresState with _$WishListStoresState {
  const factory WishListStoresState.initial() = _Initial;
  const factory WishListStoresState.wishlistStoresLoading() = WishlistStoresLoading;

  const factory WishListStoresState.wishlistStoresLoaded({required List<UserModel> stores}) = WishlistStoresLoaded;

  const factory WishListStoresState.wishlistStoresFaluire({required String error}) = WishlistStoresFaluire;
  const factory WishListStoresState.emptyStoresWishList() = EmptyStoresWishList;
    const factory WishListStoresState.getNumberOFStoresInWishList({required int count}) = GetNumberOFStoresInWishList;



}
