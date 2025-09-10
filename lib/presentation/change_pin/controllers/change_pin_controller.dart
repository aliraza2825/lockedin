import 'dart:developer';

import 'package:locked_in/app/config/global_var.dart';
import 'package:locked_in/app/routes/app_pages.dart';
import 'package:locked_in/app/utils/utils.dart';
import 'package:locked_in/data/repositories/diy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePinController extends GetxController {
  final formKey = GlobalKey<FormState>();
  DIYRepository diyRepository=DIYRepository();
  TextEditingController pinCodeCtrl=TextEditingController();
  TextEditingController confirmPinCodeCtrl=TextEditingController();
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setPin(String num) async {
    try {
      isLoading = true;
      update();
      final response = await diyRepository.setPin(num,email: Globals.email);
      if (response!=null && response['status']==true) {
        isLoading = false;
        Get.offAllNamed(Routes.SIGNIN_WITH_PIN);
        Utils.showToast(message:"Password updated successfully.".tr);
      } else {
        isLoading = false;
        throw Exception('Failed to Update Password');
      }
    } catch (e) {
      isLoading = false;
      Utils.showToast(message:"Please try again.".tr);
      log('Register Phone Error: $e');
      throw Exception('An unexpected error occurred.');
    }
  }
}