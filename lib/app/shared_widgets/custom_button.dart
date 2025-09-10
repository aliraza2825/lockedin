
import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color? clr;
  final Color? txtClr;
  final double? height;
  final Widget? child;
  final Function()? onPress;
   CustomButton({super.key,required this.text, required this.onPress, this.clr, this.txtClr,this.child,this.height});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onPress,
      child: Container(
        width: double.infinity,
        // width: MediaQuery.of(context).size.width * 0.8,
        height: widget.height?? 50,
        decoration: BoxDecoration(
        color:widget.clr ?? AppColors.secondary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(child:widget.child?? Text(widget.text, style: AppTextStyles.semiBold.copyWith(color:widget.txtClr?? AppColors.white),)),
      ),
    );
  }
}



class CustomButtonWhite extends StatefulWidget {
  final String text;
  final Function()? onPress;
  CustomButtonWhite({super.key,required this.text, required this.onPress});

  @override
  State<CustomButtonWhite> createState() => _CustomButtonWhiteState();
}

class _CustomButtonWhiteState extends State<CustomButtonWhite> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onPress,
      child: Container(
        width: double.infinity,
        // width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        // height: Get.height/16.3,
        decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(child: GradientText(widget.text,
          style: AppTextStyles.semiBold,
          colors: [
        AppColors.primary,
        AppColors.darkPrimary
      ])),
      ),
    );
  }
}





class CustomGradientButton extends StatefulWidget {
  final String text;
  final Widget? child;
  final Function()? onPress;
  CustomGradientButton({super.key,required this.text, required this.onPress,this.child});

  @override
  State<CustomGradientButton> createState() => _CustomGradientButtonState();
}

class _CustomGradientButtonState extends State<CustomGradientButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onPress,
      onLongPress: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HttpLogListWidget(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        // width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primary,
        // color: AppColors.tertiaryOrange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child:widget.child?? Text(widget.text, style: AppTextStyles.semiBold.copyWith(color: AppColors.white),)),
      ),
    );
  }
}