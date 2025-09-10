import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locked_in/app/utils/utils.dart';
import 'package:locked_in/data/models/order.dart';
import 'package:locked_in/data/repositories/dashboard_repository.dart';

class ToolsAndTutorialsController extends GetxController
    with GetSingleTickerProviderStateMixin {

  final DashboardRepository _repository = DashboardRepository();
  ScrollController scrollController = ScrollController();
  List<Order> orders = [];
  
  @override
  void onInit() {
    Future.delayed(Duration.zero, getPendingOrders);
    super.onInit();
  }

Future<void> getPendingOrders() async {
    try {
      final response = await _repository.getCompletedOrders(1,3);

      if (response != null && response['status'] == true && response['data'] != null) {
        orders =
            response['data']['records'].map<Order>((e) => Order.fromJson(e)).toList();

        update();
      } else {
        Utils.showToast(message: response['message']);
      }
    } catch (e) {
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
    }
  }

}
