import 'package:get/get.dart';
import 'package:locked_in/app/localization/lang/de.dart';

import 'lang/en.dart';
import 'lang/es.dart';
import 'lang/fr.dart';

class AppLanguages extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      "en_US": english,
      "de_DE": german,
      "fr_FR": french,
      "es_ES": spanish
    };
  }
}
