import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  // Onboarding data based on the updated screenshots
  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      title: "Your Relationship, Perfectly Secured",
      subtitle:
          "Effortlessly verify and protect your relationship status. Start securing now!",
      imageUrl: "assets/onboarding/onboarding_1.png",
    ),
    OnboardingData(
      title: "Stay Locked In",
      subtitle:
          "Easily verify your partner’s status and stay securely locked in together.",
      imageUrl: "assets/onboarding/onboarding_2.png", // lock/verify related
    ),
    OnboardingData(
      title: "Connect & Grow",
      subtitle:
          "Discover friends, build connections, and grow your social circle with mutuals.",
      imageUrl: "assets/onboarding/onboarding_3.png", // social/friends related
    ),
  ];

  void nextPage() async {
    if (currentPage.value < onboardingPages.length - 1) {
      currentPage.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Mark onboarding as completed
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_seen_onboarding', true);

      // Navigate to next screen after onboarding
      Get.offAllNamed('/personal-info');
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipOnboarding() async {
    // Mark onboarding as completed even when skipped
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);

    Get.offAllNamed('/welcome');
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final String imageUrl;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}
