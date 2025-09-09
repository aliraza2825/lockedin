import 'package:get/get.dart';
import 'package:medical_courier/presentation/select_language/controllers/select_language_controller.dart';


class SelectLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectLanguageController>(
      () => SelectLanguageController(),
    );
  }
}
