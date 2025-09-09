import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (_) {
        return Scaffold(
          body: Center(
            child: BouncingLogo(),
          ),
        );
      },
    );
  }
}

class BouncingLogo extends StatefulWidget {
  @override
  _BouncingLogoState createState() => _BouncingLogoState();
}

class _BouncingLogoState extends State<BouncingLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Image.asset(
        'assets/pngs/logo.png', // Replace with your logo image
        width: 240,
        height: 240,
      ),
    );
  }
}