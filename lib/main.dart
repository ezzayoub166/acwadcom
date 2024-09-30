import 'package:acwadcom/acwadcom.dart';
import 'package:acwadcom/cubit/locale_cubit.dart';
import 'package:acwadcom/helpers/Routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => LocaleCubit()..getSavedLanguage(),
    child: AcwadcomApp(appRouter: AppRouter()),
  ));
}
