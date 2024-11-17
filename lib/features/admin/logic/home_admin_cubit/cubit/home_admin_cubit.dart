import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_admin_state.dart';
part 'home_admin_cubit.freezed.dart';

class HomeAdminCubit extends Cubit<HomeAdminState> {
  HomeAdminCubit(this._couponRepository) : super(const HomeAdminState.initial());

  final CouponRepository _couponRepository;

  @override
  void emit(HomeAdminState state) {
    // TODO: implement emit
    if(!isClosed){
      super.emit(state);
    }
  }


    void emitGetCoupons()async{
    try{
      emit(const HomeAdminState.loadingCoupons());
        await _couponRepository.fetchAllCouponsForAdmin().then((coupons){
     emit(HomeAdminState.successGetCoupons(coupons: coupons));
    //  emit(HomeAdminState.getNumberOFCoubons(count: coupons.length));
      });
    }catch(onError){
      emit(HomeAdminState.faluireGetCoupons(error: onError.toString()));

    }
  }

  void emitRemoveCoupon(String couponId)async{
    try{
      emit(const HomeAdminState.loadingRemove());
      await _couponRepository.removeCoupon(couponId).then((_){
        emit(const HomeAdminState.sucessRemove());
        emitGetCoupons();
      });
    }catch(error){
     emit(const HomeAdminState.faluireRemove());
    } 
  }
}
