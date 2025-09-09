import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/shared_widgets/app_bar.dart';
import 'package:medical_courier/app/shared_widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/shared_widgets/custom_button.dart';
import '../../../app/shared_widgets/text_field.dart';
import '../controllers/update_pin_controller.dart';

class UpdatePinView extends GetView<UpdatePinController> {
  const UpdatePinView({super.key});
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: GetBuilder<UpdatePinController>(
        builder: (controller) {
          return KeyboardVisibilityBuilder(
            controller: controller.keyboardVisibilityController,
            builder: (p0, isKeyboardVisible) => Scaffold(
              backgroundColor: AppColors.trans,
              appBar: AppBarCustom(title: 'Change Password'.tr),
              body: ModalProgressHUD(
                inAsyncCall: controller.loading,
                progressIndicator: CircularProgressIndicator(color: AppColors.darkPrimary,),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      4.h.height,
                      Text(
                        'Current Pin Code'.tr,
                        style: AppTextStyles.bodyTextBold,
                      ),
                      InputTextField(
                        hint: 'Current Pin Code'.tr,obscureText: true,lines: 1,
                        ctrl: controller.currentPinCodeCtrl,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100), // Limits input length to 4 characters
                        ],
                        readOnly: false,
                        validator:(value) {
                          if(value!.isEmpty){
                            return 'Enter current pin code'.tr;
                          }else {
                            return null;
                          }
                        },
                      ),
                      2.h.height, Text(
                        'New Pin Code'.tr,
                        style: AppTextStyles.bodyTextBold,
                      ),
                      InputTextField(
                        hint: 'New Pin Code'.tr,
                        ctrl: controller.newPinCodeCtrl,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100), // Limits input length to 4 characters
                        ],
                        readOnly: false,obscureText: true,lines: 1,
                        validator:(value) {
                          if(value!.isEmpty){
                            return 'Enter pin code'.tr;
                          }else {
                            return null;
                          }
                        },
                      ),
                      2.h.height,
                      Text(
                        'Confirm Pin Code'.tr,
                        style: AppTextStyles.bodyTextBold,
                      ),
                      InputTextField(
                        hint: 'Confirm Your Pin Code'.tr,obscureText: true,lines: 1,
                        ctrl: controller.confirmPinCodeCtrl,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100), // Limits input length to 4 characters
                        ],
                        readOnly: false,
                        validator:(value) {
                          if(controller.confirmPinCodeCtrl.text.isEmpty){
                            return 'Pin code cannot empty!'.tr;
                          }else if(value!.isEmpty||value!=controller.newPinCodeCtrl.text){
                            return 'Both pin code should be same'.tr;
                          }else {
                            return null;
                          }
                        },
                      ),
                      const Spacer(),
                      CustomGradientButton(text: 'Update'.tr, onPress: () {
                        if(controller.formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus!.unfocus();
                          controller.changePin();
                          // controller.setPin(controller.pinCodeCtrl.text);
                        }
                      },),
                      5.h.height
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
