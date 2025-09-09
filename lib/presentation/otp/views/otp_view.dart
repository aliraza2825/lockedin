import 'dart:developer';

import 'package:medical_courier/app/config/app_colors.dart';
import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/shared_widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:medical_courier/app/shared_widgets/background.dart';
import 'package:medical_courier/app/shared_widgets/custom_button.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:sizer/sizer.dart';

import '../../../app/utils/utils.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: GetBuilder<OtpController>(
        builder: (_) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: KeyboardVisibilityBuilder(
              controller: controller.keyboardVisibilityController,
              builder: (p0, isKeyboardVisible) => Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: AppColors.trans,
                appBar: AppBarCustom(title: 'Verify OTP'),
                // resizeToAvoidBottomInset: false,
                body:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    4.h.height,
                    !controller.is_forgot ? LinearProgressIndicator(
                        value: 0.5, // 60% progress
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary)
                    ) : SizedBox(),
                    4.h.height,
                    Text('Enter the OTP you received on your email'.tr,style: AppTextStyles.heading.copyWith(overflow: TextOverflow.visible,color: AppColors.primary),softWrap: true),
                    6.h.height,
                    Text('Enter OTP'.tr,style: AppTextStyles.bodyTextBold,),
                    0.5.h.height,
                    Stack(
                      children: [
                        OtpPinField(
                          key:controller.otpPinFieldController,
                          fieldHeight:Get.height/16 ,
                          fieldWidth: Get.width/5.2,
                          autoFillEnable: false,
                          textInputAction: TextInputAction.done,
                          autoFocus: false,
                          onSubmit: (text) {
                            controller.otpText.value=text;
                            FocusManager.instance.primaryFocus!.unfocus();
                            log('Entered pin is.... $text');
                          },
                          onChange: (text) {
                            controller.otpText.value=text;
                            log('Enter on change pin is $text');
                          },
                          onCodeChanged: (code) {
                            controller.otpText.value=code;
                            log('onCodeChanged  is $code');
                          },
                          otpPinFieldStyle:const OtpPinFieldStyle(
                            defaultFieldBorderColor: AppColors.trans,
                            defaultFieldBackgroundColor: AppColors.white,
                            activeFieldBorderGradient:AppColors.primaryGradient,
                            fieldBorderWidth: 1,
                          ),
                          maxLength: 4,
                          showCursor: true,
                          cursorColor: AppColors.primary,
                          cursorWidth: 3,
                          mainAxisAlignment: MainAxisAlignment.center,
                          otpPinFieldDecoration:
                          OtpPinFieldDecoration.defaultPinBoxDecoration,

                        ),
                        Positioned.fill(
                          child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(4, (index) {
                              return Container(
                                alignment: Alignment.center, // Center the text within the field
                                width: Get.width / 5.1, // Match the width of the OTP field
                                height: Get.height / 16, // Match the height of the OTP field
                                child: Text(
                                  controller.otpText.value.length > index
                                      ? '' // Display entered number
                                      : '-', // Display dash if not filled
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: controller.otpText.value.length > index
                                        ? AppColors.black // Entered number color
                                        : AppColors.grey, // Dash color
                                  ),
                                ),
                              );
                            }),
                          ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SafeArea(
                      top: false,
                      child: CustomGradientButton(text: 'Verify'.tr, onPress: () {
                        if(controller.otpText.value.length==4) {
                          controller.verifyOtp(controller.otpText.value);
                        }else{
                          Utils.showToast(message: "Please enter otp.".tr,gravity:ToastGravity.CENTER );
                        }
                      },).paddingOnly(bottom: 6.h),
                    ),
                    4.h.height
                  ],
                ).paddingSymmetric(horizontal: 20),
              ),
            ),
          );
        }
      ),
    );
  }
}
