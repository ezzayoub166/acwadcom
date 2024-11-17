import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/explore/data/store_repository.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_state.dart';
part 'explore_cubit.freezed.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this.storeRepository, this.couponRepository) : super(const ExploreState.initial());

  final StoreRepository storeRepository;
  final CouponRepository couponRepository;


  @override
  void emit(ExploreState state) {
    // TODO: implement emit
    if(!isClosed){
      super.emit(state);
    }
  }

//** Most Used Coupons  */
   Future<void> fetchMostUsedCoupons() async{
    try{
      emit(const ExploreState.loadingGetMostUsedCoupons());
      final coupons = await couponRepository.fetchMostUsedCoupons();
      emit(ExploreState.successGetMostUsedCoupons(mostUsedCoupons: coupons));
    }catch(onError){
      emit(ExploreState.errorGetMostUsedCoupons(erro: onError.toString()));

    }
  }

  //** Recntly Added Coupons */

   Future<void> fetchCouponsAddedRecently(limit) async {
    try{
      emit(const ExploreState.loadingGetCoupons());
      await couponRepository.fetchRecentlyAddedCoupons(limit).then((coupons){
        emit(ExploreState.successGetCoupon(coupons: coupons));
      });
    }catch(error){
      emit(ExploreState.errorGetCoupons(error: error.toString()));

    }
  }


//** Special Stories  */

  fetchSpecialStores()async{
    try {
      emit(const ExploreState.loadingSpecialStores());
      final List<UserModel> stores =
          await storeRepository.featchSpecialStores();
      emit(ExploreState.sucessGetSpecialStores(stores: stores));
    } catch (error) {
      emit(ExploreState.faluireGetStores(error: error.toString()));
    }
  }
  //** all Stories */

  fetchStores()async{
    try {
      emit(const ExploreState.loadingStores());
      final List<UserModel> stores = await storeRepository.featchStores();
      emit(ExploreState.sucessGetStores(stores: stores));
    } catch (error) {
      emit(ExploreState.faluireGetStores(error: error.toString()));
    }
  }

 

  Future<void> getCouponsForSelectedStore(String ownerID) async {
    emit(const ExploreState.loadingGetCoupons());
    try {
      final coupons = await storeRepository.fetchCouponForSelectStore(ownerID);

      // Ensure you're not emitting an empty success state if coupons are empty.
      if (coupons.isEmpty) {
        emit(const ExploreState.emptyListCoupons());
      } else {
        emit(ExploreState.successGetCoupon(coupons: coupons));
      }
    } catch (error) {
      emit(ExploreState.errorGetCoupons(error: error.toString()));
    }
  }


 
}
