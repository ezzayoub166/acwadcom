import 'package:acwadcom/features/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/authtication/data/user_repositry.dart';
import 'package:acwadcom/features/authtication/logic/login/cubit/login_cubit.dart';
import 'package:acwadcom/features/authtication/logic/register/cubit/register_cubit.dart';
import 'package:acwadcom/features/coupons/logic/cubit/create_coupon_cubit_cubit.dart';
import 'package:acwadcom/features/home/data/category_repository.dart';
import 'package:acwadcom/features/home/data/coupon_repository.dart';
import 'package:acwadcom/features/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/settings/logic/cubit/profile_cubit.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:acwadcom/helpers/services/fireabse_storage_services.dart';
import 'package:acwadcom/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {

  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  getIt.registerLazySingleton<UserRepository>(() => UserRepository());


  getIt.registerLazySingleton<TFirebaseStorageService>(()=>TFirebaseStorageService());

  getIt.registerLazySingleton<CategoryRepository>(()=>CategoryRepository());

    getIt.registerLazySingleton<CouponRepository>(()=>CouponRepository());


  // Register CacheHelper asynchronously
  getIt.registerLazySingletonAsync<CacheHelper>(() async {
    final cacheHelper = CacheHelper();
    await CacheHelper.init(); // Initialize SharedPreferences
    return cacheHelper;
  });
  // getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  //Register
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
  //Login
  getIt.registerFactory<LoginCubit>(() => LoginCubit(
      getIt<AuthenticationRepository>(), getIt<UserRepository>())); //Profile

  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<UserRepository>()));

  getIt.registerFactory<RegisterOwnerStoreCubit>(() => RegisterOwnerStoreCubit(getIt<AuthenticationRepository>(), getIt<UserRepository>()));

  getIt.registerFactory<CreateCouponCubit>(() => CreateCouponCubit(getIt<CategoryRepository>(), getIt<CouponRepository>()));
    getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<CategoryRepository>(), getIt<CouponRepository>()));


  // getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<UserRepository>()));
}
