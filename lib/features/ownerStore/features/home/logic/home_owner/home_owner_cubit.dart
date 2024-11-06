import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_state.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:bloc/bloc.dart';


class HomeOwnerCubit extends Cubit<HomeOwnerState> {
  HomeOwnerCubit(this.couponRepository) : super(const HomeOwnerState.initial());

  final CouponRepository couponRepository;


  int numberOfItems = 0 ;



emitGetCoupons()async{
  emit(const HomeOwnerState.loadingGetCouponsForOwner());
  try{
    final List<Coupon> coupons = await couponRepository.fetchCouponsForOwner();
    var sumsOFUseCoupons = 0;
    coupons.forEach((element) {
      sumsOFUseCoupons += element.numberOfUse;
    },);
    emit(HomeOwnerState.successGetCouponsForOwner(coupons: coupons));
emit(HomeOwnerState.getNumberOfCoupons(number: coupons.length));
 emit(HomeOwnerState.getSumUsedOfCoupons(sum: sumsOFUseCoupons));
  }catch(error){
    emit(HomeOwnerState.faluireGetCouponsForOwner(error: error.toString()));
  }
}


emitNumberOfItems(){
      emit(HomeOwnerState.getNumberOfCoupons(number: numberOfItems));
}



void emitRemoveCoupon(String couponId)async{
    try{
      await couponRepository.removeCoupon(couponId).then((_){
        emitGetCoupons();
      });
    }catch(error){
    } 
  }
  

}

