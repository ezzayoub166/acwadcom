import 'package:acwadcom/features/admin/logic/home_admin_cubit/cubit/home_admin_cubit.dart';
import 'package:acwadcom/features/admin/logic/request/cubit/control_coupons_cubit.dart';
import 'package:acwadcom/features/admin/srvices/coupon_request_services.dart';
import 'package:acwadcom/features/user/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/user/authtication/data/user_repositry.dart';
import 'package:acwadcom/features/user/authtication/logic/login/cubit/login_cubit.dart';
import 'package:acwadcom/features/user/authtication/logic/register/cubit/register_cubit.dart';
import 'package:acwadcom/features/user/coupons/logic/cubit/create_coupon_cubit_cubit.dart';
import 'package:acwadcom/features/user/home/data/category_repository.dart';
import 'package:acwadcom/features/user/home/data/coupon_repository.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/settings/logic/cubit/profile_cubit.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:acwadcom/helpers/services/fireabse_storage_services.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  getIt.registerLazySingleton<UserRepository>(() => UserRepository());

  getIt.registerLazySingleton<TFirebaseStorageService>(
      () => TFirebaseStorageService());

  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepository());

  getIt.registerLazySingleton<CouponRepository>(() => CouponRepository());

  getIt.registerLazySingleton<CouponRequestService>(
      () => CouponRequestService());

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

  getIt.registerFactory<ProfileCubit>(
      () => ProfileCubit(getIt<UserRepository>()));
  getIt.registerFactory<HomeAdminCubit>(
      () => HomeAdminCubit(getIt<CouponRepository>()));
  getIt.registerFactory<ControlCouponsCubit>(
      () => ControlCouponsCubit(getIt<CouponRepository>()));

  getIt.registerFactory<RegisterOwnerStoreCubit>(() => RegisterOwnerStoreCubit(
      getIt<AuthenticationRepository>(), getIt<UserRepository>()));

  getIt.registerFactory<CreateCouponCubit>(() => CreateCouponCubit(
      getIt<CategoryRepository>(),
      getIt<CouponRepository>(),
      getIt<UserRepository>()));
  getIt.registerFactory<HomeCubit>(
      () => HomeCubit(getIt<CategoryRepository>(), getIt<CouponRepository>()));

  // getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<UserRepository>()));
}
