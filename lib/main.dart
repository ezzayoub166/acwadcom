import 'package:acwadcom/acwadcom.dart';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/features/user/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:acwadcom/features/user/wishlist/widgets/wish_list_copuns.dart';
import 'package:acwadcom/localiztion_cubit/locale_cubit.dart';
import 'package:acwadcom/features/user/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/helpers/Routing/app_router.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

checkIfLoggedInUser() async {
  String? userToken = getIt<CacheHelper>().getValueWithKey("userID");
  // UserModel? userFetched = await  getIt<CacheHelper>().getUser();

  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}

checkIfUserOrStoreOWner() async {
  tYPEUSER = getIt<CacheHelper>().getValueWithKey("tYPEUSER") ?? "";
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await getIt.isReady<
      CacheHelper>(); // Ensure CacheHelper is initialized before the app starts
  checkIfLoggedInUser();
  checkIfUserOrStoreOWner();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LocaleCubit>(
        create: (context) => LocaleCubit()..getSavedLanguage(),
      ),
      BlocProvider<AvatarCubit>(
        create: (context) => AvatarCubit(),
      ),
      BlocProvider<WishlistCubit>(
          create: (context) => getIt<WishlistCubit>()
            ..feathcoWishList()
            ..featchWishLitForStores())
    ],
    child: AcwadcomApp(appRouter: AppRouter()),
  ));
}
