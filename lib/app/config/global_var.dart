import 'package:medical_courier/data/models/full_order.dart';
import 'package:medical_courier/data/models/order.dart';

class Globals {
  static String authToken = "";
  static String phoneNumber = "";
  static int userId = 0;
  static String? email;
  static String fcmToken = "";
  static String fullName = "";
  static String? deviceId;
  static String? deviceName;
  static String? loginDevice;
  static String? language;
  static String? appVersion;
  static String? buildNumber;
  static String dummyImage =
      'https://ipsf.net/wp-content/uploads/2021/12/dummy-image-square.webp';
  static double latitude = 0.0;
  static double longitude = 0.0;
  static FullOrder? startedOrder;
}
