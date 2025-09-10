import 'dart:developer';
import 'dart:io';

import 'package:locked_in/app/routes/app_pages.dart';
import 'package:locked_in/app/utils/image_utility.dart';
import 'package:locked_in/app/utils/utils.dart';
import 'package:locked_in/data/repositories/diy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoController extends GetxController {

  final formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController zipCodeCtrl = TextEditingController();
  DIYRepository diyRepository = DIYRepository();
  File? avatarImage;
  bool? back;
  String? selectedGender;
  @override
  void onInit() {
    back=Get.arguments;
    super.onInit();
  }

  void setGender(String gender) {
    selectedGender = gender;
    update();
  }

  Future<void> personalInfo() async {
    try {
      Get.offAllNamed(Routes.NAVBAR);
      // final response = await diyRepository.personalInfo(
      //     fullName: nameCtrl.text,
      //     email: emailCtrl.text,
      //     age: int.parse(ageCtrl.text),
      //     state: stateCtrl.text,
      //     zip: zipCodeCtrl.text,
      //     avatar: avatarImage!);
      // if (response != null && response['message'] == 'success') {
      //   Globals.fullName = nameCtrl.text;
      //   LocalDB.setData(LocalDataKey.firstName.name, nameCtrl.text);

      //   Get.offAllNamed(Routes.SIGNUP_SUCCESS);

      // } else {
      //   Utils.showToast(message: response['message']);
      //   throw Exception('Failed to register: ${response.statusMessage}');
      // }
    } catch (e) {
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
      log('Register Phone Error: $e');
      throw Exception('An unexpected error occurred.');
    }
  }

  Future getCameraImage() async {
    avatarImage = await RefineImage.getImageFromCamera();
    update();
  }

  Future getGalleryImage() async {
    avatarImage = await RefineImage.getImageFromGallery();
    update();
    Get.back();
  }

  Future<void> getStateFromZip()async{
    try {
      final response = await diyRepository.getStateFromZip(zipCodeCtrl.text);
      if (response != null && response['status'] != "ZERO_RESULTS") {
        stateCtrl.text=  response["results"][0]['address_components'].firstWhere((
            e) => e['types'][0] == 'administrative_area_level_1')['long_name']??"";
    update();
    formKey.currentState!.validate();

      } else {
        stateCtrl.clear();
        update();
        Utils.showToast(message: "Enter a valid zipcode");
        throw Exception('Failed to register: ${response['status']}');
      }
    } catch (e) {
      stateCtrl.clear();
      update();
      Utils.showToast(message: "Enter a valid zipcode");
      // Utils.showToast(message: e.toString());
      log('Register Phone Error: $e');
      throw Exception('An unexpected error occurred.');
    }
  }

}
