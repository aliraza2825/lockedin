import 'dart:developer';

import 'package:locked_in/app/routes/app_pages.dart';
import 'package:locked_in/data/repositories/diy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/utils/utils.dart';

class ForgetPasswordController extends GetxController {
  //TODO: Implement ForgetPasswordController
  TextEditingController phoneNumberController = TextEditingController();
  String countryCode = '+1';
  DIYRepository diyRepository=DIYRepository();
  RxBool error = false.obs;
  RxBool isPhoneEmpty=false.obs;
  bool? isPhoneValid;
  RxBool checkValidate=false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> forgotPin(String num) async {
    try {
      final response = await diyRepository.forgotPin(num);
      if (response!=null && response['status'] == true) {
        Get.toNamed(Routes.OTP,arguments: false,parameters: {
          "email":num,
          "otp":response['data']['otp'],
          "isforgot":"yes"
        });
      } else {
        Utils.showToast(message: response['message']);
      }
    }  catch (e) {
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
      log('Register Phone Error: $e');
    }
  }
}
