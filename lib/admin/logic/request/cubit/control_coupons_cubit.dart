import 'package:acwadcom/features/home/data/coupon_repository.dart';
import 'package:acwadcom/models/coupon_model.dart';
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
    await couponRepository.fetchCouponsRequest().then((coupons){
      emit(ControlCouponsState.sucessgetRequestAdded(coupons: coupons));
    });
    }
    catch(error){
      emit(ControlCouponsState.faluiregetRequestAdded(error: error.toString()));
    }
  }
}
