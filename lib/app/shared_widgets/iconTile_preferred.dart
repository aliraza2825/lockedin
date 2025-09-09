import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import '../utils/utils.dart';

class PreferenceIconTile extends StatelessWidget {
  final String icon;
  final String title;
 final Color borderClr;
 final Color? clr;

   PreferenceIconTile({super.key, required this.icon, required this.title, required this.borderClr, required this.clr});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height / 23,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color:borderClr)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if(icon.isNotEmpty)
          Image.asset(Utils.getIconPath(
              icon),color:clr,scale: 4.0,),
          1.w.width,
          Text(title,style: TextStyle(color: clr),),
        ],
      ),
    );
  }
}


class PreferenceTextTile extends StatelessWidget {
  final String title;
 final Color borderClr;
 final Color clr;

   PreferenceTextTile({super.key, required this.title, required this.borderClr, required this.clr});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: Get.height / 23,
        // margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color:borderClr)),
        child: Center(child: Text(title,style: TextStyle(color: clr),)),
      ),
    );
  }
}

