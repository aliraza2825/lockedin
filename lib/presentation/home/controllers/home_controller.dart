import 'package:locked_in/app/routes/app_pages.dart';
import 'package:locked_in/data/repositories/dashboard_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final DashboardRepository _repository = DashboardRepository();
  bool isLoading = false;

  String? partnerName;
  String? partnerAvatarUrl;


  @override
  Future<void> onInit() async {
    super.onInit();
    update();
  }
void onTapToVerify() {
    Get.toNamed(Routes.VERIFY_NFC);
  }

  void onEditStatus() {
    // TODO: navigate to edit screen
  }
}