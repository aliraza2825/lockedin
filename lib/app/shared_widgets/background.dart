import 'package:medical_courier/app/config/app_colors.dart';
import 'package:medical_courier/app/utils/utils.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final ImageProvider? img;
  const BackgroundWidget({super.key, required this.child, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
            image: DecorationImage(image: AssetImage(Utils.getImagePath('background_simple')), fit: BoxFit.fill)),
        child: child,
        );
   }
}