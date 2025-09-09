import 'package:medical_courier/data/Services/chat_service.dart';
import 'package:medical_courier/presentation/chat/controllers/chat_controller.dart';
import 'package:medical_courier/presentation/chat/views/chat_view.dart';
import 'package:medical_courier/presentation/home/controllers/home_controller.dart';
import 'package:medical_courier/presentation/home/views/home_view.dart';
import 'package:medical_courier/presentation/profile/controllers/profile_controller.dart';
import 'package:medical_courier/presentation/profile/views/profile_view.dart';
import 'package:medical_courier/presentation/tools_and_tutorials/views/tools_and_tutorials_view.dart';
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

    pages = [
      const HomeView(),
      const ToolsAndTutorialsView(),
      const ChatView(),
      const ProfileView(),
    ];

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
