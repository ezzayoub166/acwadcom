// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, unused_local_variable

import 'package:acwadcom/acwadcom.dart';
import 'package:acwadcom/features/admin/logic/edit_screen/cubit/edit_code_cubit.dart';
import 'package:acwadcom/features/admin/logic/request/cubit/control_coupons_cubit.dart';
import 'package:acwadcom/features/admin/ui/screens/discount_code_deatils_admin.dart';
import 'package:acwadcom/features/admin/ui/screens/edit_code_screen_admin.dart';
import 'package:acwadcom/features/admin/ui/screens/home_screen_admi.dart';
import 'package:acwadcom/features/admin/ui/screens/request_screen_admin.dart';
import 'package:acwadcom/features/admin/ui/screens/tab_bar_admin.dart';
import 'package:acwadcom/bottomTabBar.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/delete_store/cubit/delete_store_cubit.dart';
import 'package:acwadcom/features/ownerStore/features/home/delete_store.dart';
import 'package:acwadcom/features/ownerStore/features/store_data/logic/store_data_cubit.dart';
import 'package:acwadcom/features/ownerStore/features/store_data/ui/store_data.dart';
import 'package:acwadcom/features/user/authtication/UI/screens/forget_password.dart';
import 'package:acwadcom/features/user/authtication/UI/screens/login_screen.dart';
import 'package:acwadcom/features/user/authtication/UI/screens/register_screen.dart';
import 'package:acwadcom/features/user/authtication/UI/screens/reset_password.dart';
import 'package:acwadcom/features/user/authtication/UI/screens/verify_email_screen.dart';
import 'package:acwadcom/features/user/authtication/logic/login/cubit/login_cubit.dart';
import 'package:acwadcom/features/user/authtication/logic/register/cubit/register_cubit.dart';
import 'package:acwadcom/features/user/coupons/logic/cubit/create_coupon_cubit_cubit.dart';
import 'package:acwadcom/features/user/coupons/ui/screens/add_coupon_screen.dart';
import 'package:acwadcom/features/user/coupons/ui/screens/revison_response_screen.dart';
import 'package:acwadcom/features/user/explore/data/store_model.dart';
import 'package:acwadcom/features/user/explore/logic/cubit/explore_cubit.dart';
import 'package:acwadcom/features/user/explore/ui/screens/recently_added_screen.dart';
import 'package:acwadcom/features/user/home/logic/filter/cubit/filter_coupons_cubit.dart';
import 'package:acwadcom/features/user/home/logic/home/cubit/home_cubit.dart';
import 'package:acwadcom/features/user/home/logic/search/cubit/search_cubit.dart';
import 'package:acwadcom/features/user/home/ui/filter_list_coupons.dart';
import 'package:acwadcom/features/user/home/ui/list_coupons_screen.dart';
import 'package:acwadcom/features/user/home/ui/search_screen.dart';
import 'package:acwadcom/features/user/onboarding/ui/screens/onboarding_screen.dart';
import 'package:acwadcom/features/user/onboarding/ui/screens/userOrStore.dart';
import 'package:acwadcom/features/user/settings/logic/cubit/profile_cubit.dart';
import 'package:acwadcom/features/user/settings/ui/screens/change_language.dart';
import 'package:acwadcom/features/user/settings/ui/screens/contact_us.dart';
import 'package:acwadcom/features/user/settings/ui/screens/edit_profile_screen.dart';
import 'package:acwadcom/features/user/settings/ui/screens/profile.dart';
import 'package:acwadcom/features/user/store/ui/screens/store_deatils_screen.dart';
import 'package:acwadcom/helpers/Routing/routes.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/models/coupon_model.dart';
import 'package:acwadcom/models/coupon_request.dart';
import 'package:acwadcom/models/user_model.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/logic/register_owner/register_owner_store_cubit.dart';
import 'package:acwadcom/features/ownerStore/features/authitcation/ui/register_owner_store.dart';
import 'package:acwadcom/features/ownerStore/features/home/home_screen_owner.dart';
import 'package:acwadcom/features/ownerStore/features/home/statistics_screen.dart';
import 'package:acwadcom/features/ownerStore/features/home/store_owner_discount_code_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/user/explore/ui/screens/list_stores_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.chosenStatusScreen:
        return MaterialPageRoute(builder: (_) => ChosenStatusScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<LoginCubit>(),
                  child: LoginScreen(
                      // tYPEUSER: tYPEUSER,
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
                  create: (context) =>
                      getIt<ProfileCubit>()..emitLoadingProfileData(),
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
      case Routes.deleteStoreScreen:
      final text = settings.arguments as String ;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<DeleteStoreCubit>(),
                  child: DeleteStore(text: text),
                ));
      case Routes.storeDataProfile:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<StoreDataCubit>()..fetchUserData(),
                  child: StoreDataScreen(),
                ));
      // case Routes.storeDeatilsScreen:
      //   final store = settings.arguments as UserModel;
      //   return MaterialPageRoute(
      //       builder: (context) => BlocProvider(
      //         create: (context) => getIt<ExploreCubit>()..getCouponsForSelectedStore(store.id),
      //         child: StoreDeatilsScreen(
      //           store: store,
      //         ),
      //       ));

      // case Routes.storeDeatilsScreen:
      //   // final store = settings.arguments as UserModel;
      //   return MaterialPageRoute(
      //       builder: (context) => StoreDeatilsScreen(
      //         store: store,
      //       ));
      case Routes.revisonResponseScreen:
        return MaterialPageRoute(builder: (context) => RevisonResponseScreen());
      case Routes.registerOwnerStore:
        final tYPEUSER = settings.arguments as String;

        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<RegisterOwnerStoreCubit>(),
                  child: RegisterOwnerStore(
                    selectStatus: tYPEUSER,
                  ),
                ));
      case Routes.homeScreenForOwenerStore:
        return MaterialPageRoute(builder: (context) => HomeScreenOwner());
      case Routes.storeOwnerDiscountCodeDetails:
      final coupon = settings.arguments as Coupon;
        return MaterialPageRoute(
            builder: (context) => StoreOwnerDiscountCodeDetails(coupon: coupon,));
      case Routes.statisticsPage:
        return MaterialPageRoute(
            builder: (context) => MerchantStatisticsPage());
      case Routes.tabBarAdmin:
        return MaterialPageRoute(builder: (context) => BottomTabBarAdmin());
      case Routes.homeScreenAdmi:
        return MaterialPageRoute(builder: (context) => HomeScreenAdmin());
      case Routes.requestScreenAdmin:
        return MaterialPageRoute(builder: (context) => RequestScreenAdmin());
      // case Routes.editCodeScreenAdmin:
      //   return MaterialPageRoute(
      //       builder: (context) => BlocProvider(
      //             create: (context) => EditCodeCubit(),
      //             child: EditCodeScreenAdmin(),
      //           ));

      case Routes.discountCodeDeatilsAdmin:
        final couponReq = settings.arguments as CouponRequest;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<ControlCouponsCubit>(),
                  child: DiscountCodeDeatilsAdmin(
                    couponRequest: couponReq,
                  ),
                ));
      case Routes.verifyEmailScreen:
        final typeUser = settings.arguments as String;
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

      case Routes.searchScreen:
        // final items = settings.arguments as List<Coupon>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SearchCubit(),
                  child: SearchScreen(),
                ));

      case Routes.listOfStoresScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => getIt<ExploreCubit>()..fetchStores(),
                child: ListStoresScreen()));
      case Routes.listOfCoupons:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<HomeCubit>()..emitGetAllCoupons(),
                  child: ListCouponsScreen(),
                ));

      case Routes.listOfFilterdCouponsScreen:
        final argument = settings.arguments as FilterItem;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => getIt<FilterCouponsCubit>()
                  ..emitFilterCoupons(argument.categoryID, argument.rate),
                child: FilterListCoupons(
                    categoryID: argument.categoryID, rate: argument.rate)));

      case Routes.listRecentlyAddedCouponsScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      getIt<ExploreCubit>()..fetchCouponsAddedRecently(30),
                  child: ListRecentlyAddedCouponsScreen(),
                ));

      //  case Routes.noInterntScreen:
      //  return MaterialPageRoute(builder:(context) => NoInterntScreen());
    }
  }
}

class FilterItem {
  final String categoryID;
  final int rate;

  FilterItem({required this.categoryID, required this.rate});
}
