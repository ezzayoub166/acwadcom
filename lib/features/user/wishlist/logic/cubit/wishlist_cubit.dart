import 'dart:convert';

import 'package:acwadcom/features/user/wishlist/data/wihslist_repository.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_state.dart';
part 'wishlist_cubit.freezed.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this._wihslistRepository)
      : super(const WishlistState.initial());

  final WihslistRepository _wihslistRepository;


    ///! for Coupons ..........


  feathcoWishList() async {
    try {
      emit(const WishlistState.wishlistLoading());
      final wishlist = await _wihslistRepository.feathcoWishList();
      if (wishlist.isEmpty) {
        emit(const WishlistState.emptyWishList());
      } else {
        emit(WishlistState.wishlistLoaded(coupons: wishlist));
      }
    } catch (error) {
      emit(WishlistState.wishlistFaluire(error: error.toString()));
    }
  }

  addToWishList(Coupon coupon)async{
    try{
      await _wihslistRepository.addCouponToWishList(coupon);
      await feathcoWishList(); // Refresh the wishlist
    }catch(error){
      emit(WishlistState.wishlistFaluire(error: error.toString()));
    }
  }

    // Remove coupon from wishlist
  Future<void> removeCouponFromWishlist(Coupon coupon) async {
    try {
       await _wihslistRepository.removeCouponFromWishList(coupon);
        await feathcoWishList(); // Refresh the wishlist after removal


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


  ///! for Stores ..........
  featchWishLitForStores() async {
    try {
      emit(const WishlistState.wishlistLoading());
      final wishlist = await _wihslistRepository.featchWishListForStores();
      if (wishlist.isEmpty) {
        emit(const WishlistState.emptyWishList());
      } else {
        emit(WishlistState.wishlistStoresLoaded(stores: wishlist));
      }
    } catch (error) {
      emit(WishlistState.wishlistFaluire(error: error.toString()));
    }
  }


  addStoreToWishList(UserModel store)async {
    try{
      await _wihslistRepository.addStoreToWishList(store);
      

    }catch(error){

    }
  }
  
}
