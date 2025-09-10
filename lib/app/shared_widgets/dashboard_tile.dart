import 'package:locked_in/app/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../utils/utils.dart';

// Assuming AppColors, AppTextStyles, and Utils are already defined in your project.

class DashboardTile extends StatelessWidget {
  final String icon;
  final String title;
  final String? subtitle;
  final Color? iconBg;
  final Color? txtColor;

  const DashboardTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle, this.iconBg, this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 14,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.green.withOpacity(0.10)),
      ),
      child: Row(
        children: [
          Container(
            height: Get.width / 8.5,
            width: Get.width / 8.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: iconBg==null? AppColors.secondaryGradient:null,
              color: iconBg
            ),
            child: Image.asset(
              Utils.getIconPath(icon),
              scale: 4.0,
              color: AppColors.white,
            ),
          ),
          3.w.width,
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 200,),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: AppTextStyles.semiBold.copyWith(color: txtColor, overflow: TextOverflow.visible),
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
                if(subtitle !=null)
                  1.w.width,
                if(subtitle !=null)
                  Text(
                    subtitle ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins-500',
                      color: AppColors.darkPrimary,
                    ),
                  ),
              ],
            ),
          ),

          Spacer(),
          Icon(
            CupertinoIcons.forward,
            color: AppColors.grey,
          ),
        ],
      ).paddingSymmetric(horizontal: 2.w),
    );
  }
}
