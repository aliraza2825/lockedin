import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locked_in/app/config/app_colors.dart';
import 'package:locked_in/app/config/app_text_styles.dart';
import 'package:locked_in/app/shared_widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top section with logo and skip button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App Logo
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Locked In',
                        style: AppTextStyles.heading.copyWith(
                          fontSize: 18.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  // Skip button
                  TextButton(
                    onPressed: controller.skipOnboarding,
                    child: Text(
                      'Skip',
                      style: AppTextStyles.bodyTextBold.copyWith(
                        color: AppColors.grey500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView for onboarding content
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.onboardingPages.length,
                itemBuilder: (context, index) {
                  final pageData = controller.onboardingPages[index];
                  return _OnboardingPage(pageData: pageData);
                },
              ),
            ),

            // Bottom section with pagination and navigation
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
              child: Column(
                children: [
                  // Pagination dots
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.onboardingPages.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.w),
                          width: controller.currentPage.value == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color:
                                controller.currentPage.value == index
                                    ? AppColors.primary
                                    : AppColors.grey300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Navigation buttons
                  Obx(
                    () => Row(
                      children: [
                        if (controller.currentPage.value > 0)
                          Expanded(
                            child: CustomButton(
                              text: 'Previous',
                              onPress: controller.previousPage,
                              clr: AppColors.grey300,
                              txtClr: AppColors.black,
                            ),
                          ),
                        if (controller.currentPage.value > 0)
                          SizedBox(width: 3.w),
                        Expanded(
                          child: CustomButton(
                            text:
                                controller.currentPage.value ==
                                        controller.onboardingPages.length - 1
                                    ? 'Get Started'
                                    : 'Next',
                            onPress: controller.nextPage,
                            clr: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingData pageData;

  const _OnboardingPage({required this.pageData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Main image
          Container(
            width: double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(pageData.imageUrl),
            ),
          ),

          SizedBox(height: 5.h),

          // Title
          SizedBox(
            width: 80.w,
            child: Text(
              pageData.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: AppTextStyles.headingExtraLarge.copyWith(
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Subtitle
          Text(
            pageData.subtitle,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText400.copyWith(
              fontSize: 12.sp,
              color: AppColors.grey500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
