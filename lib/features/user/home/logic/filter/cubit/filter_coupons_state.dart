part of 'filter_coupons_cubit.dart';

@freezed
class FilterCouponsState with _$FilterCouponsState {
  const factory FilterCouponsState.initial() = _Initial;

  const factory FilterCouponsState.loadingGetFilterCoupons() = LoadingFilterCoupons;
  const factory FilterCouponsState.successGetFilterCoupons(
      {required List<Coupon> coupons}) = SuccessGetFilterCoupons;
  const factory FilterCouponsState.faluireGetFilterCoupons({required String error}) =
      FaluireGetFilterCoupons;
  const factory FilterCouponsState.emptyFilterCoupons() = EemptyFilterCoupons;
}
