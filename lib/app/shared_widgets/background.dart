import 'package:locked_in/app/config/app_colors.dart';
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
          color: AppColors.white),
        child: child,
        );
   }
}