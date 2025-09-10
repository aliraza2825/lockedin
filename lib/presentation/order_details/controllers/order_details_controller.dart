import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locked_in/data/models/full_order.dart';
import 'package:locked_in/data/models/order.dart';
import 'package:locked_in/data/repositories/dashboard_repository.dart';

class OrderDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  final DashboardRepository _repository = DashboardRepository();
  late FullOrder fullOrder = FullOrder();
  late Order order;
  bool isLoading = false;

  @override
  void onInit() {
    order = Get.arguments;
    Future.delayed(Duration.zero, fetchOrderDetails);
    super.onInit();
  }

  Future<void> fetchOrderDetails() async {
    try {
      final response = await _repository.getOrderDetail(order.orderId!);
      fullOrder = FullOrder.fromJson(response['data']);
    } catch (e) {
      log("❌ Fetch order details failed: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
