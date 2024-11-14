import 'dart:async';

import 'package:acwadcom/app_localizations.dart';
import 'package:acwadcom/localiztion_cubit/locale_cubit.dart';
import 'package:acwadcom/helpers/Routing/app_router.dart';
import 'package:acwadcom/helpers/Routing/routes.dart';
import 'package:acwadcom/helpers/constants/extenstions.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:acwadcom/helpers/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';


class ConnectivityCubit extends Cubit<bool> {
  late StreamSubscription _connectionSubscription;

  ConnectivityCubit() : super(true) {
    _monitorConnection();
  }

  void _monitorConnection() {
    _connectionSubscription = InternetConnection().onStatusChange.listen((event) {
      emit(event == InternetStatus.connected);
    });
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();
    return super.close();
  }
}




class AcwadcomApp extends StatelessWidget {
  final AppRouter appRouter;

  const AcwadcomApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    isOpenApp = CacheHelper.instance.getValueWithKey('OpenApp') ?? false;

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Acwadcom',
              theme: appThemeData,

              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (devicelocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (devicelocale != null &&
                      devicelocale.languageCode == locale.languageCode) {
                    return devicelocale;
                  }
                }
                return supportedLocales.first;
              },
              supportedLocales: const [
                Locale('en'), // English
                Locale('ar'), // Greek
              ],
              locale: state.locale,
// Set the locale you want the app to display messages

              debugShowCheckedModeBanner: false,
              initialRoute: isOpenApp
                  ? (isLoggedInUser && tYPEUSER != ""
                      ? (tYPEUSER == "USER"
                          ? Routes.bottomTabBarScreen
                          : Routes
                              .homeScreenForOwenerStore) // Handles both USER and STOREOWNER
                      : Routes.loginScreen)
                  : Routes.onBoardingScreen,
              onGenerateRoute: appRouter.generateRoute,
            );
          },
        ));
  }
}
