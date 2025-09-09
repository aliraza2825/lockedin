import 'dart:developer';

import 'package:medical_courier/app/config/app_colors.dart';
import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/routes/app_pages.dart';
import 'package:medical_courier/app/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:medical_courier/presentation/select_language/controllers/select_language_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../app/shared_widgets/background.dart';
import '../../../app/shared_widgets/custom_button.dart';
import '../../../app/shared_widgets/text_field.dart';

class SelectLanguageView extends GetView<SelectLanguageController> {
  const SelectLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SelectLanguageController(),
        builder: (c) {
          return Scaffold(
            body: BackgroundWidget(
              child: SafeArea(
                child: Column(
                  children: [
                    6.6.h.height,
                    Image.asset(
                      Utils.getIconPath("logo"),
                      scale: 4.0,
                    ),
                    5.2.h.height,
                    Text(
                      "Please select your language".tr,
                      style: AppTextStyles.regular.copyWith(fontSize: 24),
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 56),
                    5.h.height,
                    DropdownInput(
                      hint: 'Select Language'.tr,
                      list: const ["English", "French", "German","Spanish"],
                      value: controller.locale,
                      onChanged: (v) {
                        controller.locale = v!;

                        log('SelectLanguageView.build $v');
                      },
                    ).paddingSymmetric(horizontal: 5.1.w),
                    const Spacer(),
                    CustomGradientButton(
                      text: '',
                      onPress: () async {
                        await controller.saveLanguage();
                        Get.offAndToNamed(
                          Routes.SIGNIN_WITH_PIN,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Continue".tr,
                            style: AppTextStyles.semiBold.copyWith(
                                color: AppColors.white,
                                fontSize: 12.sp,
                                height: 1.9),
                          ),
                          10.width,
                          Image.asset(
                            Utils.getIconPath("arrow_forward"),
                            scale: 4.0,
                          )
                        ],
                      ),
                    ).paddingSymmetric(horizontal: 5.1.w),
                    5.h.height
                  ],
                ),
              ),
            ),
          );
        });
  }
}
