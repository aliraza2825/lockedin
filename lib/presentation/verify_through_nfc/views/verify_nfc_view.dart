import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locked_in/presentation/verify_through_nfc/controllers/verify_nfc_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';

class VerifyPromptView extends GetView<VerifyNfcController> {
  const VerifyPromptView({super.key});

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF6AB2F7);     // screen blue
    const navy = Color(0xFF143B5F);     // deep text
    final partner = 'Emma';

    return Scaffold(
      backgroundColor: blue,
      body: SafeArea(
        child: Stack(
          children: [
            // Content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 2.h),
                    // Header: lock-heart + "Locked In"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _LockHeart(size: 24, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Locked In',
                          style: AppTextStyles.bodyTextBold.copyWith(
                            color: Colors.white,
                            fontSize: 18.sp,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    // Animated phone with waves
                    const _PhoneWithWaves(),

                    SizedBox(height: 4.h),

                    // Instruction text
                    Text(
                      "Hold your phone near the\nother person’s device to\nverify your relationship",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyText.copyWith(
                        color: Colors.white,
                        fontSize: 12.5.sp,
                        height: 1.25,
                      ),
                    ),

                    SizedBox(height: 22.h), // give space above the bottom sheet
                  ],
                ),
              ),
            ),

            // Bottom sheet card
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                minimum: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 24,
                        offset: Offset(0, 12),
                        color: Color(0x33000000),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Partner alert sent',
                        style: AppTextStyles.bodyTextBold.copyWith(
                          color: navy,
                          fontSize: 12.5.sp,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "A verification request has been\nsent to $partner’s device.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyText.copyWith(
                          color: navy.withOpacity(0.8),
                          fontSize: 10.5.sp,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('OK'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Center phone with animated side waves
class _PhoneWithWaves extends StatefulWidget {
  const _PhoneWithWaves();

  @override
  State<_PhoneWithWaves> createState() => _PhoneWithWavesState();
}

class _PhoneWithWavesState extends State<_PhoneWithWaves>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _scale;
  late final Animation<double> _wave;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scale = Tween(begin: 0.98, end: 1.02)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_c);

    _wave = Tween(begin: 0.6, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_c);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const phoneBorder = Color(0xFF2F6E9F);
    const heart = Color(0xFF2F6E9F);

    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        return Transform.scale(
          scale: _scale.value,
          child: SizedBox(
            width: 44.w,
            height: 44.w * 1.8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Waves
                Positioned.fill(
                  child: CustomPaint(
                    painter: _WavesPainter(progress: _wave.value),
                  ),
                ),
                // Phone
                _PhoneOutline(
                  borderColor: phoneBorder,
                  heartColor: heart,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PhoneOutline extends StatelessWidget {
  final Color borderColor;
  final Color heartColor;

  const _PhoneOutline({
    required this.borderColor,
    required this.heartColor,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 3),
        ),
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Icon(
            Icons.favorite, // simple heart
            size: 44,
            color: heartColor,
          ),
        ),
      ),
    );
  }
}

class _WavesPainter extends CustomPainter {
  final double progress; // 0..1
  _WavesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final h = size.height * 0.32;
    final dx = size.width * 0.38;

    // Draw 2 arcs per side, animate opacity/length by progress
    for (int i = 0; i < 2; i++) {
      final t = (progress * 0.6 + i * 0.2).clamp(0.0, 1.0);
      final alpha = (180 * t).toInt().clamp(0, 180);
      p.color = Colors.white.withAlpha(alpha);

      final r = Rect.fromCenter(
        center: center.translate(-dx, 0),
        width: h,
        height: h * (0.7 + i * 0.25),
      );
      canvas.drawArc(r, -1.2, 2.4 * t, false, p);

      final r2 = Rect.fromCenter(
        center: center.translate(dx, 0),
        width: h,
        height: h * (0.7 + i * 0.25),
      );
      canvas.drawArc(r2, 3.14159 - 1.2, 2.4 * t, false, p);
    }
  }

  @override
  bool shouldRepaint(covariant _WavesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Small lock with heart cutout (for header)
class _LockHeart extends StatelessWidget {
  final double size;
  final Color color;
  const _LockHeart({required this.size, required this.color});

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size.square(size), painter: _LockHeartPainter(color));
}

class _LockHeartPainter extends CustomPainter {
  final Color color;
  _LockHeartPainter(this.color);

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    final p = Paint()..color = color;

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.22, h * 0.40, w * 0.56, h * 0.52),
      Radius.circular(w * 0.16),
    );
    canvas.drawRRect(body, p);

    final sp = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.12
      ..strokeCap = StrokeCap.round
      ..color = color;
    final arc = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(w / 2, h * 0.40), radius: w * 0.30),
        3.14 + 0.35,
        3.14 - 0.70,
      );
    canvas.drawPath(arc, sp);

    final cut = Paint()..color = Colors.white;
    final cx = w / 2, cy = h * 0.66, r = w * 0.13;
    final heart = Path()
      ..moveTo(cx, cy + r * 0.5)
      ..cubicTo(cx + r, cy, cx + r * 0.9, cy - r * 0.8, cx, cy - r * 0.4)
      ..cubicTo(cx - r * 0.9, cy - r * 0.8, cx - r, cy, cx, cy + r * 0.5);
    canvas.drawPath(heart, cut);
  }

  @override
  bool shouldRepaint(covariant _LockHeartPainter oldDelegate) => false;
}