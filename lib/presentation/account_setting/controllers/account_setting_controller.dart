import 'dart:io';

import 'package:locked_in/data/models/user_profile.dart';
import 'package:locked_in/presentation/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../app/config/app_text_styles.dart';
import '../../../app/utils/image_utility.dart';
import '../../../app/utils/utils.dart';
import '../../../data/repositories/diy_repository.dart';

class AccountSettingController extends GetxController {
  final formKey = GlobalKey<FormState>();
  DIYRepository diyRepository = DIYRepository();

  // 🆕 New TextEditingControllers
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final statusCtrl = TextEditingController();
  final cnicCtrl = TextEditingController();
  final licenseCtrl = TextEditingController();
  final totalVehiclesCtrl = TextEditingController();
  final emergencyContactCtrl = TextEditingController();
  final currentAddressCtrl = TextEditingController();
  final permanentAddressCtrl = TextEditingController();
  final availabilityCtrl = TextEditingController();
  RxString isActive = 'true'.obs;

  late UserProfile userProfile;

  
  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    statusCtrl.dispose();
    cnicCtrl.dispose();
    licenseCtrl.dispose();
    totalVehiclesCtrl.dispose();
    emergencyContactCtrl.dispose();
    currentAddressCtrl.dispose();
    permanentAddressCtrl.dispose();
    availabilityCtrl.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    userProfile = UserProfile(userId: 1, firstName: "Ali", lastName: "Raza", email: "ali@lockedin.com", phoneNumber: "1234567890", currentAddress: "123 Main St");
    firstNameCtrl.text = userProfile.firstName ?? "";
    lastNameCtrl.text = userProfile.lastName ?? "";
    emailCtrl.text = userProfile.email ?? "";
    phoneCtrl.text = userProfile.phoneNumber ?? "";
    currentAddressCtrl.text = userProfile.currentAddress ?? "";
    update();
    super.onInit();
  }
  }
