import 'package:get/get.dart';

import '../controllers/tools_and_tutorials_controller.dart';

class ToolsAndTutorialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToolsAndTutorialsController>(
      () => ToolsAndTutorialsController(),
    );
  }
}
