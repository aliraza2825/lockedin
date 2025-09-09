import 'package:device_preview/device_preview.dart';
import 'package:medical_courier/app/config/local_keys.dart';
import 'package:medical_courier/data/Services/location_service.dart';
import 'package:medical_courier/data/provider/local_storage/local_db.dart';
import 'package:medical_courier/firebase_options.dart';
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

class MyApp extends StatelessWidget {
  final String? savedLocale;
  const MyApp({super.key, this.savedLocale});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder:
          (context) => Sizer(
            builder: (context, orientation, deviceType) {
              return GetMaterialApp(
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
