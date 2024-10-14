// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, unused_local_variable

import 'package:acwadcom/admin/logic/edit_screen/cubit/edit_code_cubit.dart';
import 'package:acwadcom/admin/ui/screens/discount_code_deatils_admin.dart';
import 'package:acwadcom/admin/ui/screens/edit_code_screen_admin.dart';
import 'package:acwadcom/admin/ui/screens/home_screen_admi.dart';
import 'package:acwadcom/admin/ui/screens/request_screen_admin.dart';
import 'package:acwadcom/admin/ui/screens/tab_bar_admin.dart';
import 'package:acwadcom/bottomTabBar.dart';
import 'package:acwadcom/features/authtication/UI/screens/forget_password.dart';
import 'package:acwadcom/features/authtication/UI/screens/login_screen.dart';
import 'package:acwadcom/features/authtication/UI/screens/register_screen.dart';
import 'package:acwadcom/features/authtication/UI/screens/reset_password.dart';
import 'package:acwadcom/features/authtication/UI/screens/verify_email_screen.dart';
import 'package:acwadcom/features/authtication/logic/login/cubit/login_cubit.dart';
import 'package:acwadcom/features/authtication/logic/register/cubit/register_cubit.dart';
import 'package:acwadcom/features/coupons/logic/cubit/create_coupon_cubit_cubit.dart';
import 'package:acwadcom/features/coupons/ui/screens/add_coupon_screen.dart';
import 'package:acwadcom/features/coupons/ui/screens/revison_response_screen.dart';
import 'package:acwadcom/features/explore/data/store_model.dart';
import 'package:acwadcom/features/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/onboarding/ui/screens/onboarding_screen.dart';
import 'package:acwadcom/features/onboarding/ui/screens/userOrStore.dart';
import 'package:acwadcom/features/settings/logic/cubit/profile_cubit.dart';
import 'package:acwadcom/features/settings/ui/screens/change_language.dart';
import 'package:acwadcom/features/settings/ui/screens/contact_us.dart';
import 'package:acwadcom/features/settings/ui/screens/edit_profile_screen.dart';
import 'package:acwadcom/features/settings/ui/screens/profile.dart';
import 'package:acwadcom/features/store/ui/screens/store_deatils_screen.dart';
import 'package:acwadcom/helpers/Routing/routes.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:acwadcom/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';
import 'package:acwadcom/ownerStore/features/authitcation/ui/register_owner_store.dart';
import 'package:acwadcom/ownerStore/features/home/home_screen_owner.dart';
import 'package:acwadcom/ownerStore/features/home/statistics_screen.dart';
import 'package:acwadcom/ownerStore/features/home/store_owner_discount_code_details.dart';
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
        final tYPEUSER = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<LoginCubit>(),
                  child: LoginScreen(
                    tYPEUSER: tYPEUSER,
                  ),
                ));
      case Routes.signUpScreen:
        final selectStatus = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<RegisterCubit>(),
                  child: RegisterScreen(selectStatus: selectStatus),
                ));
      case Routes.bottomTabBarScreen:
        return MaterialPageRoute(builder: (_) => Bottomtabbar());
      case Routes.languageSelectionPage:
        return MaterialPageRoute(builder: (_) => LanguageSelectionPage());
      case Routes.profileScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<ProfileCubit>(),
                  child: ProfileScreen(),
                ));
      case Routes.contactUs:
        return MaterialPageRoute(builder: (_) => ContactUs());
      case Routes.createCodeForUserScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<CreateCouponCubit>(),
                  child: CreateCodeScreen(),
                ));

      case Routes.storeDeatilsScreen:
        final store = settings.arguments as StoreModel;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<HomeCubit>(),
                  child: StoreDeatilsScreen(
                    store: store,
                  ),
                ));
      case Routes.revisonResponseScreen:
        return MaterialPageRoute(builder: (context) => RevisonResponseScreen());
      case Routes.registerOwnerStore:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<RegisterOwnerStoreCubit>(),
                  child: RegisterOwnerStore(),
                ));
      case Routes.homeScreenForOwenerStore:
        return MaterialPageRoute(builder: (context) => HomeScreenOwner());
      case Routes.storeOwnerDiscountCodeDetails:
        return MaterialPageRoute(
            builder: (context) => StoreOwnerDiscountCodeDetails());
      case Routes.statisticsPage:
        return MaterialPageRoute(
            builder: (context) => MerchantStatisticsPage());
      case Routes.tabBarAdmin:
        return MaterialPageRoute(builder: (context) => BottomTabBarAdmin());
      case Routes.homeScreenAdmi:
        return MaterialPageRoute(builder: (context) => HomeScreenAdmin());
      case Routes.requestScreenAdmin:
        return MaterialPageRoute(builder: (context) => RequestScreenAdmin());
      case Routes.editCodeScreenAdmin:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => EditCodeCubit(),
                  child: EditCodeScreenAdmin(),
                ));

      case Routes.discountCodeDeatilsAdmin:
        return MaterialPageRoute(
            builder: (context) => DiscountCodeDeatilsAdmin());
      case Routes.verifyEmailScreen:
        final typeUser = settings.arguments as UserType;
        return MaterialPageRoute(
            builder: (context) => VerifyEmailScreen(typeUser: typeUser));
      case Routes.forgetPassword:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<LoginCubit>(),
                  child: ForgetPassword(),
                ));

      case Routes.resetPassword:
        final email = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<LoginCubit>(),
                  child: ResetPassword(email: email),
                ));

      case Routes.editProfileScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<ProfileCubit>(),
                  child: EditProfileScreen(),
                ));
    }
  }
}
