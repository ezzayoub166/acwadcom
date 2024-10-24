import 'package:acwadcom/features/user/wishlist/data/wihslist_repository.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wihslist_coupons_state.dart';
part 'wihslist_coupons_cubit.freezed.dart';

class WishListCouponsCubit extends Cubit<WishListCouponsState> {
  WishListCouponsCubit(this._wihslistRepository) : super(const WishListCouponsState.initial());

    final WihslistRepository _wihslistRepository;


    List<Coupon> wishlistCpupons = [];


    ///! for Coupons ..........


  fetchFavoriteCoupons() async {
    try {
      emit(const WishListCouponsState.wishlistLoading());
      final wishlist = await _wihslistRepository.feathcoWishList();
      if (wishlist.isEmpty) {
        emit(const WishListCouponsState.emptyWishList());
        emit(const  WishListCouponsState.getNumberOFCouponsInWishList(count: 0));
      } else {
        wishlistCpupons = wishlist;
        emit(WishListCouponsState.getNumberOFCouponsInWishList(count: wishlist.length));
        emit(WishListCouponsState.wishlistLoaded(coupons: wishlist));


      }
    } catch (error) {
      emit(WishListCouponsState.wishlistFaluire(error: error.toString()));
    }
  }
  //...
  //....

  addToWishList(Coupon coupon)async{
    try{
      await _wihslistRepository.addCouponToWishList(coupon);
      await fetchFavoriteCoupons(); // Refresh the wishlist
    }catch(error){
      emit(WishListCouponsState.wishlistFaluire(error: error.toString()));
    }
  }

    // Remove coupon from wishlist
  Future<void> removeCouponFromWishlist(Coupon coupon) async {
    try {
       await _wihslistRepository.removeCouponFromWishList(coupon);
        await fetchFavoriteCoupons(); // Refresh the wishlist after removal


    } catch (e) {
      throw 'Failed to remove coupon from wishlist: $e';
    }
  }

    // Check if a coupon is in the wishlist
  bool isInWishlist(Coupon coupon) {
    final state = this.state;
    if (state is WishlistLoaded) {
      return state.coupons.any((c) => c.couponId == coupon.couponId);
    }
    return false;
  }

  
}
