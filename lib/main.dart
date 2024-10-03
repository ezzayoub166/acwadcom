
import 'dart:io';

import 'package:acwadcom/acwadcom.dart';
import 'package:acwadcom/cubit/locale_cubit.dart';
import 'package:acwadcom/helpers/Routing/app_router.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';




void main() async{

   WidgetsFlutterBinding.ensureInitialized();
      if(Platform.isAndroid){
      await Firebase.initializeApp(
         options: const FirebaseOptions(
            apiKey:"AIzaSyDEsuC-rOx0AgW5rksnMrMPoN7VdWpjjQo", // paste your api key here
            appId: "1:242503319267:android:4c2cd1f1fed510ab3e4fd6", //paste your app id here
            messagingSenderId: "242503319267", //paste your messagingSenderId here
            projectId: "acwadcom-8ab26", //paste your project id here
         ),
      );
   }else{
      await Firebase.initializeApp();
   }


  //  FirebaseFirestore.instance.collection("TEST").add(["Nmae":"Ezz"]);
  //  print(FirebaseAuth.instance.app.name);
  
  runApp(BlocProvider(
    create: (context) => LocaleCubit()..getSavedLanguage(),
    child: AcwadcomApp(appRouter: AppRouter()),
  ));
}
