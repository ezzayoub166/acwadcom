import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/coupon_request.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'control_coupons_state.dart';
part 'control_coupons_cubit.freezed.dart';

class ControlCouponsCubit extends Cubit<ControlCouponsState> {
  ControlCouponsCubit(this.couponRepository) : super(const ControlCouponsState.initial());

  final CouponRepository couponRepository;

  emitGetCouponRequest()async{
    try{
    emit(const ControlCouponsState.lodingGetRequestAdded());
    await couponRepository.fetchCouponsRequest().then((couponReq){
      List<Coupon> coupons = [];
      for (var element in couponReq) {
        coupons.add(element.coupon);
      }
      emit(ControlCouponsState.sucessgetRequestAdded(coupons: coupons , couponRequest: couponReq ));
    });
    }
    catch(error){
      emit(ControlCouponsState.faluiregetRequestAdded(error: error.toString()));
    }
  }

  emitApproveCouponRequest({required Coupon coupon})async{
    try{
      emit(const ControlCouponsState.loadingARCouponRequest());
      await couponRepository.approveCouponRequest(coupon);
      emit(const ControlCouponsState.approveCouponRequest());
      
    }catch(error){
      emit( ControlCouponsState.faluireapproveCouponRequest(error: error.toString()));

    }
  }
}
