import 'package:locked_in/app/config/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundSimpleWidget extends StatelessWidget {
  final Widget child;
  const BackgroundSimpleWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: child,
        );
   }
}