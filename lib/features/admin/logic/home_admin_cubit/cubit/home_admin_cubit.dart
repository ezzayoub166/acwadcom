import 'package:acwadcom/features/user/home/data/category_repository.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/models/category_model.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_admin_state.dart';
part 'home_admin_cubit.freezed.dart';

class HomeAdminCubit extends Cubit<HomeAdminState> {
  HomeAdminCubit(this._couponRepository, this._categoryRepository) : super(const HomeAdminState.initial());

  final CouponRepository _couponRepository;
  final CategoryRepository _categoryRepository;

  @override
  void emit(HomeAdminState state) {
    // TODO: implement emit
    if(!isClosed){
      super.emit(state);
    }
  }


    // Fetch Coupon Count for Admin
  void emitCouponCount() async {
    try {

      // Get the coupon count from the repository
      final count = await _couponRepository.getCouponCount();

      // Emit the state with the coupon count
      emit(HomeAdminState.getNumberOFCoubons(count: count));
    } catch (onError) {
      emit(HomeAdminState.faluireGetCoupons(error: onError.toString()));
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

  CollectionReference<Coupon> fetchCoupons(){
 final couponsQuery = FirebaseFirestore.instance.collection('Coupons').withConverter(
      fromFirestore: (snapshot, _) => Coupon.fromJson(snapshot.data()!),
      toFirestore: (coupon, _) => coupon.toJson(),
    );
    return couponsQuery;
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

   void emitGetCategories() async {
    try {

      List<CategoryModel> categories =
          await _categoryRepository.getAllCategories();
      bLISTOFCATEGORY = categories;

    } catch (error) {
    }
  }
}
