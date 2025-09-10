import 'package:get/get.dart';

import '../controllers/dispatchers_list_controller.dart';

class DispatchersListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DispatchersListController>(
      () => DispatchersListController(),
    );
  }
}
