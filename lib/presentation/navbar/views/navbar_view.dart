import 'package:dio_log/http_log_list_widget.dart';
import 'package:locked_in/app/config/app_colors.dart';
import 'package:locked_in/app/shared_widgets/background_simple.dart';
import 'package:locked_in/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            final shouldPop = await showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text('Are you sure?'.tr),
                    content: Text('Do you want to exit the app?'.tr),
                    actions: [
                      TextButton(
                        child: Text('No'.tr),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text('Yes'.tr),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
            );
            return shouldPop;
          },
          child: BackgroundSimpleWidget(
            child: Scaffold(
              backgroundColor: AppColors.trans, // Ensures gradient shows
              body: SafeArea(
                bottom: false, // FIX: Removes extra bottom padding
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.onItemTapped(index);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  children: controller.pages,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                elevation: 0,
                unselectedFontSize: 0,
                selectedFontSize: 0,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        Utils.getIconPath(
                          controller.selectedIndex.value == 1 ? "lock" : "lock",
                        ),
                      ),
                      size: 40,
                    ),
                    label: 'Social'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onLongPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HttpLogListWidget(),
                          ),
                        );
                      },
                      child: ImageIcon(
                        AssetImage(
                          Utils.getIconPath(
                            controller.selectedIndex.value == 0
                                ? "home_fill"
                                : "home",
                          ),
                        ),
                        size: 40,
                      ),
                    ),
                    label: 'Home'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        Utils.getIconPath(
                          controller.selectedIndex.value == 2
                              ? "profile_fill"
                              : "profile",
                        ),
                      ),
                      size: 40,
                    ),
                    label: 'Profile'.tr,
                  ),
                ],
                currentIndex: controller.selectedIndex.value,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.black,
                backgroundColor:
                    AppColors.white, // FIX: Ensures correct gradient background

                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                selectedLabelStyle: const TextStyle(
                  color: AppColors.secondary,
                  fontFamily: 'Poppins-600',
                  fontSize: 10,
                ),
                onTap: (index) {
                  controller.onItemTapped(index);
                  controller.pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Clipper for the rounded navbar top
class TopRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 30;

    Path path =
        Path()
          ..moveTo(0, radius)
          ..quadraticBezierTo(0, 0, radius, 0)
          ..lineTo(size.width - radius, 0)
          ..quadraticBezierTo(size.width, 0, size.width, radius)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
