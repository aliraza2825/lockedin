import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/shared_widgets/app_bar.dart';
import 'package:sizer/sizer.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/shared_widgets/text_field.dart';
import '../../../app/shared_widgets/background.dart';
import '../../../app/shared_widgets/custom_button.dart';
import '../../LogoLoadingScreen.dart';
import '../controllers/change_pin_controller.dart';

class ChangePinView extends GetView<ChangePinController> {
  const ChangePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: GetBuilder<ChangePinController>(builder: (c) {
        return Scaffold(
              backgroundColor: AppColors.trans,
              appBar: AppBarCustom(title: 'Change Password'.tr),
              body: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    4.h.height,
                    Text(
                      'Password'.tr,
                      style: AppTextStyles.bodyTextBold,
                    ),
                    InputTextField(
                      hint: 'Enter Your Password'.tr,
                      ctrl: controller.pinCodeCtrl,
                      keyboardType: TextInputType.text,
                      icon: const Icon(Icons.lock, color: Colors.grey),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100), // Limit to 4 characters
                      ],
                      readOnly: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password'.tr;
                        }
                        return null;
                      },
                    ),
                    2.h.height,
                    Text(
                      'Confirm Password'.tr,
                      style: AppTextStyles.bodyTextBold,
                    ),
                    InputTextField(
                      hint: 'Confirm Your Password'.tr,
                      ctrl: controller.confirmPinCodeCtrl,
                      keyboardType: TextInputType.text,
                      icon: const Icon(Icons.lock, color: Colors.grey),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100), // Limit to 4 characters
                      ],
                      readOnly: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password is required'.tr;
                        }
                        if (value != controller.pinCodeCtrl.text) {
                          return 'Both Passwords must be the same'.tr;
                        }
                        return null;
                      },
                    ),
                    Expanded(child: SizedBox()), // Replaces `Spacer()`
                    CustomGradientButton(
                      text: 'Confirm'.tr,
                      onPress: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.setPin(controller.pinCodeCtrl.text);
                        }
                      },
                    ),
                    10.h.height,
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
            );
      }
    )
    );
  }
}
