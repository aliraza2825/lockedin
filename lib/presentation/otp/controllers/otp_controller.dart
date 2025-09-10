import 'dart:async';

import 'package:locked_in/app/config/global_var.dart';
import 'package:locked_in/app/config/local_keys.dart';
import 'package:locked_in/app/routes/app_pages.dart';
import 'package:locked_in/app/utils/utils.dart';
import 'package:locked_in/data/provider/local_storage/local_db.dart';
import 'package:locked_in/data/repositories/diy_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpController extends GetxController {

  DIYRepository diyRepository=DIYRepository();
  final otpPinFieldController = GlobalKey<OtpPinFieldState>();
  RxBool isNew=false.obs;
  RxString otpText="".obs;
  RxString otpNumber="".obs;
  RxString phoneNumber=''.obs;
  late StreamSubscription<bool> keyboardSubscription;
  var keyboardVisibilityController = KeyboardVisibilityController();
  bool is_forgot = false;
  @override
  void onInit() {
    isNew.value=Get.arguments;
    if(Get.parameters["email"]!=null){
        phoneNumber.value=Get.parameters["email"] ?? "";
        otpNumber.value=Get.parameters["otp"] ?? "";
    }
    if(Get.parameters["isforgot"]!=null){
      is_forgot=true;
    }
    super.onInit();
    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
    });
    update();
  }

  Future<void> verifyOtp(String num) async {
    try {
      if (num==otpNumber.value) {
        Globals.email = phoneNumber.value;
        await LocalDB.setData(LocalDataKey.email.name, Globals.email);
        Get.toNamed(Routes.CHANGE_PIN);
      } else {
        Utils.showToast(message:"Please enter valid otp.".tr, gravity:ToastGravity.CENTER);
      }
    }  catch (e) {
      Utils.showToast(message:"Please enter valid otp.".tr,gravity: ToastGravity.CENTER);
    }
  }
}
