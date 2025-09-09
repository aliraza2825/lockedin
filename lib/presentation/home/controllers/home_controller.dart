import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_courier/app/config/global_var.dart';
import 'package:medical_courier/app/config/local_keys.dart';
import 'package:medical_courier/data/Services/location_service.dart';
import 'package:medical_courier/data/models/full_order.dart';
import 'package:medical_courier/data/models/order.dart';
import 'package:medical_courier/data/models/user_profile.dart';
import 'package:medical_courier/data/provider/local_storage/local_db.dart';
import 'package:medical_courier/data/repositories/dashboard_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medical_courier/presentation/profile/controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/routes/app_pages.dart';
import '../../../app/utils/utils.dart';

class HomeController extends GetxController {
  final DashboardRepository _repository = DashboardRepository();
  bool isLoading = false;
  List<Order> orders = [];
  List<Order> pendingOrders = [];
  late UserProfile userProfile;
  late int userStatus = 2;
  ScrollController scrollController = ScrollController();
  late Position position;
  var alreadystartedOrder = 0;
  Order ongoingOrder = Order();


  @override
  Future<void> onInit() async {
    _getCurrentUserLocationAndFetchOrders();
    if (await LocalDB.hasData(LocalDataKey.startedOrder.name)) {
      final data = await LocalDB.getData(LocalDataKey.startedOrder.name);
      alreadystartedOrder = int.tryParse(data.toString()) ?? 0;
      checkOrderStatus(alreadystartedOrder);
    }
    super.onInit();
    update();
    updateLocationService();
  }

  updateUserStatus(int status) {
    userStatus = status;
    updateLocationService();
    update();
  }

  Future<void> changeStatus() async {
    try {
      isLoading = true;
      update();
      final response =
          await _repository.changeAvailabilityStatus(userStatus == 1 ? 2 : 1);
      if (response != null && response['status'] == true) {
        LocalDB.setData(LocalDataKey.userStatus.name, userStatus == 1 ? 2 : 1);
        userStatus = userStatus == 1 ? 2 : 1;
        Utils.showToast(message: response['message']);
        updateLocationService();
        isLoading = false;
        update();
      } else {
        isLoading = false;
        Utils.showToast(message: response['message']);
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } catch (e) {
      isLoading = false;
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
    }
  }

  /// ✅ FINAL GET ORDERS WITH DISTANCE
  Future<void> getNewOrders() async {
    try {
      isLoading = true;
      update();

    
      Globals.latitude = position.latitude;
      Globals.longitude = position.longitude;

      // Step 2: Fetch orders
      final response = await _repository.getNewOrders(1,1);

      if (response != null && response['status'] == true && response['data'] != null) {
        List<Order> fetchedOrders =
            response['data']['records'].map<Order>((e) => Order.fromJson(e)).toList();

        for (var order in fetchedOrders) {
          final addressParts = [
            order.specimenPickupAddress,
            order.specimenPickupCity,
            order.specimenPickupState,
            order.specimenPickupZip,
          ];

          final fullAddress =
              addressParts.where((e) => e != null && e.isNotEmpty).join(', ');

          final pickupCoords = await getCoordinatesFromAddress(fullAddress);
          if (pickupCoords != null) {
            order.pickupLatitude = pickupCoords.latitude;
            order.pickupLongitude = pickupCoords.longitude;

            order.distanceInKm = Geolocator.distanceBetween(
                    Globals.latitude,
                    Globals.longitude,
                    pickupCoords.latitude,
                    pickupCoords.longitude) /
                1000;
          } else {
            order.distanceInKm = null;
          }
        }

        orders = fetchedOrders;
        isLoading = false;
        update();
      } else {
        if(response['status'] == true){
          orders = [];
        }
        isLoading = false;
        update();
        Utils.showToast(message: response['message']);
      }
    } catch (e) {
      isLoading = false;
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
      log('getNewOrders error: $e');
    }
  }

  /// ✅ Geocoding from backend
  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    final jsonRes = await _repository.getCoordinatesFromAddress(address);
    if (jsonRes['status'] == 'OK') {
      final loc = jsonRes['results'][0]['geometry']['location'];
      return LatLng(loc['lat'], loc['lng']);
    } else {
      return null;
    }
  }

