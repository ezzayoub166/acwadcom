part of 'control_coupons_cubit.dart';

@freezed
class ControlCouponsState with _$ControlCouponsState {
  const factory ControlCouponsState.initial() = _Initial;
  const factory ControlCouponsState.lodingGetRequestAdded() = LodingGetRequestAdded;
  const factory ControlCouponsState.sucessgetRequestAdded({required List<Coupon> coupons}) = SucessgetRequestAdded;
  const factory ControlCouponsState.faluiregetRequestAdded({required String error}) = FaluiregetRequestAdded;
  const factory ControlCouponsState.approveCouponRequest() = ApproveCouponRequest;
  const factory ControlCouponsState.rejectCouponRequest() = RejectCouponRequest;



}
