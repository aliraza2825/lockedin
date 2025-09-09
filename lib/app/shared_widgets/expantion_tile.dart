import 'package:medical_courier/app/config/app_colors.dart';
import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final Widget? icon;
  final bool? isSelected;
  final ExpansionTileController ctrl;
  final List<Widget> children;
  final void Function(bool)? onExpansionChanged;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    required this.ctrl,
    this.icon,
    this.onExpansionChanged,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: ctrl,
      title: Row(
        children: [
          if (icon != null) ...[
            icon!,
            SizedBox(width: 2.w), // Spacing between icon and title
          ],
          Expanded(
            child: Text(
              title,
              style: isSelected == true
                  ? AppTextStyles.dashboardHeading.copyWith(
                  color: AppColors.darkPrimary,
                  fontSize: 14,
                  overflow: TextOverflow.visible)
                  : AppTextStyles.hintText.copyWith(
                  color: AppColors.darkPrimary,
                  overflow: TextOverflow.visible),
            ),
          ),
        ],
      ),
      onExpansionChanged: onExpansionChanged,
      backgroundColor: AppColors.white,
      collapsedBackgroundColor: AppColors.white,
      visualDensity: VisualDensity.comfortable,
      iconColor: AppColors.darkPrimary, // Default dropdown icon on right
      tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.darkPrimary),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isSelected == true ? AppColors.tertiaryOrange : AppColors.trans,
        ),
      ),
      children: children,
    );
  }
}




class CustomExpansionTileTools extends StatelessWidget {
  final String title;
  final Widget? icon;
  final ExpansionTileController ctrl;
  final List<Widget> children;
  final void Function(bool)? onExpansionChanged;

  const CustomExpansionTileTools({super.key, required this.title, required this.children, required this.ctrl, this.icon, this.onExpansionChanged, });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      controller: ctrl,
      trailing: icon,
      title: Text(title,style: AppTextStyles.semiBold.copyWith(color: AppColors.white),),
      onExpansionChanged: onExpansionChanged,
      backgroundColor: AppColors.darkPrimary,
      collapsedBackgroundColor: AppColors.darkPrimary,
      visualDensity: VisualDensity.comfortable,
      collapsedIconColor: AppColors.white,
      iconColor: AppColors.white,
      tilePadding: EdgeInsets.symmetric(horizontal: 4.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
        side:const BorderSide(color: AppColors.grey200),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
      ) ,
      children: children,
    );
  }
}