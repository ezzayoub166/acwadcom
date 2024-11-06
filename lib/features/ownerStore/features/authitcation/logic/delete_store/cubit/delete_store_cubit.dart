import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_store_state.dart';
part 'delete_store_cubit.freezed.dart';

class DeleteStoreCubit extends Cubit<DeleteStoreState> {
  DeleteStoreCubit(this.couponRepository, this.userRepository) : super(DeleteStoreState.initial());

  final CouponRepository couponRepository;
  final UserRepository userRepository;
  


  emitDeleteStore()async{
    try{
      emit(DeleteStoreState.loadingRemoveStore());
      var storeId = getIt<CacheHelper>().getValueWithKey("userID");
      await userRepository.removeUserRecord(storeId).then((_){
        couponRepository.removeCoupons(storeId);
      });
      
      emit(DeleteStoreState.successRemoveStore());
    }catch(error){
      emit(DeleteStoreState.faluireRemoveStore(error: error.toString()));
    }
  }
}
