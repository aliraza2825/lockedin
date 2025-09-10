import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:locked_in/app/config/global_var.dart';
import 'package:locked_in/app/config/local_keys.dart';
import 'package:locked_in/app/routes/app_pages.dart';
import 'package:locked_in/app/utils/utils.dart';
import 'package:locked_in/data/provider/local_storage/local_db.dart';
import 'package:locked_in/data/repositories/dashboard_repository.dart';
import 'package:locked_in/data/repositories/diy_repository.dart';
import 'package:locked_in/presentation/signIn_with_pin/views/local_auth/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  AuthService authService = AuthService();
  DIYRepository diyRepository = DIYRepository();
  DashboardRepository diyDashboardRepository = DashboardRepository();
  final signInFormKey = GlobalKey<FormState>();
  final contForm = GlobalKey<FormState>();
  TextEditingController pinCtrl = TextEditingController();
  TextEditingController confirmPinCtrl = TextEditingController();
  RxBool secure = true.obs, error = false.obs, pinVerified = true.obs;
  RxBool secure2 = true.obs, error2 = false.obs, pinVerified2 = true.obs;
  RxBool hasBiometric = true.obs;
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  TextEditingController emailController = TextEditingController();
  String email = '';

  @override
  void onInit() async {
    if (Get.arguments != null) {
      pinVerified.value = Get.arguments;
    }

    if (emailController.text == '') {
      emailController.text =
          await LocalDB.getData(LocalDataKey.email.name) ?? '';
    }

    var a = await authService.auth.getAvailableBiometrics();
    if (a.isEmpty) {
      hasBiometric.value = false;
      update();
    }
    super.onInit();
  }

  void reset() {
    emailController.clear();
    pinCtrl.clear();
    update();
  }

  Future<void> signup(String email) async {
    RxBool showCatchToast = true.obs;
    // try {
    //   final resp = await diyRepository.login(email, pinCtrl.text);
    //   log('-----------------${resp.toString()}');

    //   if (resp != null && resp['status'] == true) {
    //     Utils.showToast(message: resp['message'], gravity: ToastGravity.CENTER);

    //     Globals.email = emailController.text;
    //     Globals.authToken = resp['data']['token'];
    //     Globals.userId = resp['data']['userId'];
    //     await LocalDB.setData(LocalDataKey.authToken.name, Globals.authToken);
    //     await LocalDB.setData(LocalDataKey.email.name, Globals.email);
    //     await LocalDB.setData(LocalDataKey.userId.name, resp['data']['userId']);
        Get.offAllNamed(Routes.WELCOME);
    //   } else {
    //     showCatchToast.value = false;
    //     Utils.showToast(
    //       message: 'Incorrect email or password'.tr,
    //       gravity: ToastGravity.BOTTOM,
    //     );
    //     throw Exception('Failed to login: ${resp['message']}');
    //   }
    // } on Exception catch (_, e) {
    //   showCatchToast.value = false;
    //   if (showCatchToast.isTrue) {
    //     Utils.showToast(message: "Something went wrong. Please try again.".tr);
    //     return;
    //   }
    // }
  }

  void handleAuth() async {
    bool authenticated = await authService.authenticateWithBiometrics();
    if (authenticated) {
      getUser();
    } else {
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
    }
  }

  Future<void> getUser() async {
    Map<String, dynamic>? resp;
    try {
      resp = await diyRepository.verifyToken();

      if (resp != null && resp["message"] == "success") {
        if (resp["data"]["is_verified"] == false) {
          Get.offAndToNamed(Routes.OTP, arguments: true);
        } else if (resp["data"]["has_pin_code"] == false) {
          Get.offAndToNamed(Routes.CREATE_PIN);
        } else if (resp["data"]["has_profile"] == false) {
          Get.offAndToNamed(Routes.PERSONAL_INFO);
        } else if (resp["data"]["has_preferences"] == false) {
          Get.offAndToNamed(Routes.PREFERENCES);
        } else {
          Get.offAllNamed(Routes.NAVBAR);
        }
      } else {
        LocalDB.clear();
        Globals.authToken = '';
        await LocalDB.setData(LocalDataKey.firstTime.name, false);
        Future.delayed(const Duration(seconds: 8)).then((value) {
          Get.offAndToNamed(Routes.WELCOME);
        });
      }
    } on Exception catch (e) {
      Get.log('AuthenticationController.signUp ${e.toString()}');
    }
  }
}
