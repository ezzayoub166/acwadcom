

import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/wishlist/data/wihslist_repository.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_state.dart';
part 'wishlist_cubit.freezed.dart';

class WishlistStoresCubit extends Cubit<WishListStoresState> {
 WishlistStoresCubit(this._wihslistRepository, this.cacheHelper) : super(const WishListStoresState.initial());

  final WihslistRepository _wihslistRepository;

  final CacheHelper cacheHelper;

  List<UserModel> wishlistStores = [];

  



  ///! for Stores ..........
  fetchWishListForStores() async {
    try {
      emit(const WishListStoresState.wishlistStoresLoading());
      final wishlist = await _wihslistRepository.featchWishListForStores();
      if (wishlist.isEmpty) {
        emit(const WishListStoresState.emptyStoresWishList());
        emit(const WishListStoresState.getNumberOFStoresInWishList(count: 0));
      } else {
        wishlistStores = wishlist;
       emit(WishListStoresState.getNumberOFStoresInWishList(count: wishlist.length));
        emit(WishListStoresState.wishlistStoresLoaded(stores: wishlist));
        
      }
    } catch (error) {
      emit(WishListStoresState.wishlistStoresFaluire(error: error.toString()));
    }
  }


  


  addStoreToWishList(UserModel store)async {
    try{
      await _wihslistRepository.addStoreToWishList(store);

      await fetchWishListForStores();
    }catch(error){
      emit(WishListStoresState.wishlistStoresFaluire(error: error.toString()));
    }
  }

  // Remove Store from wishlist
  Future<void> removeStoreFromWishlist(UserModel store) async {
    try {
      await _wihslistRepository.removeStoreFromWishList(store);
      await fetchWishListForStores(); // Refresh the wishlist after removal
    } catch (e) {
      throw 'Failed to remove coupon from wishlist: $e';
    }
  }

  // Check if a store is in the wishlist
  bool isStoreInWishlist(UserModel store) {
    final state = this.state;
    if (state is WishlistStoresLoaded) {
      return state.stores.any((c) => c.id == store.id);
    }
    return false;
  }

  bool checkIfItemInWishlist(UserModel store){
    if(wishlistStores.contains(store)){
      return true;
    }else{
      return false;
    }
    
  }



  
}
