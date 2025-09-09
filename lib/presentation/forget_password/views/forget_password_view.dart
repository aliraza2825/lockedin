import 'dart:developer';

import 'package:medical_courier/app/config/app_colors.dart';
import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/shared_widgets/background.dart';
import 'package:medical_courier/app/shared_widgets/custom_button.dart';
import 'package:medical_courier/app/shared_widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: GetBuilder<ForgetPasswordController>(
        builder: (_) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.trans,
              appBar: AppBar(
                backgroundColor: AppColors.trans,
                systemOverlayStyle:const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                ),
                title: Text('Forgot Password'.tr,style: AppTextStyles.heading.copyWith(color: AppColors.primary),),
                // centerTitle: true,
                leading: IconButton(
                  color: AppColors.white,
                    onPressed: () {
                    Get.back();
                }, icon: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.white.withOpacity(0.15),
                        blurRadius: 32,
                        spreadRadius: 0,
                        offset:const Offset(6, 5)
                      )
                    ]
                  ),
                    child:const Icon(CupertinoIcons.back,color: AppColors.black,))),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  6.h.height,
                  InputEmailField(
                            controller: controller.phoneNumberController,
                            onChanged: (email) {
                              controller.phoneNumberController.text = email;
                            },
                          ),
                  const Spacer(),
                  SafeArea(
                    top: false,
                    child: CustomGradientButton(text: 'Send OTP'.tr, onPress: () {
                      if(controller.phoneNumberController.text.isNotEmpty){
                        controller.forgotPin(controller.phoneNumberController.text);
                      }else{
                        controller.error.value=controller.phoneNumberController.text.isEmpty ?  true : false;
                        controller.isPhoneEmpty.value=controller.phoneNumberController.text.isEmpty ? true : false;
                        controller.update();

                      }
                    },).paddingOnly(bottom: 6.h),
                  ),
                  // 14.h.height
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
          );
        }
      ),
    );
  }
}
