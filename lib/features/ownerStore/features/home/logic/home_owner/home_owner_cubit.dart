import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/features/ownerStore/features/home/logic/home_owner/home_owner_state.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:bloc/bloc.dart';


class HomeOwnerCubit extends Cubit<HomeOwnerState> {
  HomeOwnerCubit(this.couponRepository) : super(const HomeOwnerState.initial());

  final CouponRepository couponRepository;



emitGetCoupons()async{
  emit(const HomeOwnerState.loadingGetCouponsForOwner());
  try{
    final List<Coupon> coupons = await couponRepository.fetchCouponsForOwner();
    emit(HomeOwnerState.successGetCouponsForOwner(coupons: coupons));
  }catch(error){
    emit(HomeOwnerState.faluireGetCouponsForOwner(error: error.toString()));
  }
}
  

}

