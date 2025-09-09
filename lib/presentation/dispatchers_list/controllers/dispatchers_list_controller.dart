import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_courier/app/utils/utils.dart';
import 'package:medical_courier/data/models/dispatcher.dart';
import 'package:medical_courier/data/repositories/dashboard_repository.dart';

class DispatchersListController extends GetxController
    with GetSingleTickerProviderStateMixin {

  
  final DashboardRepository _repository = DashboardRepository();
  bool isLoading = false;
  late List<Dispatcher> dispatchers = [];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDispatchers();
    });
  }

  /// ✅ FINAL GET ORDERS WITH DISTANCE
  Future<void> getDispatchers() async {
    try {
      isLoading = true;
      update();

      final response = await _repository.getDispatchers();

      if (response != null && response['status'] == true && response['data'] != null) {
        dispatchers =
            response['data']['records'].map<Dispatcher>((e) => Dispatcher.fromJson(e)).toList();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        Utils.showToast(message: response['message']);
      }
    } catch (e) {
      isLoading = false;
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
      log('getDispatchers error: $e');
    }
  }


}
