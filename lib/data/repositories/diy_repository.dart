import 'dart:io';

import 'package:medical_courier/app/config/global_var.dart';
import 'package:get/get.dart';
import '../provider/network/api_endpoint.dart';
import '../provider/network/api_provider.dart';

class DIYRepository{
  late APIProvider apiClient;

  DIYRepository() {
    apiClient = APIProvider();
  }

  Future login(String num,String code) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
      ApiEndPoints.login,
      {
        "email": num.replaceAll(' ', ''),
        "password":code
      },
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future register(String num) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
      ApiEndPoints.register,
      {
        "phone_number": num.replaceAll(' ', '').replaceAll('(', '').replaceAll(')', ''),
        "role":1
      },
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future verifyToken() async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.verifyToken,
      {
        "token":Globals.authToken
      },
      false,
      loading: false,
      Get.context,
    );
    print(data);
    return data;
  }

  Future verifyOtp(String num) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
      ApiEndPoints.verifyOtp,
      {
        "otp": num,
      },
      true,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future verifyOtpWithPhone(String num,String phone) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
      ApiEndPoints.verifyOtpByPhone,
      {
        "phone_number":phone.replaceAll('(', '').replaceAll(')', ''),
        "otp": num,
      },
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future setPin(String num,{String? email}) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
      ApiEndPoints.createPin,
      {
        "password": num,
        "email": email,
      },
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  // Future personalInfo({required String fullName,required String email,required int age,required String state,required String zip,required File avatar}) async {
  //   Map<String, dynamic> data = await apiClient.baseMultipartPersonalInfo(
  //     ApiEndPoints.createProfile,
  //     {
  //       "full_name": fullName,
  //       "email": email,
  //       "age": age,
  //       "state": state,
  //       "zip_code": zip,
  //     },
  //     avatar,
  //     Get.context!
  //   );
  //   return data;
  // }
  
  // Future personalInfoUpdate({required String fullName,required String email,required int age,required String state,required String zip, File? avatar}) async {
  //   Map<String, dynamic> data = await apiClient.baseMultipartPersonalInfoPatch(
  //     ApiEndPoints.profile,
  //     {
  //       "full_name": fullName,
  //       "email": email,
  //       "age": age,
  //       "state": state,
  //       "zip_code": zip,
  //     },
  //     avatar!,
  //     Get.context!
  //   );
  //   return data;
  // }
  
  Future updatePersonalInfo({required String firstName,required String lastName,required String email,
  required String phoneNumber,required String currentAddress,required String permanentAddress,required String licenseNumber,required String licenseFrontPhotoPath,
  required String licenseBackPhotoPath,required String irsTaxForm,required String emergencyContact,required String ssn ,required bool isActive,File? licenseFrontPhoto,File? licenseBackPhoto}) async {

    var dynamicData = {
      "LastName": lastName,
      "IRSTaxForm": irsTaxForm,
      "UserId":  Globals.userId,
      "PermanentAddress": permanentAddress,
      "LicenseNumber": licenseNumber,
      "SSN": ssn,
      "EmergencyContact": emergencyContact,
      "IsActive": isActive,
      "PhoneNumber": phoneNumber,
      "CurrentAddress": currentAddress,
      "FirstName": firstName,
      "Email": email,
    };
    if(licenseFrontPhoto == null){
      dynamicData['LicenseFrontPhotoPath'] = licenseFrontPhotoPath;
    }
    if(licenseBackPhoto == null){
      dynamicData['LicenseBackPhotoPath'] = licenseBackPhotoPath;
    }

    Map<String, dynamic> data = await apiClient.baseMultipartPersonalInfo(
      ApiEndPoints.updateProfile,
      dynamicData,
      licenseFrontPhoto,
      licenseBackPhoto,
      Get.context!
    );
    return data;
  }

  Future userPreferences({
    required int skill,
    required List<String?> hobbies,
    required Map<String,List<String>> brands,
    // required List<String> tools,
    // required List<String> equipment,
    required List<int?> preferred_retailers,
    required List<String?> style_preferences,
    // required List<String> paint_and_finishes,
    required List<String?> notification,
  }) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        ApiEndPoints.userPreferences,
        {
          "skill_level": skill,
          "hobbies": hobbies,
          // "tools": tools,
          // "equipment": equipment,
          "preferred_retailers": preferred_retailers,
          "style_preferences": style_preferences,
          // "paint_and_finishes": paint_and_finishes,
          "notifications":notification,
          "brands":brands
        },
        true,
        loading: true,
        Get.context!
    );
    return data;
  }

  Future forgotPin(String num) async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
      "${ApiEndPoints.forgotPin}?email=$num",
      {},
      false,
      loading: true,
      Get.context,
    );
    return data;
  }
  
  Future getStateFromZip(String zipCode) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      ApiEndPoints.forgotPin,
      {
      },
      false,
     // fullUrl: "https://api.zippopotam.us/us/$zipCode",
     fullUrl: "https://maps.googleapis.com/maps/api/geocode/json?address=${zipCode.trim()}&sensor=true&key=AIzaSyAoGNPQPcGQ_qhl6GFQNFv8OrM3sm3A7vQ",
      Get.context,
    );
    return data;
  }
  
  Future getProjectTypes() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      ApiEndPoints.getProjectTypes,
      {
      },
      false,
      Get.context,
    );
    return data;
  }
  
  Future getRetailers() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      ApiEndPoints.getRetailers,
      {
      },
      false,
      Get.context,
    );
    return data;
  }
  
  Future compareRetailers(Map<String,dynamic> body, int id) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.compareRetailers + '?project=$id',
      body,
      true,
      Get.context,
    );
    return data;
  }

  Future startProject(Map<String,dynamic> body) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.startProject,
      body,
      true,
      Get.context,
    );
    return data;
  }

  Future updateStep(Map<String,dynamic> body) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.updateStep,
      body,
      true,
      Get.context,
    );
    return data;
  }

  Future toggleFavorite(int projectId) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      "${ApiEndPoints.toggleFavorite}",
      {"project_id":projectId},
      true,
      Get.context,
    );
    return data;
  }
  
  Future saveForLater(int projectId) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      "${ApiEndPoints.saveForLater}?project=$projectId",
      {},
      true,
      Get.context,
    );
    return data;
  }
}