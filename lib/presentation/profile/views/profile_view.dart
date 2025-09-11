import 'package:locked_in/app/config/global_var.dart';
import 'package:locked_in/app/config/local_keys.dart';
import 'package:locked_in/app/extensions/extensions.dart';
import 'package:locked_in/app/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/routes/app_pages.dart';
import '../../../app/shared_widgets/dashboard_tile.dart';
import '../../../data/provider/local_storage/local_db.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (c) {
          return Scaffold(
            backgroundColor: AppColors.trans,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              title: Text(
                '  ${'My Profile'.tr}',
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.darkPrimary,
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.NOTIFICATIONS);
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.white.withOpacity(0.15),
                          blurRadius: 32,
                          spreadRadius: 0,
                          offset: const Offset(6, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  3.5.h.height,
                  Text(
                    'ALI Raza',
                    style: AppTextStyles.semiBold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  4.h.height,
                  // if(Globals.authToken != "")
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.ACCOUNT_SETTING);
                    },
                    child: DashboardTile(
                      icon: 'profile_fill',
                      title: 'Account Settings'.tr,
                      iconBg: AppColors.darkPrimary,
                    ),
                  ),
                  1.h.height,

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.CONTACT_US);
                    },
                    child: DashboardTile(
                      icon: 'message',
                      title: 'Contact Us'.tr,
                    ),
                  ),
                  1.h.height,
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.UPDATE_PIN);
                    },
                    child: DashboardTile(
                      icon: 'lock',
                      title: 'Change Password'.tr,
                      iconBg: AppColors.darkPrimary,
                    ),
                  ),
                  1.h.height,
                  GestureDetector(
                    onTap: () {
                      showDeleteDialog(context);
                    },
                    child: DashboardTile(
                      icon: 'delete',
                      title: 'Delete Account'.tr,
                      iconBg: AppColors.red,
                    ),
                  ),
                  2.h.height,
                  GestureDetector(
                    onTap: () async {
                      showLogoutConfirmationDialog(context);
                    },
                    child: Container(
                      width: double.infinity,
                      // width: MediaQuery.of(context).size.width * 0.8,
                      height: Get.height / 16.3,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        // color: AppColors.tertiaryOrange,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout_outlined,
                            color: AppColors.white,
                          ),
                          Text(
                            'Logout'.tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 2.h.height,
                  // if (Globals.authToken == "")
                  //   CustomGradientButton(
                  //     text: 'Login'.tr,
                  //     onPress: () async {
                  //       Get.offAllNamed(Routes.SIGNIN_WITH_PIN);
                  //     },
                  //   ),
                  // 4.h.height,
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
          );
        },
      ),
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Removes rounded corners
          ),
          child: Container(
            width: Get.width / 1.2,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                2.h.height,
                Text(
                  'Logout?'.tr,
                  style: AppTextStyles.semiBold.copyWith(
                    fontSize: 15.sp,
                    color: AppColors.darkPrimary,
                  ),
                ),
                2.h.height,
                Text(
                  'Are you sure you want to logout?'.tr,
                  style: AppTextStyles.bodyTextBold.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                4.h.height,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        text: 'Cancel'.tr,
                        clr: AppColors.primary,
                        onPress: () {
                          Get.back();
                        },
                      ),
                    ),
                    10.width,
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        text: 'Logout'.tr,

                        // clr: AppColors.primary,
                        onPress: () async {
                          var data = await LocalDB.getData(
                            LocalDataKey.language.name,
                          );
                          LocalDB.clear();
                          await LocalDB.setData(
                            LocalDataKey.language.name,
                            data,
                          );
                          Get.offAllNamed(Routes.SIGNIN_WITH_PIN);
                        },
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 10),
                2.h.height,
              ],
            ),
          ),
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Removes rounded corners
          ),
          child: Container(
            width: Get.width / 1.2,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                2.h.height,
                Text(
                  'Delete Account?'.tr,
                  style: AppTextStyles.semiBold.copyWith(
                    fontSize: 15.sp,
                    color: AppColors.darkPrimary,
                  ),
                ),
                2.h.height,
                Text(
                  'Are you sure you want to proceed?'.tr,
                  style: AppTextStyles.bodyTextBold.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                4.h.height,
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        text: 'Cancel'.tr,
                        clr: AppColors.primary,
                        onPress: () {
                          Get.back();
                        },
                      ),
                    ),
                    10.width,
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        text: 'Delete'.tr,

                        // clr: AppColors.primary,
                        onPress: () async {
                          await controller.deleteAccount();
                        },
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 10),
                2.h.height,
              ],
            ),
          ),
        );
      },
    );
  }

  void _showProfilePicturePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor:
                Colors.transparent, // To make the background transparent
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
          ),
    );
  }
}
