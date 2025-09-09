import 'dart:developer';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_courier/app/config/global_var.dart';
import 'package:medical_courier/app/config/local_keys.dart';
import 'package:medical_courier/data/models/full_order.dart';
import 'package:medical_courier/data/models/order.dart';
import 'package:medical_courier/data/provider/local_storage/local_db.dart';
import 'package:medical_courier/data/repositories/dashboard_repository.dart';
import 'package:medical_courier/presentation/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationMapController extends GetxController {
  late Order order;
  FullOrder? fullOrder;

  final DashboardRepository _repository = DashboardRepository();
  final Completer<GoogleMapController> mapController = Completer();

  bool isLoading = true;
  var alreadystartedOrder = 0;
  XFile? image1;
  XFile? image2;

  @override
  Future<void> onInit() async {
    order = Get.arguments;

    if (await LocalDB.hasData(LocalDataKey.startedOrder.name)) {
      final data = await LocalDB.getData(LocalDataKey.startedOrder.name);
      alreadystartedOrder = int.tryParse(data.toString()) ?? 0;
    }
    super.onInit();
    Future.delayed(Duration.zero, fetchOrderDetails);
  }

  Future<void> fetchOrderDetails() async {
    try {
      final response = await _repository.getOrderDetail(order.orderId!);
      fullOrder = FullOrder.fromJson(response['data']);
      update();
    } catch (e) {
      log("❌ Fetch order details failed: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> updateLocation(FullOrder order,{XFile? image1,XFile? image2,Uint8List? signature}) async {
    try {
      Globals.startedOrder = order;
      LocalDB.setData(LocalDataKey.startedOrder.name, order.orderId.toString());
      Get.find<HomeController>().alreadystartedOrder = order.orderId!;
      Get.find<HomeController>().ongoingOrder = this.order;
      var status = order.orderTechnicianLocation == null
          ? 1
          : order.orderTechnicianLocation!.orderTrackingStatus! + 1;
      final response = await _repository.updateOrderLocation(
        order.orderId!,
        Globals.latitude,
        Globals.longitude,
        status,
        image1:image1,
        image2:image2,
        signature:signature,
      );
      if (response['status'] == true) {
        if(status == 5){
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove(LocalDataKey.startedOrder.name);
          Get.find<HomeController>().alreadystartedOrder = 0;
          Get.find<HomeController>().ongoingOrder = Order();
          Get.find<HomeController>().update();
        }
        
        await fetchOrderDetails();
        update();
      }
      log('📤 Server response: $response');
      return true;
    } catch (e) {
      log("❌ Send location error: $e");
      return false;
    }
  }
}