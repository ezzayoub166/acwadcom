
import 'package:acwadcom/models/coupon_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_owner_state.freezed.dart';

@freezed
class HomeOwnerState with _$HomeOwnerState {
  const factory HomeOwnerState.initial() = _Initial;
  const factory HomeOwnerState.loadingGetCouponsForOwner() = LoadingGetCouponsForOwner;
  const factory HomeOwnerState.successGetCouponsForOwner({required List<Coupon> coupons}) = SuccessGetCouponsForOwner;
  const factory HomeOwnerState.faluireGetCouponsForOwner({required String error}) = FaluireGetCouponsForOwner;
  const factory HomeOwnerState.emptyCouponsForOwner() = EmptyCouponsForOwner;


}
