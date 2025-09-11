import 'package:device_preview/device_preview.dart';
import 'package:locked_in/app/config/local_keys.dart';
import 'package:locked_in/data/Services/location_service.dart';
import 'package:locked_in/data/provider/local_storage/local_db.dart';
import 'package:locked_in/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/localization/app_languages.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ Initialize SharedPreferences and get saved locale
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLocale = prefs.getString(LocalDataKey.language.name) ?? 'en_US';

  // ✅ Register dependencies
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LocalDB());

  // ✅ Register your LocationService
  Get.put(LocationService());

  // ✅ Lock orientation and run the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp(savedLocale: savedLocale));
  });
}

/// Function to clear all SharedPreferences data
/// This can be useful for debugging, testing, or implementing a "clear data" feature
Future<void> clearSharedPreferences() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('✅ SharedPreferences cleared successfully');
  } catch (e) {
    print('❌ Error clearing SharedPreferences: $e');
  }
}

/// Function to clear specific SharedPreferences keys
/// Useful for clearing only certain data while keeping others
Future<void> clearSpecificSharedPreferences(List<String> keys) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (String key in keys) {
      await prefs.remove(key);
    }
    print('✅ Specific SharedPreferences keys cleared: $keys');
  } catch (e) {
    print('❌ Error clearing specific SharedPreferences: $e');
  }
}

/// Function to reset onboarding status
/// This will make the app show onboarding again on next launch
Future<void> resetOnboardingStatus() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', false);
    print('✅ Onboarding status reset - will show onboarding on next launch');
  } catch (e) {
    print('❌ Error resetting onboarding status: $e');
  }
}

class MyApp extends StatelessWidget {
  final String? savedLocale;
  const MyApp({super.key, this.savedLocale});

  @override
  Widget build(BuildContext context) {
    // clearSharedPreferences();
    return DevicePreview(
      enabled: false,
      builder:
          (context) => Sizer(
            builder: (context, orientation, deviceType) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Medical Rider",
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
                translations: AppLanguages(),
                locale: Locale(savedLocale!),
                theme: ThemeData(fontFamily: 'Poppins'),
                builder: (BuildContext context, Widget? child) {
                  final MediaQueryData data = MediaQuery.of(context);
                  return MediaQuery(
                    data: data.copyWith(textScaler: const TextScaler.linear(1)),
                    child: child ?? Container(),
                  );
                },
              );
            },
          ),
    );
  }
}
