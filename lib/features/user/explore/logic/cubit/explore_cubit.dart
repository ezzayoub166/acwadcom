import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_state.dart';
part 'explore_cubit.freezed.dart';

class ExploreCubit extends Cubit<ExploreState> {

  ExploreCubit(this.userRepository) : super(const ExploreState.initial());


  final UserRepository userRepository ; 

  Future<List<Coupon>> feathcMostUsedCoupons()async{
    return  [Coupon.empty()];
  }

   Future<List<UserModel>> feathcSpecialStores()async{
    return  [UserModel.empty()];
  }

  Future<List<Coupon>> feathcCouponsAddedRecently()async{
    return  [Coupon.empty()];
  }






  



}
