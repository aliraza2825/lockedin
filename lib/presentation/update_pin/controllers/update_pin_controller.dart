import 'dart:async';
import 'dart:developer';

import 'package:medical_courier/data/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../../app/utils/utils.dart';
import '../../../data/repositories/diy_repository.dart';

class UpdatePinController extends GetxController {
  //TODO: Implement UpdatePinController
  final formKey = GlobalKey<FormState>();
  final ProfileRepository _repository= ProfileRepository();
  TextEditingController currentPinCodeCtrl=TextEditingController();
  TextEditingController newPinCodeCtrl=TextEditingController();
  TextEditingController confirmPinCodeCtrl=TextEditingController();

  bool loading = false;
  late StreamSubscription<bool> keyboardSubscription;
  var keyboardVisibilityController = KeyboardVisibilityController();


  @override
  void onInit() {
    super.onInit();

    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
    });
  }
  Future<void> changePin() async {
    try {
      loading =true;
      update();
      final response = await _repository.changePin(currentPinCodeCtrl.text,confirmPinCodeCtrl.text);
      loading =false;
      update();
      if (response!=null && response['status']==true) {
        Get.back();
        Utils.showToast(message: response['message'].toString().capitalizeFirst!);
      }else{
        Utils.showToast(message: response['message'].toString().capitalizeFirst!);

      }
    }  catch (e) {

      Utils.showToast(message:"Current PIN code is incorrect");
      log('Register Phone Error: $e');
      throw Exception('An unexpected error occurred.');
    }
  }


}