  Future<void> changeOrderStatus(int status, int orderId,int index) async {
    try {
      isLoading = true;
      update();
      final response =
          await _repository.changeOrderStatus(status, orderId);
      if (response != null && response['status'] == true) {
        Utils.showToast(message: response['message']);
        isLoading = false;
        if(status == 2){
          pendingOrders.add(orders[index]);
        }
        orders.removeAt(index);
        
        update();
      } else {
        isLoading = false;
        Utils.showToast(message: response['message']);
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } catch (e) {
      isLoading = false;
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
    }
  }

  /// ✅ FINAL GET ORDERS WITH DISTANCE
  Future<void> getPendingOrders() async {
    try {
      isLoading = true;
      update();

      Globals.latitude = position.latitude;
      Globals.longitude = position.longitude;

      // Step 2: Fetch orders
      final response = await _repository.getNewOrders(1,2);

      if (response != null && response['status'] == true && response['data'] != null) {
        List<Order> fetchedOrders =
            response['data']['records'].map<Order>((e) => Order.fromJson(e)).toList();

        for (var order in fetchedOrders) {
          final addressParts = [
            order.specimenPickupAddress,
            order.specimenPickupCity,
            order.specimenPickupState,
            order.specimenPickupZip,
          ];

          final fullAddress =
              addressParts.where((e) => e != null && e.isNotEmpty).join(', ');

          final pickupCoords = await getCoordinatesFromAddress(fullAddress);
          if (pickupCoords != null) {
            order.pickupLatitude = pickupCoords.latitude;
            order.pickupLongitude = pickupCoords.longitude;

            order.distanceInKm = Geolocator.distanceBetween(
                    Globals.latitude,
                    Globals.longitude,
                    pickupCoords.latitude,
                    pickupCoords.longitude) /
                1000;
          } else {
            order.distanceInKm = null;
          }

          if(alreadystartedOrder > 0 && order.orderId == alreadystartedOrder){
            ongoingOrder = order;
          }
        }

        pendingOrders = fetchedOrders;
        
        isLoading = false;
        update();
      } else {
        if(response['status'] == true){
          pendingOrders = [];
        }
        isLoading = false;
        update();
        Utils.showToast(message: response['message']);
      }
      getNewOrders();
    } catch (e) {
      isLoading = false;
      Utils.showToast(message: "Something went wrong. Please try again.".tr);
      log('getNewOrders error: $e');
    }
  }
  
  void updateLocationService() {
    final locationService = Get.find<LocationService>();

    // Always stop first to prevent duplicate tracking
    locationService.stop();

    if (userStatus == 1) {
      // Only start if user is available/online
      locationService.start();
    }
  }

  Future<void> _getCurrentUserLocationAndFetchOrders() async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      // ✅ THIS gets triggered *after* user taps Allow/Deny
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        // 🚀 User allowed — now fetch orders
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          ),
        );
        await getPendingOrders(); // Your API or logic here
        return;
      } else {
        // ❌ User denied
        Utils.showToast(message: "Permission denied after request.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        // 🚀 User allowed — now fetch orders
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          ),
        );
        await getPendingOrders(); // Your API or logic here
        return;
      }

  } catch (e) {
    Utils.showToast(message: "Something went wrong. Please try again.");
  }
}

  Future<void> checkOrderStatus(int order_id) async {
    try {
      final response = await _repository.getOrderDetail(order_id);
      FullOrder fullOrder = FullOrder.fromJson(response['data']);
      if(fullOrder.orderStatus == 3 || fullOrder.incompleteOrderStatus != null){
        final prefs = await SharedPreferences.getInstance();
          await prefs.remove(LocalDataKey.startedOrder.name);
          alreadystartedOrder = 0;
          ongoingOrder = Order();
          update();
      }
    } catch (e) {
      log("❌ Fetch order details failed: $e");
    } finally { 
      isLoading = false;
      update();
    }
  }
}