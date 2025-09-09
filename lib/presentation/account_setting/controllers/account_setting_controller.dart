import 'dart:developer';
import 'dart:io';

import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/data/models/user_profile.dart';
import 'package:medical_courier/presentation/profile/controllers/profile_controller.dart';
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

  // 🆕 License Images
  File? licenseFrontImage = null;
  File? licenseBackImage = null;

  late UserProfile userProfile;

  // 🆕 Update Profile
  void updateProfile() async {
    try {
      final response = await diyRepository.updatePersonalInfo(
        firstName: firstNameCtrl.text,
        lastName: lastNameCtrl.text,
        email: emailCtrl.text,
        phoneNumber: phoneCtrl.text,
        currentAddress: currentAddressCtrl.text,
        permanentAddress: permanentAddressCtrl.text,
        licenseNumber: licenseCtrl.text,
        licenseFrontPhotoPath: userProfile.licenseFrontPhoto,
        licenseBackPhotoPath: userProfile.licenseBackPhoto,
        irsTaxForm: userProfile.irsTaxForm.toString(),
        emergencyContact: emergencyContactCtrl.text,
        ssn: cnicCtrl.text,
        isActive: isActive.value == 'true',
        licenseFrontPhoto: licenseFrontImage,
        licenseBackPhoto: licenseBackImage,
      );

      if (response != null && response['status'] == true) {
        Utils.showToast(message: "Profile updated successfully".tr);
        userProfile = Get.find<ProfileController>().userProfile!;
        await Get.find<ProfileController>().getUserProfile();
        Get.back();
      } else {
        Utils.showToast(message: response['message']);
      }
    } catch (e) {
      Utils.showToast(message: "Failed to update profile");
    } finally {
      update();
    }
  }

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
    userProfile = Get.find<ProfileController>().userProfile!;
    firstNameCtrl.text = userProfile.firstName ?? "";
    lastNameCtrl.text = userProfile.lastName ?? "";
    emailCtrl.text = userProfile.email ?? "";
    phoneCtrl.text = userProfile.phoneNumber ?? "";
    statusCtrl.text = userProfile.isActive.toString();
    cnicCtrl.text = userProfile.ssn ?? "";
    licenseCtrl.text = userProfile.licenseNumber ?? "";
    currentAddressCtrl.text = userProfile.currentAddress ?? "";
    permanentAddressCtrl.text = userProfile.permanentAddress ?? "";
    isActive.value = userProfile.isActive.toString();
    emergencyContactCtrl.text = userProfile.emergencyContact ?? "";
    update();
    super.onInit();
  }

  void setLicenseFrontImage(File image) {
    licenseFrontImage = image;
    update();
  }

  void setLicenseBackImage(File image) {
    licenseBackImage = image;
    update();
  }

  void showImageSourceActionSheet({required bool isFrontImage}) async {
    return showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              1.h.height,
              ListTile(
                leading: Image.asset(
                  Utils.getIconPath('camera'),
                  width: 20,
                  height: 20,
                ),
                title: Text('Camera'.tr, style: AppTextStyles.normalText),
                onTap: () async {
                  Get.back();
                  final image = await RefineImage.getImageFromCamera();
                  if (image != null) {
                    if (isFrontImage) {
                      setLicenseFrontImage(image);
                    } else {
                      setLicenseBackImage(image);
                    }
                  }
                },
              ),
              ListTile(
                leading: Image.asset(
                  Utils.getIconPath('gallery'),
                  width: 20,
                  height: 20,
                ),
                title: Text('Gallery'.tr, style: AppTextStyles.normalText),
                onTap: () async {
                  Get.back();
                  final image = await RefineImage.getImageFromGallery();
                  if (image != null) {
                    if (isFrontImage) {
                      setLicenseFrontImage(image);
                    } else {
                      setLicenseBackImage(image);
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
