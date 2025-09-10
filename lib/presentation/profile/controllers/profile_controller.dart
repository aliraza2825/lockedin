import 'dart:developer';

import 'package:locked_in/app/config/global_var.dart';
import 'package:locked_in/data/repositories/profile_repository.dart';
import 'package:get/get.dart';
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
      // getUserProfile();
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
          response['data']['first_name'],
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
