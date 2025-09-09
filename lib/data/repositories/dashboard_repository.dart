import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_courier/app/config/global_var.dart';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as m;
import '../provider/network/api_endpoint.dart';
import '../provider/network/api_provider.dart';

class DashboardRepository {
  late APIProvider apiClient;

  DashboardRepository() {
    apiClient = APIProvider();
  }

  Future getCategorizedTools() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      ApiEndPoints.getCategorizedTools,
      {},
      false,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future getFeaturedTools() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      ApiEndPoints.getFeaturedTools,
      {},
      false,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future getInspirations() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      ApiEndPoints.getInspirations,
      {},
      true,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future getNewOrders(int page,int status) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      "${ApiEndPoints.getNewOrders}?userId=${Globals.userId}&OrderAssignStatus=$status&PageNumber=$page&PageSize=25",
      {},
      true,
      loading: true,
      Get.context,
    );

    return data;
  }
  Future getCompletedOrders(int page,int status) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      "${ApiEndPoints.getCompletedOrders}?userId=${Globals.userId}&OrderStatus=$status&PageNumber=$page&PageSize=25",
      {},
      true,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future getDispatchers() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      ApiEndPoints.getDispatchers,
      {},
      true,
      loading: true,
      Get.context,
    );

    return data;
  }


  Future getOrderDetail(int orderId) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      "${ApiEndPoints.getOrderDetail}?orderId=$orderId",
      {},
      true,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future changeOrderStatus(int status, int orderId) async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.changeOrderStatus,
      {
        "orderId": orderId,
        "userId": Globals.userId,
        "orderAssignStatus": status
      },
      true,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future updateOrderLocation(int orderId,double latitude,double longitude, int status,{XFile? image1,XFile? image2,Uint8List? signature}) async {
    Map<String, m.MultipartFile> files = {};
    if (image1 != null) {
      files["ProveImage1"] = await m.MultipartFile.fromFile(
        image1.path,
        filename: image1.name,
        contentType: m.DioMediaType('image', image1.name.split('.').last),
      );
    }

    // ✅ image2 from XFile
    if (image2 != null) {
      files["ProveImage2"] = await m.MultipartFile.fromFile(
        image2.path,
        filename: image2.name,
        contentType: m.DioMediaType('image', image2.name.split('.').last),
      );
    }

    if (signature != null && signature.isNotEmpty) {  
      files["ImageSignature"] = m.MultipartFile.fromBytes(
        signature,
        filename: "signature.png",
        contentType: m.DioMediaType('image', 'png'),
      );
    }

    Map<String, dynamic>? data = await apiClient.ordersBasePostAPI(
      ApiEndPoints.orderUpdateLocation,
      {
        "orderTechnicianLocationId": 0,
        "userId": Globals.userId,
        "orderId": orderId,
        "address": "string",
        "latitude": latitude,
        "longitude": longitude,
        "orderTrackingStatus": status
      },
      true,
      Get.context,
      files: files.isNotEmpty ? files : null,
      loading: true
    );

    return data;
  }

  Future getCoordinatesFromAddress(String address) async {
    final apiKey = 'AIzaSyAtABuYQtp8Yco-fJT_oRE4KOdnA-h80sA';
    final encoded = Uri.encodeComponent(address);
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$encoded&key=$apiKey';
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      url,
      fullUrl: url,
      {},
      false,
      Get.context,
    );

    return data;
  }

  Future getProjects(
      {int? page,
      int? type,
      int? category,
      int? style,
      int? subCategory,
      String? zip,
      String? state,
      int? budget,
      bool? auth}
      ) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      "${ApiEndPoints.getProjects}?page=${page ?? 1}&page_size=5&type_id=$type&category_id=$category${subCategory != null ? "&subcategory_id=$subCategory" : ""}${style != null ? "&style_id=$style" : ""}${zip != null ? "&zip=$zip" : ""}${state != null ? "&state=$state" : ""}${budget != null ? "&budget=$budget" : ""}",
      // "${ApiEndPoints.getProjects}?type_id=$type",
      {},
      auth,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future getProjectsByStrings(
      {String? page,
      String? type,
      String? category,
      String? style,
      String? subCategory,
      String? zip,
      String? state,
      String? budget}) async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      // "${ApiEndPoints.searchProjects}?page=${page ?? 1}&page_size=5&type_id=$type&category_id=$category&subcategory_id=$subCategory${style != null ? "&style_id=$style" : ""}${zip != null ? "&zip=$zip" : ""}${state != null ? "&state=$state" : ""}${budget != null ? "&budget=$budget" : ""}",
      "${ApiEndPoints.searchProjects}?query=$type $category $subCategory $style"
          .replaceAll(" ", "%20")
          .replaceAll("&", "%26"),
      {},
      true,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future getUserProfile(int id) async {
    Map<String, dynamic>? data =
        await apiClient.baseGetAPI("${ApiEndPoints.profile}/$id", {}, true, Get.context);
    print(data);
    return data;
  }

  Future changeAvailabilityStatus(int status) async {
    Map<String, dynamic>? data =
        await apiClient.basePostAPI(ApiEndPoints.availablityStatus, { "availabilityStatus": status ,"userId": Globals.userId},loading: true, true, Get.context);
    print(data);
    return data;
  }

  Future sendLocation(Map<String, dynamic> locationData) async {
    Map<String, dynamic>? data = 
        await apiClient.basePostAPI(ApiEndPoints.sendLocation, locationData,true, Get.context);
    return data;
  }

  Future getVisionBoards() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        ApiEndPoints.visionBoards, {}, true, Get.context);
    print(data);
    return data;
  }

  Future getDashboardStatus() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        ApiEndPoints.dashboard, {}, true, Get.context);
    print(data);
    return data;
  }

  Future getUserProjects() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        ApiEndPoints.allProjects, {}, true, Get.context);
    print(data);
    return data;
  }

  Future getHistory() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
        ApiEndPoints.searchHistory, {}, true, Get.context);
    print(data);
    return data;
  }
}
