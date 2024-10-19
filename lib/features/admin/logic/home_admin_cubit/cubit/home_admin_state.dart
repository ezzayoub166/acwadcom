part of 'home_admin_cubit.dart';

@freezed
class HomeAdminState with _$HomeAdminState {
  const factory HomeAdminState.initial() = _Initial;
  const factory HomeAdminState.loadingCoupons() = LoadingCoupons;
  const factory HomeAdminState.successGetCoupons({required List<Coupon> coupons}) = SuccessGetCoupons;
  const factory HomeAdminState.faluireGetCoupons({required String error}) = FaluireGetCoupons;
  const factory HomeAdminState.getNumberOFCoubons({required int count}) = GetNumberOFCoubons;
    const factory HomeAdminState.loadingRemove() = LoadingRemove;
    const factory HomeAdminState.sucessRemove() = SucessRemove;
    const factory HomeAdminState.faluireRemove() = FaluireRemove;



}
