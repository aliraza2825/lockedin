import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import '../utils/utils.dart';

class CustomAnimatedDropdown extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? expensionColor;
  final Color? textColor;
  final bool isTileOpen;
  final List<Widget> children;
  final double? fontSize;

  const CustomAnimatedDropdown(
      {super.key,
      required this.text,
      required this.onTap,
      this.backgroundColor,
      this.textColor,
      required this.isTileOpen,
      required this.children,
      this.fontSize,
      this.expensionColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: Get.height / 15.6,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.grey.withOpacity(0.50)),
              color: AppColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: AppTextStyles.semiBold,
                ),
                // Smooth icon transition
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return RotationTransition(
                        turns: AlwaysStoppedAnimation(isTileOpen ? 0.50 : 0.0),
                        child: child);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  // child: Image.asset(
                  //   Utils.getIconPath(
                  //     isTileOpen
                  //       ? 'up'
                  //     :
                  //       'down'),
                  //   key: ValueKey<bool>(isTileOpen),
                  //   scale: 4.0,
                  //   color: AppColors.black,
                  // ),
                ),
              ],
            ).paddingSymmetric(horizontal: 4.w),
          ),
        ),
        .5.h.height,
// Smooth expansion and collapse of the container
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves
              .easeInOut, // Smoother curve for natural expansion and collapse
          child: Container(
            width: double.infinity,
            padding: isTileOpen ? const EdgeInsets.all(10.0) : EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: expensionColor ?? AppColors.white,
            ),
            child: isTileOpen
                ? AnimatedOpacity(
                    opacity: isTileOpen ? 1.0 : 0.0, // Fades in the content
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  )
                : const SizedBox(), // Empty space when tile is closed
          ),
        ),
      ],
    );
  }
}

class CustomAnimatedStep extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? expensionColor;
  final Color? textColor;
  final Color? iconClr;
  final bool isTileOpen;
  final List<Widget> children;
  final double? fontSize;

  const CustomAnimatedStep({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    required this.isTileOpen,
    required this.children,
    this.fontSize,
    this.expensionColor,
    this.iconClr,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: MediaQuery.of(context).size.height / 22,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: isTileOpen
                  ? const BorderRadius.vertical(top: Radius.circular(10))
                  : BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.20)),
              color: backgroundColor ?? Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded( // Constrain the Text widget
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2, // Restrict to a maximum of 2 lines
                    overflow: TextOverflow.ellipsis, // Add ellipsis (...) if the text exceeds 2 lines
                  ),
                ),
                // Smooth icon transition
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: AlwaysStoppedAnimation(isTileOpen ? 0.50 : 0.0),
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: iconClr ?? Colors.black,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16.0), // Adjusted padding for clarity
          ),
        ),
        // Smooth expansion and collapse of the container
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut, // Smoother curve for natural expansion and collapse
          child: Container(
            width: double.infinity,
            padding: isTileOpen ? const EdgeInsets.all(10.0) : EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10)),
              color: expensionColor ?? Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            child: isTileOpen
                ? AnimatedOpacity(
              opacity: isTileOpen ? 1.0 : 0.0, // Fades in the content
              duration: const Duration(milliseconds: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            )
                : const SizedBox(), // Empty space when tile is closed
          ),
        ),
      ],
    );
  }
}

