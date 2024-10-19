import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/home_owner/home_owner_state.dart';
import 'package:bloc/bloc.dart';


class HomeOwnerCubit extends Cubit<HomeOwnerState> {
  HomeOwnerCubit(this.couponRepository) : super(HomeOwnerState.initial());

  final CouponRepository couponRepository;


emitGetCoupons()async{
  try{
    //  emit(const HomeOwnerState.loadingGetCouponsForOwner());
    //  var userID = await getIt<CacheHelper>().getValueWithKey("userID");
    //  await couponRepository.fetchCouponsRequestByOwnerID(userID).then((coupons){
    //   emit(HomeOwnerState.successGetCouponsForOwner(coupons: coupons));
    //  });

     

  }catch(onErrro){

  }
  

}
}
