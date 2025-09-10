import 'package:locked_in/app/config/app_colors.dart';
import 'package:locked_in/app/config/app_text_styles.dart';
import 'package:locked_in/app/extensions/extensions.dart';
import 'package:locked_in/app/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../app/routes/app_pages.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const lightBg = Color(0xFFE8F2FB);

    return Scaffold(
      backgroundColor: lightBg,

      // Bottom fixed button
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'Continue'.tr,
            onPress: () => Get.toNamed(Routes.PERSONAL_INFO),
            clr: AppColors.primary,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Content column with vertical centering for the tiles area
              return Column(
                children: [
                  // Title
                  4.h.height,
                  Text(
                    'Tap to Confirm\nLock it in',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 22.sp,
                      color: AppColors.black,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  // Push the cards area to be vertically centered
                  2.5.h.height,
                  const Spacer(),

                  // Centered tiles with max width so they don’t stretch on tablets
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          _PermissionTile(
                            icon: Icons.cloud_outlined,
                            title: 'Notify options',
                            subtitle: 'Re: arriving/going website',
                          ),
                          SizedBox(height: 14),
                          _PermissionTile(
                            icon: Icons.grid_view_rounded,
                            title: 'Frequent apps',
                            subtitle: 'Keep inline Convos / UMFC',
                          ),
                          SizedBox(height: 14),
                          _PermissionTile(
                            icon: Icons.notifications_active_outlined,
                            title: 'Notifications',
                            subtitle: 'Per-route notifications',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Space above the fixed bottom button so content never collides
                  6.h.height,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// White rounded tile with blue leading icon.
class _PermissionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PermissionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            offset: Offset(0, 8),
            color: Color(0x1A000000),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon chip
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),

          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyTextBold.copyWith(
                    color: AppColors.black,
                    fontSize: 12.5.sp,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyText.copyWith(
                    color: AppColors.black.withOpacity(0.6),
                    fontSize: 10.5.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}