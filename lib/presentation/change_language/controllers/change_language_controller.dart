import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/config/local_keys.dart';

class ChangeLanguageController extends GetxController {
  //TODO: Implement ChangeLanguageController

  String locale = "English";
  String lang = "en";
  List<String> languages = ['en','fr','de','es'];
  @override
  void onInit() {
    print(Get.locale);
    setCurrentLocale();
    super.onInit();
  }

  String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'fr':
        return 'French';
      case 'de':
        return 'German';
      case 'es':
        return 'Spanish';
      default:
        return 'Unknown Language';
    }
  }


  Future saveLanguage() async {
    locale =  getLanguageName(lang);
    SharedPreferences sp =await SharedPreferences.getInstance();
    await sp.setString(LocalDataKey.language.name, locale=="English" ? "en_US":locale=="French" ?"fr_FR":locale=="Spanish" ?"es_ES" : "de_DE");

    if (locale == 'English') {
      Get.updateLocale(const Locale('en_US'));
    } else if (locale == 'French') {
      Get.updateLocale(const Locale('fr_FR'));
    }else if(locale=="Spanish"){
      Get.updateLocale(const Locale('es_ES'));
    }else{
      Get.updateLocale(const Locale('de_DE'));
    }
    update();

  }

  void setCurrentLocale() {
    switch(Get.locale.toString()) {
      case 'en_US':  // English (US)
        lang = 'en';
        break;
      case 'fr_FR':  // French (France)
        lang = 'fr';
        break;
      case 'de_DE':  // German (Germany)
        lang = 'de';
        break;
      case 'es_ES':  // Spanish (Spain)
        lang = 'es';
        break;
      default:       // Fallback to default locale
        lang = 'en'; // Set default language if the locale is not recognized
        break;
    }
  }
}
