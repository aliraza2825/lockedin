import 'dart:developer';

import 'package:medical_courier/app/config/global_var.dart';
import 'package:medical_courier/data/repositories/profile_repository.dart';
import 'package:get/get.dart';
import 'package:medical_courier/presentation/home/controllers/home_controller.dart';

import '../../../app/config/local_keys.dart';
import '../../../app/routes/app_pages.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/provider/local_storage/local_db.dart';
import '../../../data/Services/chat_service.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository = ProfileRepository();

  UserProfile? userProfile;

  @override
  void onInit() {
    if (Globals.authToken != "") {
      getUserProfile();
    }
    super.onInit();
  }

  Future<void> getUserProfile() async {
    try {
      final response = await _repository.getUserProfile(Globals.userId);
      if (response != null && response['status'] == true) {
        print(response['data']['first_name']);
        userProfile = UserProfile.fromJson(response['data']);
        await LocalDB.setData(
          LocalDataKey.userStatus.name,
          userProfile!.availabilityStatus,
        );
        Get.find<HomeController>().updateUserStatus(
          userProfile!.availabilityStatus,
        );
        update();
      }
    } catch (e) {
      log('getUserProfile: $e');
      throw Exception('An unexpected error occurred.');
    }
  }

  Future<void> deleteAccount() async {
    try {
      final response = await _repository.deleteAccount();
      if (response != null && response['status'] == 200) {
        // Unregister ChatService before account deletion
        ChatService.unregisterOnLogout();

        var data = await LocalDB.getData(LocalDataKey.language.name);
        LocalDB.clear();
        await LocalDB.setData(LocalDataKey.language.name, data);
        Get.offAllNamed(Routes.WELCOME);
      }
    } catch (e) {
      log('getUserProfile: $e');
      throw Exception('An unexpected error occurred.');
    }
  }
}
