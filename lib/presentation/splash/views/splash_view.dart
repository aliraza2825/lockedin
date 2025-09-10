import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (_) {
        return const Scaffold(
          backgroundColor: Color(0xFF6AB2F7), // full-screen blue
          body: SafeArea(
            child: Center(
              child: BouncingLogo(),
            ),
          ),
        );
      },
    );
  }
}

class BouncingLogo extends StatefulWidget {
  const BouncingLogo({super.key});

  @override
  _BouncingLogoState createState() => _BouncingLogoState();
}

class _BouncingLogoState extends State<BouncingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.95, end: 1.05)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double iconSize = MediaQuery.of(context).size.width * 0.25;

    return ScaleTransition(
      scale: _animation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // If you prefer your PNG logo instead, swap this CustomPaint
          // with Image.asset('assets/pngs/logo.png', width: iconSize*1.2, height: iconSize*1.2)
          LockWithHeartIcon(
            size: iconSize,
            lockColor: Colors.white,
            cutoutColor: const Color(0xFF6AB2F7), // same as bg -> "cutout"
          ),
          const SizedBox(height: 20),
          Text(
            'LOCKED\nIN',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              height: 1.0,
              letterSpacing: 1.2,
              fontSize: MediaQuery.of(context).size.width * 0.12,
            ),
          ),
        ],
      ),
    );
  }
}

/// Rounded lock with a heart cutout
class LockWithHeartIcon extends StatelessWidget {
  final double size;
  final Color lockColor;
  final Color cutoutColor;

  const LockWithHeartIcon({
    super.key,
    required this.size,
    required this.lockColor,
    required this.cutoutColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _LockWithHeartPainter(lockColor, cutoutColor),
    );
  }
}

class _LockWithHeartPainter extends CustomPainter {
  final Color lockColor;
  final Color cutoutColor;
  _LockWithHeartPainter(this.lockColor, this.cutoutColor);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    // Body
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.2, h * 0.35, w * 0.6, h * 0.55),
      Radius.circular(w * 0.15),
    );
    canvas.drawRRect(body, Paint()..color = lockColor);

    // Shackle
    final shackle = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.12
      ..strokeCap = StrokeCap.round
      ..color = lockColor;
    final arc = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(w / 2, h * 0.35), radius: w * 0.3),
        3.14 + 0.35,
        3.14 - 0.70,
      );
    canvas.drawPath(arc, shackle);

    // Heart cutout (painted with bg color)
    final cx = w / 2, cy = h * 0.60, r = w * 0.12;
    final heart = Path()
      ..moveTo(cx, cy + r * 0.5)
      ..cubicTo(cx + r, cy, cx + r * 0.9, cy - r * 0.8, cx, cy - r * 0.4)
      ..cubicTo(cx - r * 0.9, cy - r * 0.8, cx - r, cy, cx, cy + r * 0.5);
    canvas.drawPath(heart, Paint()..color = cutoutColor);
  }

  @override
  bool shouldRepaint(covariant _LockWithHeartPainter oldDelegate) => false;
}