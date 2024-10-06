

import 'package:acwadcom/acwadcom.dart';
import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/cubit/locale_cubit.dart';
import 'package:acwadcom/helpers/Routing/app_router.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:acwadcom/ownerStore/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

checkIfLoggedInUser(){
  String? userToken = getIt<CacheHelper>().getValueWithKey("userID");
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}



void main() async{

   WidgetsFlutterBinding.ensureInitialized();
   setupGetIt();
    await getIt.isReady<CacheHelper>(); // Ensure CacheHelper is initialized before the app starts
   checkIfLoggedInUser();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(BlocProvider(
    create: (context) => LocaleCubit()..getSavedLanguage(),
    child: AcwadcomApp(appRouter: AppRouter()),
  ));
}
