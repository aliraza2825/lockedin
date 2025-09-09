import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/shared_widgets/app_bar.dart';
import 'package:medical_courier/app/shared_widgets/background_simple.dart';
import 'package:medical_courier/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/shared_widgets/custom_button.dart';
import '../controllers/change_language_controller.dart';

class ChangeLanguageView extends GetView<ChangeLanguageController> {
  const ChangeLanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundSimpleWidget(
        child: GetBuilder<ChangeLanguageController>(
            init: ChangeLanguageController(),
            builder: (c) {
              return Scaffold(
                backgroundColor: AppColors.trans,
                appBar:  AppBarCustom(title: "Change Language".tr),
                body: SafeArea(
                  child: Column(
                    children: [
                      6.h.height,
                      ...List.generate(
                          controller.languages.length,
                              (index) => GestureDetector(
                            onTap: () {
                              controller.lang = controller.languages[index];
                              controller.update();
                            },
                            child: languageTile(
                                controller.languages[index],
                                controller.languages[index] ==
                                    controller.lang)
                                .paddingOnly(bottom: 10),
                          )),
                      Spacer(),
                      CustomGradientButton(
                        text: 'Update'.tr,
                        onPress: () async {
                          await controller.saveLanguage();
                          Get.back();
                        },
                      ),
                      4.h.height,
                    ],
                  ).paddingSymmetric(horizontal: 20),
                ),
              );
            })
    );
  }

  Container languageTile(String language, bool isSelected) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grey200),
        color: AppColors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                Utils.getIconPath(language),
                scale: 4.0,
              ),
              8.width,
              Text(
                controller.getLanguageName(language).tr,
                style: AppTextStyles.bodyTextBold,
              )
            ],
          ).paddingOnly(left: 20),
          Icon(
            isSelected
                ? CupertinoIcons.check_mark_circled_solid
                : Icons.circle_outlined,
            size: 24,
            color: isSelected ? AppColors.primary : AppColors.grey300,
          ).paddingOnly(right: 20)
        ],
      ),
    );
  }
}
