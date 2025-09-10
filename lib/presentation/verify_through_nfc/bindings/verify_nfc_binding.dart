import 'package:get/get.dart';
import '../controllers/verify_nfc_controller.dart';
class VerifyNfcBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyNfcController>(
      () => VerifyNfcController(),
    );
  }
}
