import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../routes/app_pages.dart';
import '../utils/utils.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? trailing;
  final Color? txtColor;
  final VoidCallback? onLeadingPressed;
  final bool isLoading;

  const AppBarCustom({
    super.key,
    required this.title,
    this.onLeadingPressed,
    this.trailing,
    this.txtColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.trans,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: Text(
        title,
        style: AppTextStyles.heading.copyWith(color: txtColor ?? AppColors.darkPrimary),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leadingWidth: 80,
      leading: IconButton(
        color: AppColors.white,
        onPressed: onLeadingPressed ??
                () {
              if(!isLoading)
                Get.back();
            }, // Default to Get.back() if no callback provided
        icon: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.13),
                blurRadius: 32,
                spreadRadius: 0,
                offset: const Offset(6, 5),
              ),
            ],
          ),
          child: const Icon(
            CupertinoIcons.back,
            color: AppColors.black,
            size: 26,
          ),
        ),
      ).paddingOnly(left: 6),
      actions: trailing == null
          ? null
          : [
        IconButton(
          color: AppColors.white,
          onPressed: () {
            Get.toNamed(Routes.NOTIFICATIONS);
          },
          icon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.15),
                  blurRadius: 32,
                  spreadRadius: 0,
                  offset: const Offset(6, 5),
                )
              ],
            ),
            child: Image.asset(
              Utils.getIconPath('Bell'),
              scale: 4.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
