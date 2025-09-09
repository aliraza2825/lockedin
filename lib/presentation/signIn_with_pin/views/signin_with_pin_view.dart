import 'package:medical_courier/app/config/app_colors.dart';
import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/app/config/global_var.dart';
import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/shared_widgets/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../app/routes/app_pages.dart';
import '../../../app/shared_widgets/text_field.dart';
import '../../../app/shared_widgets/custom_button.dart';
import '../controllers/signIn_with_pin_controller.dart';

class SigninWithPinView extends GetView<SignInWithPinController> {
  const SigninWithPinView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInWithPinController>(
        init: SignInWithPinController(),
        builder: (controller) {
          return Obx(() => BackgroundWidget(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    resizeToAvoidBottomInset: false,
                    body: Form(
                      key: controller.signInFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          14.h.height,
                          Text(
                            '${'Welcome'.tr},',
                            style: AppTextStyles.headingExtraLarge,
                          ),
                          Text(
                            'Sign In to start Blood Delivery'.tr,
                            style: AppTextStyles.twentyNormalText,
                            maxLines: 3,
                          ),
                          4.h.height,
                          Text('Email'.tr, style: AppTextStyles.bodyTextBold),
                          1.h.height,
                           InputEmailField(
                            controller: controller.emailController,
                            onChanged: (email) {
                              controller.email = email;
                            },
                          ),
                          1.h.height,
                          Visibility(
                              visible: controller.pinVerified.value,
                              child: Text(
                                'Password'.tr,
                                style: AppTextStyles.bodyTextBold,
                              )),
                          1.h.height,
                          Visibility(
                            visible: controller.pinVerified.value,
                            child: InputPasswordField(
                              focusNode: controller.focusNode,
                              obSecure: controller.secure.value,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100), // Limits input length to 4 characters
                              ],
                              eye: IconButton(
                                  onPressed: () {
                                    controller.secure.value =
                                        !controller.secure.value;
                                    controller.update();
                                  },
                                  icon: Icon(
                                    controller.secure.value
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash,
                                    color: AppColors.hintColor,
                                  )),
                              keyboardType: TextInputType.text,
                              readOnly: false,
                              ctrl: controller.pinCtrl,
                              hint: 'Password'.tr,
                              validator: (value) {
                                if (value!.length<8) {
                                  return 'Password must be at least 8 characters long'.tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          8.0.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    controller.focusNode.unfocus();
                                     controller.signInFormKey.currentState!.reset();
                                     Get.toNamed(Routes.FORGET_PASSWORD)?.then((value) {
                                       controller.reset();
                                   });
                                  },
                                  child: Text('Forgot Password?'.tr,
                                      style: AppTextStyles.bodyTextBold)),
                            ],
                          ),
                          const Spacer(),
                          CustomGradientButton(
                            text: 'Sign In'.tr,
                            onPress: () {
                                if (controller.signInFormKey.currentState!.validate() && controller.emailController.text.isNotEmpty) {
                                  controller.login(controller.emailController.text);
                                } else {
                                  controller.error.value = controller.emailController.text.isEmpty ? true : false;
                                  controller.update();
                                }
                            },
                          ),
                          1.h.height,
                          Visibility(
                            visible: Globals.authToken != "" &&
                                controller.hasBiometric.value,
                            child: CustomButton(
                              text: 'Sign In with Biometric'.tr,
                              onPress: () {
                                controller.handleAuth();
                              },
                            ),
                          ),
                          
                          14.h.height
                        ],
                      ).paddingSymmetric(horizontal: 20),
                    ),
                  ),
                ),
              ));
        });
  }
}
