import 'package:acwadcom/features/authtication/data/authentication_repository.dart';
import 'package:acwadcom/features/authtication/data/user_repositry.dart';
import 'package:acwadcom/features/authtication/logic/login/cubit/login_cubit.dart';
import 'package:acwadcom/features/authtication/logic/register/cubit/register_cubit.dart';
import 'package:acwadcom/features/settings/logic/cubit/profile_cubit.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {

  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  getIt.registerLazySingleton<UserRepository>(() => UserRepository());

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
}
