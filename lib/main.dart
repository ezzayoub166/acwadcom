

import 'package:acwadcom/acwadcom.dart';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/localiztion_cubit/locale_cubit.dart';
import 'package:acwadcom/features/home/logic/avatar/avatar_cubit.dart';
import 'package:acwadcom/helpers/Routing/app_router.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/ownerStore/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

checkIfLoggedInUser()async{
  String? userToken = getIt<CacheHelper>().getValueWithKey("userID");
  // UserModel? userFetched = await  getIt<CacheHelper>().getUser();

  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}

checkIfUserOrStoreOWner()async{
   tYPEUSER = getIt<CacheHelper>().getValueWithKey("tYPEUSER") ?? "";
  // UserModel? userFetched = await  getIt<CacheHelper>().getUser();

  // if (tYPEUSER == "USER") {
  //   tYPEUSER = "USER";
  // } else {
  //   tYPEUSER = "STOREOWNER";
  // }
}



void main() async{

   WidgetsFlutterBinding.ensureInitialized();
   setupGetIt();
    await getIt.isReady<CacheHelper>(); // Ensure CacheHelper is initialized before the app starts
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
      create: (context) => AvatarCubit()..loadProfileData(),
      
    ),
  ],
  child: AcwadcomApp(appRouter: AppRouter()),
));
}
