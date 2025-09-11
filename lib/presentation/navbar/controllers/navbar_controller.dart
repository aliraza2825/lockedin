import 'package:locked_in/data/Services/chat_service.dart';
import 'package:locked_in/presentation/chat/controllers/chat_controller.dart';
import 'package:locked_in/presentation/home/controllers/home_controller.dart';
import 'package:locked_in/presentation/home/views/home_view.dart';
import 'package:locked_in/presentation/profile/controllers/profile_controller.dart';
import 'package:locked_in/presentation/profile/views/profile_view.dart';
import 'package:locked_in/presentation/social/views/social_view.dart';
import 'package:locked_in/presentation/social/controllers/social_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  PageController pageController = PageController();
  RxInt selectedIndex = 0.obs;

  List<Widget> pages =[

  ];
  @override
  void onInit() {
    Get.put(ProfileController());
    Get.put(ChatService());
    Get.put(SocialController());

    pages = [const SocialView(), const HomeView(), const ProfileView()];

    Get.put(ProfileController());
    Get.put(HomeController());
    Get.put(ChatController());
    super.onInit();
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    update();
  }
}
