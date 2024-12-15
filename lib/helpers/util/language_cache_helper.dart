import 'package:acwadcom/acwadcom_packges.dart';
import 'package:acwadcom/helpers/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCacheHelper {
  Future<void> cacheLanguageCode(String languageCode) async {
    // final sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString("LOCALE", languageCode);
    getIt<CacheHelper>().saveValueWithKey("LOCALE", languageCode);
  }

  Future<String> getCachedLanguageCode() async {
    // final sharedPreferences = await SharedPreferences.getInstance();
    // final cachedLanguageCode = sharedPreferences.getString("LOCALE");
    final cachedLanguageCode = getIt<CacheHelper>().getChacedLanguageCode();
    if (cachedLanguageCode != null) {
      return cachedLanguageCode;
    } else {
      return "en";
    }
  }
}
