import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locked_in/app/config/global_var.dart';
import 'package:locked_in/app/config/local_keys.dart';
import 'package:locked_in/data/provider/local_storage/local_db.dart';
import 'package:locked_in/data/repositories/dashboard_repository.dart';

class LocationService {
  Timer? _timer;
  final DashboardRepository _repository = DashboardRepository();

  Future<void> start() async {
    try {
      if (Platform.isAndroid) {
        // ✅ Step 1: Initialize background execution (only Android)
        final androidConfig = const FlutterBackgroundAndroidConfig(
          notificationTitle: "Medical Courier",
          notificationText: "Tracking your location in background",
          notificationImportance: AndroidNotificationImportance.normal,
        );

        final initialized = await FlutterBackground.initialize(androidConfig: androidConfig);
        if (initialized) {
          await FlutterBackground.enableBackgroundExecution();
          if (kDebugMode) print('✅ Background execution enabled.');
        } else {
          throw Exception("Failed to initialize background execution.");
        }
      }

      // ✅ Step 2: Request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          throw Exception("Location permission not granted.");
        }
      }

      // ✅ Step 3: Start location updates every 30 seconds
      _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
        try {
          final position = await Geolocator.getCurrentPosition();
          final userId = await LocalDB.getData(LocalDataKey.userId.name);

          if (userId != null) {
            await _sendLocationToServer(position.latitude, position.longitude, userId);
            if (kDebugMode) {
              print('📍 Location sent: ${position.latitude}, ${position.longitude}');
            }
          }
        } catch (e) {
          if (kDebugMode) print("❌ Error fetching or sending location: $e");
        }
      });

      if (kDebugMode) print('🚀 Location service started.');
    } catch (e) {
      if (kDebugMode) print('🚫 Location service start error: $e');
    }
  }

  Future<void> stop() async {
    try {
      _timer?.cancel();
      _timer = null;

      if (Platform.isAndroid && FlutterBackground.isBackgroundExecutionEnabled) {
        await FlutterBackground.disableBackgroundExecution();
        if (kDebugMode) print('🛑 Background execution disabled.');
      }

      if (kDebugMode) print('🛑 Location service stopped.');
    } catch (e) {
      if (kDebugMode) print('❌ Error stopping location service: $e');
    }
  }

  Future<void> _sendLocationToServer(double latitude, double longitude, dynamic userId) async {
    try {
      Globals.latitude = latitude;
      Globals.longitude = longitude;
      final response = await _repository.sendLocation({
        "latitude": latitude,
        "longitude": longitude,
        "userId": userId,
      });
      log('📤 Server response: $response');
    } catch (e) {
      log("❌ Send location error: $e");
    }
  }
}