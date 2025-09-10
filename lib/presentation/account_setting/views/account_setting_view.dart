import 'package:locked_in/app/extensions/extensions.dart';
import 'package:locked_in/app/shared_widgets/app_bar.dart';
import 'package:locked_in/app/shared_widgets/background_simple.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:locked_in/presentation/LogoLoadingScreen.dart';
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

                      Text('Address'.tr, style: AppTextStyles.bodyTextBold),
                      InputTextField(
                        clr: AppColors.white,
                        hint: 'Enter Current Address'.tr,
                        ctrl: controller.currentAddressCtrl,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) => value!.isEmpty ? 'Current address is required'.tr : null,
                        readOnly: false,
                      ),
                      6.h.height,

                      /// Update Button
                      CustomGradientButton(
                        text: 'Update'.tr,
                        onPress: () {
                          if (controller.formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus!.unfocus();
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