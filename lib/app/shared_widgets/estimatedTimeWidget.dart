import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

class EstimatedTimeWidget extends StatelessWidget {
  final int weeks;
  const EstimatedTimeWidget({super.key, required this.weeks});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 15,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey200),
          borderRadius: BorderRadius.circular(100),
          gradient: AppColors.secondaryGradient
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Estimated Time?'.tr,
            style: AppTextStyles.semiBold.copyWith(color: AppColors.primary),
          ),
          Container(
            height: Get.height / 42.2,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.white,
            ),
            child: Center(
                child: Text(
                  '$weeks ${'Weeks'.tr}',
                  style: AppTextStyles.small
                      .copyWith(color: AppColors.black),
                )),
          )
        ],
      ).paddingSymmetric(horizontal: 5.w),
    );
  }
}
