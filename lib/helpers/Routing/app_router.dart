// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, unused_local_variable

import 'package:acwadcom/bottomTabBar.dart';
import 'package:acwadcom/features/authtication/UI/screens/login_screen.dart';
import 'package:acwadcom/features/authtication/UI/screens/register_screen.dart';
import 'package:acwadcom/features/coupons/logic/cubit/cubit/create_coupon_cubit.dart';
import 'package:acwadcom/features/coupons/ui/screens/add_coupon_screen.dart';
import 'package:acwadcom/features/explore/data/store_model.dart';
import 'package:acwadcom/features/onboarding/ui/screens/onboarding_screen.dart';
import 'package:acwadcom/features/onboarding/ui/screens/userOrStore.dart';
import 'package:acwadcom/features/settings/ui/screens/change_language.dart';
import 'package:acwadcom/features/settings/ui/screens/contact_us.dart';
import 'package:acwadcom/features/settings/ui/screens/profile.dart';
import 'package:acwadcom/features/store/ui/screens/store_deatils_screen.dart';
import 'package:acwadcom/helpers/Routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.chosenStatusScreen:
        return MaterialPageRoute(builder: (_) => ChosenStatusScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUpScreen:
        final selectStatus = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => RegisterScreen(selectStatus: selectStatus));
      case Routes.bottomTabBarScreen:
        return MaterialPageRoute(builder: (_) => Bottomtabbar());
      case Routes.languageSelectionPage:
        return MaterialPageRoute(builder: (_) => LanguageSelectionPage());
      case Routes.profileScreen:
        final isEdit = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => ProfileScreen(
                  isEdit: isEdit,
                ));
      case Routes.contactUs:
        return MaterialPageRoute(builder: (_) => ContactUs());
      case Routes.createCodeForUserScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CreateCouponCubit(),
                  child: CreateCodeScreen(),
                ));

      case Routes.storeDeatilsScreen:
      final store = settings.arguments as StoreModel;
      return MaterialPageRoute(builder: (context) => StoreDeatilsScreen(store: store,));          
            
    }
  }
}
