import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/shared_widgets/app_bar.dart';
import 'package:medical_courier/app/shared_widgets/background_simple.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:medical_courier/presentation/LogoLoadingScreen.dart';
import 'package:sizer/sizer.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/shared_widgets/text_field.dart';
import '../../../app/shared_widgets/custom_button.dart';
import '../controllers/account_setting_controller.dart';

class AccountSettingView extends GetView<AccountSettingController> {
  const AccountSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundSimpleWidget(
      child: GetBuilder<AccountSettingController>(builder: (c) {
        return LoadingOverlay(
          isLoading: false,
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              backgroundColor: AppColors.trans,
              appBar: AppBarCustom(
                title: 'Account Settings'.tr,
                trailing: null,
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      3.5.h.height,
                      // Status Dropdown
                      Text('Status', style: AppTextStyles.bodyTextBold),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: controller.isActive.value, // Default value
                          decoration: const InputDecoration.collapsed(hintText: ''),
                          items: [
                            DropdownMenuItem(
                              value: 'true',
                              child: Text('Active'),
                            ),
                            DropdownMenuItem(
                              value: 'false',
                              child: Text('Not Active'),
                            ),
                          ],
                          onChanged: (value) {
                            controller.isActive.value = value!;
                          },
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Status is required' : null,
                        ),
                      ),
                      3.5.h.height,

                      /// First Name
                      Text('First Name'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.white,
                        hint: 'Enter First Name'.tr,
                        ctrl: controller.firstNameCtrl,
                        keyboardType: TextInputType.name,
                        validator: (value) => value!.isEmpty ? 'First name is required'.tr : null,
                        readOnly: false,
                      ),
                      2.h.height,

                      /// Last Name
                      Text('Last Name'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.white,
                        hint: 'Enter Last Name'.tr,
                        ctrl: controller.lastNameCtrl,
                        keyboardType: TextInputType.name,
                        validator: (value) => value!.isEmpty ? 'Last name is required'.tr : null,
                        readOnly: false,
                      ),
                      2.h.height,

                      /// Email
                      Text('Email'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.lightPink,
                        hint: 'Enter Email'.tr,
                        ctrl: controller.emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) return 'Email is required'.tr;
                          if (!GetUtils.isEmail(value)) return 'Enter a valid email'.tr;
                          return null;
                        },
                        readOnly: true,
                      ),
                      2.h.height,

                      /// Phone
                      Text('Phone'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.lightPink,
                        hint: 'Enter Phone Number'.tr,
                        ctrl: controller.phoneCtrl,
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.isEmpty ? 'Phone number is required'.tr : null,
                        readOnly: true,
                      ),
                      2.h.height,


                      /// Phone
                      Text('Emergency Contact'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.white,
                        hint: 'Enter Emergency Contact'.tr,
                        ctrl: controller.emergencyContactCtrl,
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.isEmpty ? 'Emergency Contact is required'.tr : null,
                        readOnly: false,
                      ),
                      2.h.height,

                      /// CNIC
                      Text('SSN'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.white,
                        hint: 'Enter SSN'.tr,
                        ctrl: controller.cnicCtrl,
                        keyboardType: TextInputType.number,
                        validator: (value) => value!.isEmpty ? 'SSN is required'.tr : null,
                        readOnly: false,
                      ),
                      2.h.height,

                      Text('Current Address'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.white,
                        hint: 'Enter Current Address'.tr,
                        ctrl: controller.currentAddressCtrl,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) => value!.isEmpty ? 'Current address is required'.tr : null,
                        readOnly: false,
                      ),
                      2.h.height,

                      /// Permanent Address
                      Text('Permanent Address'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.white,
                        hint: 'Enter Permanent Address'.tr,
                        ctrl: controller.permanentAddressCtrl,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) => value!.isEmpty ? 'Permanent address is required'.tr : null,
                        readOnly: false,
                      ),
                      2.h.height,

                      /// License
                      Text('License'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.white,
                        hint: 'Enter License Number'.tr,
                        ctrl: controller.licenseCtrl,
                        keyboardType: TextInputType.text,
                        validator: (value) => value!.isEmpty ? 'License is required'.tr : null,
                        readOnly: false,
                      ),
                      2.h.height,

                      /// License Front Image
                      Text('License Front Image'.tr, style: AppTextStyles.bodyTextBold),
                      GestureDetector(
                        onTap: () => controller.showImageSourceActionSheet(isFrontImage: true),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: controller.licenseFrontImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    controller.licenseFrontImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : controller.userProfile.licenseFrontPhoto != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://blood-tracker-apis.rootpointers.net/${controller.userProfile.licenseFrontPhoto}",
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Tap to upload front image'.tr,
                                        style: AppTextStyles.bodyText,
                                      ),
                                    ),
                        ),
                      ),
                      2.h.height,

                      /// License Back Image
                      Text('License Back Image'.tr, style: AppTextStyles.bodyTextBold),
                      GestureDetector(
                        onTap: () => controller.showImageSourceActionSheet(isFrontImage: false),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: controller.licenseBackImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    controller.licenseBackImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : controller.userProfile.licenseBackPhoto != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://blood-tracker-apis.rootpointers.net/${controller.userProfile.licenseBackPhoto}",
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Tap to upload back image'.tr,
                                        style: AppTextStyles.bodyText,
                                      ),
                                    ),
                        ),
                      ),
                      6.h.height,

                      /// Update Button
                      CustomGradientButton(
                        text: 'Update'.tr,
                        onPress: () {
                          if (controller.formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus!.unfocus();
                            controller.updateProfile();
                          }
                        },
                      ),
                      4.h.height,
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}