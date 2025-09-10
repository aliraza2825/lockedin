import 'package:get/get.dart';

class WelcomeController extends GetxController {

RxBool pinVerified=true.obs;

List<String> wImages=[
   'w2',
   'w3',
   'w4'
 ];
  @override
  void onInit() {
    if(Get.arguments!=null) {
      pinVerified.value = Get.arguments;
    }
    super.onInit();

  }
}
