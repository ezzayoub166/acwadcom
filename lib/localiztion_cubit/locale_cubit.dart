import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:acwadcom/helpers/services/cachce_services/chache_helper.dart';
import 'package:acwadcom/helpers/util/language_cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale('ar')));

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
getIt<CacheHelper>().getChacedLanguageCode();
    print("Fetched Language: $cachedLanguageCode"); // Debug log

    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    getIt<CacheHelper>().saveValueWithKey("LOCAL", languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}
