import 'package:get/get.dart';

import '../controllers/signIn_with_pin_controller.dart';

class SigninWithPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInWithPinController>(
      () => SignInWithPinController(),
    );
  }
}
