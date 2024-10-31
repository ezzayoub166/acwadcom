import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_coupons_state.dart';
part 'filter_coupons_cubit.freezed.dart';

class FilterCouponsCubit extends Cubit<FilterCouponsState> {


  FilterCouponsCubit(this._couponRepository) : super(FilterCouponsState.initial());

  final CouponRepository _couponRepository;


  void emitFilterCoupons(String categoryID , int rate)async{

  try{
    emit(const FilterCouponsState.loadingGetFilterCoupons());
    print(categoryID);
    print(rate);
   final coupons = await _couponRepository.filterCoupons(categoryID: categoryID, rate: rate);

   if(coupons.isEmpty){
    emit( const FilterCouponsState.emptyFilterCoupons());
   }else{
   emit(FilterCouponsState.successGetFilterCoupons(coupons: coupons));
   }
  }catch(error){

    emit(FilterCouponsState.faluireGetFilterCoupons(error: error.toString()));
  }
}
}
