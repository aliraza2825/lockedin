import 'dart:async';
import 'package:flutter/material.dart';
import 'package:locked_in/app/routes/app_pages.dart';
import 'package:locked_in/app/config/app_colors.dart';
import 'package:locked_in/app/config/app_text_styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeController extends GetxController {
  bool isLoading = false;

  String? partnerName;
  String? partnerAvatarUrl;

  // Status management
  final RxString currentStatus = 'Locked'.obs;
  final Rx<DateTime?> statusStartTime = Rx<DateTime?>(null);
  final RxString timeRemaining = '24:00:00'.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    update();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (statusStartTime.value != null) {
        final now = DateTime.now();
        final startTime = statusStartTime.value!;
        final elapsed = now.difference(startTime);
        final totalDuration = const Duration(hours: 24);

        if (elapsed >= totalDuration) {
          // Status expired, reset to default
          currentStatus.value = 'Locked';
          statusStartTime.value = null;
          timeRemaining.value = '24:00:00';
        } else {
          final remaining = totalDuration - elapsed;
          final hours = remaining.inHours;
          final minutes = remaining.inMinutes % 60;
          final seconds = remaining.inSeconds % 60;
          timeRemaining.value =
              '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        }
      }
    });
  }

  void onTapToVerify() {
    Get.toNamed(Routes.VERIFY_NFC);
  }

  void onEditStatus() {
    _showStatusBottomSheet();
  }

  void _showStatusBottomSheet() {
    Get.bottomSheet(
      _buildStatusBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  Widget _buildStatusBottomSheet() {
    return Container(
      height: Get.height * 0.55,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            'Select Status',
            style: AppTextStyles.headingExtraLarge.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Status options
          Expanded(
            child: Column(
              children: [
                _buildStatusOption(
                  'Locked',
                  'You are currently locked in',
                  Icons.lock,
                ),
                const SizedBox(height: 16),
                _buildStatusOption(
                  'Unlock',
                  'You are currently unlocked',
                  Icons.lock_open,
                ),
                const SizedBox(height: 16),
                _buildStatusOption(
                  'Unmarried',
                  'You are currently unmarried',
                  Icons.favorite_border,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption(String status, String description, IconData icon) {
    return Obx(
      () => GestureDetector(
        onTap: () => _selectStatus(status),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                currentStatus.value == status
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  currentStatus.value == status
                      ? AppColors.primary
                      : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color:
                    currentStatus.value == status
                        ? AppColors.primary
                        : Colors.grey[600],
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: AppTextStyles.bodyTextBold.copyWith(
                        fontSize: 16.sp,
                        color:
                            currentStatus.value == status
                                ? AppColors.primary
                                : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.bodyText400.copyWith(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (currentStatus.value == status)
                Icon(Icons.check_circle, color: AppColors.primary, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _selectStatus(String status) {
    currentStatus.value = status;
    statusStartTime.value = DateTime.now();
    _startTimer();
    Get.back();

    // Show success message
    Get.snackbar(
      'Status Updated',
      'Your status has been set to $status for 24 hours',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
