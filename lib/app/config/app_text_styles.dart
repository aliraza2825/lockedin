import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locked_in/app/config/app_colors.dart';
import 'package:sizer/sizer.dart';

class AppTextStyles {
  static TextStyle regular = TextStyle();
  static  TextStyle headingExtraLarge = TextStyle(
  fontSize: 26.sp,
  fontFamily: 'Poppins-800',
  color: AppColors.primary,
      overflow: TextOverflow.ellipsis
  );
  static  TextStyle primaryClrHeading = GoogleFonts.poppins(
    textStyle: TextStyle(
        fontSize: 15.sp,
        color: AppColors.primary,fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis
    ),
  );
  // static  TextStyle heading = TextStyle(
  // fontSize: 17.sp,
  // color: AppColors.black,
  //     overflow: TextOverflow.ellipsis
  // );
  static  TextStyle heading = GoogleFonts.poppins(
    textStyle: TextStyle(
        fontSize: 17.sp,
        color: AppColors.primary,fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis
    ),
  );

  static TextStyle semiBold = GoogleFonts.poppins(
    textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600,color: AppColors.black, overflow: TextOverflow.ellipsis),
  );

  static TextStyle bodyText = TextStyle(
  fontSize: 12.sp,
  fontFamily: 'Poppins-400',
  color: AppColors.white, overflow: TextOverflow.ellipsis
  );
  static TextStyle bodyTextBold = GoogleFonts.poppins(
    textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500,color: AppColors.black, overflow: TextOverflow.ellipsis),
  );

  static TextStyle bodyText400 = GoogleFonts.poppins(
    textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400,color: AppColors.grey400, overflow: TextOverflow.ellipsis),
  );

  // TextStyle(
  // fontSize: 16,
  // fontFamily: 'Poppins-500',
  // color: AppColors.black, overflow: TextOverflow.ellipsis
  // );
  static  TextStyle mediumHeading = GoogleFonts.poppins(
    textStyle: TextStyle(
        fontSize: 16.sp,
        color: AppColors.black,fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis
    ),
  );
  static  TextStyle twentySemiBoldText = GoogleFonts.poppins(
    textStyle: TextStyle(
        fontSize: 15.sp,
        color: AppColors.black,fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis
    ),
  );
  static  TextStyle twentyNormalText = TextStyle(
  fontSize: 15.sp,
  fontFamily: 'Poppins-400',
  color: AppColors.black,
      overflow: TextOverflow.ellipsis
  );
  static const TextStyle hintText = TextStyle(
  fontSize: 14,
  fontFamily: 'Poppins-400',
  color: AppColors.hintColor,
      overflow: TextOverflow.ellipsis
  );
  static  TextStyle normalText =const TextStyle(
  fontSize: 14,
  fontFamily: 'Poppins-400',
  color: AppColors.black, overflow: TextOverflow.ellipsis
  );
  static  TextStyle small = GoogleFonts.poppins(
    textStyle: TextStyle(
        fontSize: 9.sp,
        color: AppColors.white,fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis
    ),
  );

  static  TextStyle dashboardHeading = TextStyle(
  fontSize: 13.sp,
  fontFamily: 'Poppins-700',
  color: AppColors.darkPrimary,
      overflow: TextOverflow.ellipsis
  );


}