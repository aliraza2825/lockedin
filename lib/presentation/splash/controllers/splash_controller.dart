import 'dart:convert';
import 'dart:io';

import 'package:medical_courier/app/config/app_colors.dart';
import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/app/config/local_keys.dart';
import 'package:medical_courier/app/routes/app_pages.dart';
import 'package:medical_courier/app/utils/connectivity_service.dart';
import 'package:medical_courier/data/provider/local_storage/local_db.dart';
import 'package:medical_courier/data/provider/network/api_endpoint.dart';
import 'package:medical_courier/data/repositories/diy_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../app/config/global_var.dart';
import '../../../app/utils/utils.dart';

class SplashController extends GetxController {
  DIYRepository diyRepository = DIYRepository();
  bool? forceUpdate;
  bool? useTestLink;
  String versionIOS = "";
  String versionAndroid = "";
  int? buildAndroid;
  int? buildIOS;
  final databaseReference = FirebaseDatabase.instance.ref('/');

  @override
  void onInit() async {
    super.onInit();
    Get.put(CheckConnectivity());
    SharedPreferences sp = await SharedPreferences.getInstance();
    Globals.language = sp.getString(LocalDataKey.language.name) ?? "";
    Globals.authToken =
        await LocalDB.getData(LocalDataKey.authToken.name) ?? "";
    Globals.phoneNumber =
        await LocalDB.getData(LocalDataKey.phoneNumber.name) ?? "";
    Globals.fullName = await LocalDB.getData(LocalDataKey.firstName.name) ?? "";

    Globals.userId = await LocalDB.getData(LocalDataKey.userId.name) ?? 0;

    await getBaseUrlFromFirebase();
    if (Globals.language == "") {
      navigateTo(Routes.SELECT_LANGUAGE, null, prop: false);
    } else if (Globals.authToken != "") {
      verifyToken();
    } else {
      navigateTo(Routes.SIGNIN_WITH_PIN, null, prop: false);
    }
  }

  Future getBaseUrlFromFirebase() async {
    print('SplashController.getBaseUrlFromFirebase');
    try {
      await databaseReference.once().then((event) async {
        final snapshot = event.snapshot;
        debugPrint('Data : ${snapshot.value}');

        forceUpdate = snapshot.child('forceUpdate').value as bool?;
        useTestLink = snapshot.child('useTestLink').value as bool?;
        versionIOS = snapshot.child('versionIOS').value.toString();
        versionAndroid = snapshot.child('versionAndroid').value.toString();
        buildAndroid = snapshot.child('buildAndroid').value as int?;
        buildIOS = snapshot.child('buildIOS').value as int?;
        print("testLink $versionIOS $versionAndroid $buildAndroid $buildIOS");
        if (useTestLink == false) {
          ApiEndPoints.baseUrl = snapshot.child('base_url').value.toString();
          ApiEndPoints.base = ApiEndPoints.baseUrl.split("api/")[0];
        } else if (useTestLink == true) {
          Get.log('SplashController.getBaseUrlFromFirebase TestUrl');
          ApiEndPoints.baseUrl = snapshot.child('test_url').value.toString();
          ApiEndPoints.base = ApiEndPoints.baseUrl.split("api/")[0];
        }
        // ApiEndPoints.baseUrl= snapshot.child('base_url').value.toString();
      });
    } on Exception catch (e) {
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
      print('SplashController.getBaseUrlFromFirebase');
      print(e.toString());
      // TODO
    }
  }

  Future<bool> checkForUpdate() async {
    bool isForceUpdate = false;
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      Globals.appVersion = packageInfo.version;
      Globals.buildNumber = packageInfo.buildNumber;

      try {
        if (forceUpdate == true) {
          if (Platform.isIOS) {
            if (versionIOS != Globals.appVersion ||
                buildIOS != int.parse(Globals.buildNumber!)) {
              Get.log('SplashController.checkForUpdate ');
              Future.delayed(Duration(seconds: 2))
                  .then((value) => updateRequired());
              isForceUpdate = true;
            }
          } else if (Platform.isAndroid) {
            if (versionAndroid != Globals.appVersion ||
                buildAndroid != int.parse(Globals.buildNumber!)) {
              Future.delayed(Duration(seconds: 2))
                  .then((value) => updateRequired());
            }
          }
        } else {
          isForceUpdate = false;
        }
      } on Exception catch (e) {
        debugPrint("${e.toString()}");
      }
    });
    return isForceUpdate;
  }

  updateRequired() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (c) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Utils.getIconPath("logo"),
                  scale: 8.0,
                ).paddingOnly(right: 32),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "New version available",
                  style: AppTextStyles.heading
                      .copyWith(fontSize: 18, color: AppColors.primary),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "${Platform.isIOS ? "${versionIOS} ($buildIOS)" : "${versionAndroid} ($buildAndroid)"}",
                  style: AppTextStyles.heading
                      .copyWith(fontSize: 18, color: AppColors.primary),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Looks like you have an older version of the app. Please update to get latest features and best experience.",
                  maxLines: 4,
                  style: AppTextStyles.bodyText
                      .copyWith(fontSize: 14, color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    openAppStore();
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: AppColors.secondaryGradient),
                    child: Center(
                      child: Text(
                        "Update",
                        style: AppTextStyles.bodyTextBold
                            .copyWith(fontSize: 18, color: AppColors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void openAppStore() async {
    String url = "";
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/details?id=com.diy_max.app';
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/app/6738170498';
    }

    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> verifyToken() async {
    navigateTo(Routes.NAVBAR, null);
  }

  navigateTo(String route, arg, {prop}) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        Get.offAndToNamed(route, arguments: arg);
        checkForUpdate();
      });
    });
  }
}