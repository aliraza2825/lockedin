import 'dart:ui';

import 'package:get/get.dart';
import 'package:medical_courier/app/config/local_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguageController extends GetxController {
  //TODO: Implement SelectLanguageController

String locale = "English";
  @override
  void onInit() {
    super.onInit();
  }

Future saveLanguage() async {
    SharedPreferences sp =await SharedPreferences.getInstance();
  await sp.setString(LocalDataKey.language.name, locale=="English" ? "en_US":locale=="French" ?"fr_FR":locale=="Spanish" ?"es_ES" : "de_DE");
 var d =  sp.getString(LocalDataKey.language.name) ?? "";
 print(d);
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
}
