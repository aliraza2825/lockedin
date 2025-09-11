import 'dart:io';

import 'package:locked_in/app/config/app_colors.dart';
import 'package:locked_in/app/config/app_text_styles.dart';
import 'package:locked_in/app/config/global_var.dart';
import 'package:locked_in/app/config/local_keys.dart';
import 'package:locked_in/app/routes/app_pages.dart';
import 'package:locked_in/app/utils/connectivity_service.dart';
import 'package:locked_in/app/utils/utils.dart';
import 'package:locked_in/data/provider/local_storage/local_db.dart';
import 'package:locked_in/data/provider/network/api_endpoint.dart';
import 'package:locked_in/data/repositories/diy_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
    if (Globals.authToken != "") {
      verifyToken();
    } else {
      // Check if user has seen onboarding before
      bool hasSeenOnboarding = sp.getBool('has_seen_onboarding') ?? false;
      if (hasSeenOnboarding) {
        // navigateTo(Routes.SIGNIN_WITH_PIN, null, prop: false);
        navigateTo(Routes.NAVBAR, null, prop: false);
      } else {
        navigateTo(Routes.ONBOARDING, null, prop: false);
      }
    }
  }

  Future getBaseUrlFromFirebase() async {
    try {
      await databaseReference.once().then((event) async {
        final snapshot = event.snapshot;
        forceUpdate = snapshot.child('forceUpdate').value as bool?;
        useTestLink = snapshot.child('useTestLink').value as bool?;
        versionIOS = snapshot.child('versionIOS').value.toString();
        versionAndroid = snapshot.child('versionAndroid').value.toString();
        buildAndroid = snapshot.child('buildAndroid').value as int?;
        buildIOS = snapshot.child('buildIOS').value as int?;
        if (useTestLink == false) {
          ApiEndPoints.baseUrl = snapshot.child('base_url').value.toString();
          ApiEndPoints.base = ApiEndPoints.baseUrl.split("api/")[0];
        } else if (useTestLink == true) {
          ApiEndPoints.baseUrl = snapshot.child('test_url').value.toString();
          ApiEndPoints.base = ApiEndPoints.baseUrl.split("api/")[0];
        }
      });
    } on Exception catch (e) {
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
      print(e.toString());
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
              Future.delayed(
                Duration(seconds: 2),
              ).then((value) => updateRequired());
              isForceUpdate = true;
            }
          } else if (Platform.isAndroid) {
            if (versionAndroid != Globals.appVersion ||
                buildAndroid != int.parse(Globals.buildNumber!)) {
              Future.delayed(
                Duration(seconds: 2),
              ).then((value) => updateRequired());
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Utils.getIconPath("logo"),
                scale: 8.0,
              ).paddingOnly(right: 32),
              SizedBox(height: 8),
              Text(
                "New version available",
                style: AppTextStyles.heading.copyWith(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                "${Platform.isIOS ? "${versionIOS} ($buildIOS)" : "${versionAndroid} ($buildAndroid)"}",
                style: AppTextStyles.heading.copyWith(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                "Looks like you have an older version of the app. Please update to get latest features and best experience.",
                maxLines: 4,
                style: AppTextStyles.bodyText.copyWith(
                  fontSize: 14,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  openAppStore();
                },
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: AppColors.secondaryGradient,
                  ),
                  child: Center(
                    child: Text(
                      "Update",
                      style: AppTextStyles.bodyTextBold.copyWith(
                        fontSize: 18,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void openAppStore() async {
    String url = "";
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/details?id=com.diy_max.app';
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/app/6738170498';
    }

    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
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
        // checkForUpdate();
      });
    });
  }
}
