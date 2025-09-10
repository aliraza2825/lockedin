import 'package:get/get.dart';
import 'package:locked_in/app/config/global_var.dart';

import '../provider/network/api_endpoint.dart';
import '../provider/network/api_provider.dart';

class ProfileRepository{
  late APIProvider apiClient;

  ProfileRepository() {
    apiClient = APIProvider();
  }

  Future updateProfile() async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.profile,
      {
        "id": 0,
        "avatar": "string",
        "full_name": "string",
        "email": "user@example.com",
        "age": 2,
        "state": "string",
        "zip_code": "string"
      },
      true,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future getUserProfile(int id) async {
    Map<String, dynamic>? data =
        await apiClient.baseGetAPI("${ApiEndPoints.profile}$id", {}, true, Get.context);
    return data;
  }
  Future deleteAccount() async {
    Map<String, dynamic>? data = await apiClient.baseDeleteAPI(
      ApiEndPoints.deleteAccount,
      {},
      true,
      Get.context
    );
    print(data);
    return data;
  }
  Future changePin(String currentPin,String newPin) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.changePin,
      {"currentPassword":currentPin,"newPassword":newPin,"userId":Globals.userId},
      true,
      Get.context
    );
    print(data);
    return data;
  }

  Future getSearchHistory() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      ApiEndPoints.getSearchHistory,
      {},
      true,
      Get.context
    );
    print(data);
    return data;
  }
}