import 'package:medical_courier/presentation/navigation_map/controllers/navigation_map_controller.dart';
import 'package:get/get.dart';


class NavigationMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationMapController>(
      () => NavigationMapController(),
    );
  }
}
