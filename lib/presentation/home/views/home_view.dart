import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const lightBg = Color(0xFFE8F2FB);
    const navy = Color(0xFF143B5F);
    const labelGrey = Color(0xFF9AA7B2);

    return SafeArea(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          final String partnerName = controller.partnerName ?? 'Cameron';
          final String? partnerAvatarUrl = controller.partnerAvatarUrl;

          return Scaffold(
            backgroundColor: lightBg,
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 2.h),

                      // Header: lock + LOCKED IN
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _LockHeart(size: 22, color: navy),
                          const SizedBox(width: 8),
                          Text(
                            'LOCKED IN',
                            style: AppTextStyles.bodyTextBold.copyWith(
                              color: navy,
                              fontSize: 14.5.sp,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 1.8.h),

                      Text(
                        'You are currently',
                        style: AppTextStyles.bodyText.copyWith(
                          color: navy.withOpacity(0.75),
                          fontSize: 11.5.sp,
                        ),
                      ),

                      SizedBox(height: 0.8.h),

                      Text(
                        'LOCKED IN',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading.copyWith(
                          color: navy,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),

                      SizedBox(height: 3.2.h),

                      // Partner card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 18,
                              offset: Offset(0, 10),
                              color: Color(0x19000000),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'PARTNER',
                              style: AppTextStyles.bodyTextBold.copyWith(
                                color: labelGrey,
                                fontSize: 10.sp,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 0.8.h),
                            Text(
                              partnerName,
                              style: AppTextStyles.heading.copyWith(
                                color: navy,
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 1.8.h),

                            // Avatar (network or placeholder)
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: const Color(0xFFE6EDF3),
                              backgroundImage:
                                  partnerAvatarUrl != null ? NetworkImage(partnerAvatarUrl) : null,
                              child: partnerAvatarUrl == null
                                  ? Icon(Icons.person, size: 48, color: navy.withOpacity(0.35))
                                  : null,
                            ),

                            SizedBox(height: 2.2.h),

                            // Action bar
                            _ActionBar(
                              navy: navy,
                              onVerify: controller.onTapToVerify,
                              onEdit: controller.onEditStatus,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Segmented rounded outline with two actions.
class _ActionBar extends StatelessWidget {
  final VoidCallback onVerify;
  final VoidCallback onEdit;
  final Color navy;

  const _ActionBar({
    required this.onVerify,
    required this.onEdit,
    required this.navy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: navy.withOpacity(0.25), width: 1.4),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              onTap: onVerify,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_tethering, color: navy, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Tap to\nVerify',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: navy,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.5.sp,
                      height: 1.05,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(width: 1, height: double.infinity, color: navy.withOpacity(0.25)),
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              onTap: onEdit,
              child: Center(
                child: Text(
                  'Edit\nStatus',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: navy,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.5.sp,
                    height: 1.05,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small lock with heart cutout to match header.
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

    final cut = Paint()..color = const Color(0xFFE8F2FB);
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