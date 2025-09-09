import 'package:get/get.dart';
import 'package:medical_courier/presentation/account_setting/bindings/account_setting_binding.dart';
import 'package:medical_courier/presentation/account_setting/views/account_setting_view.dart';
import 'package:medical_courier/presentation/change_language/bindings/change_language_binding.dart';
import 'package:medical_courier/presentation/change_language/views/change_language_view.dart';
import 'package:medical_courier/presentation/change_pin/bindings/change_pin_binding.dart';
import 'package:medical_courier/presentation/change_pin/views/change_pin_view.dart';
import 'package:medical_courier/presentation/chat/bindings/chat_binding.dart';
import 'package:medical_courier/presentation/chat/bindings/chat_room_binding.dart';
import 'package:medical_courier/presentation/chat/views/chat_view.dart';
import 'package:medical_courier/presentation/chat/views/chat_room_view.dart';
import 'package:medical_courier/presentation/contact_us/bindings/contact_us_binding.dart';
import 'package:medical_courier/presentation/contact_us/views/contact_us_view.dart';
import 'package:medical_courier/presentation/dispatchers_list/bindings/dispatchers_list.dart';
import 'package:medical_courier/presentation/dispatchers_list/views/dispatchers_list_view.dart';
import 'package:medical_courier/presentation/forget_password/bindings/forget_password_binding.dart';
import 'package:medical_courier/presentation/forget_password/views/forget_password_view.dart';
import 'package:medical_courier/presentation/home/bindings/home_binding.dart';
import 'package:medical_courier/presentation/home/views/home_view.dart';
import 'package:medical_courier/presentation/navbar/bindings/navbar_binding.dart';
import 'package:medical_courier/presentation/navbar/views/navbar_view.dart';
import 'package:medical_courier/presentation/navigation_map/bindings/navigation_map_binding.dart';
import 'package:medical_courier/presentation/navigation_map/views/navigation_map_view.dart';
import 'package:medical_courier/presentation/order_details/bindings/order_details_binding.dart';
import 'package:medical_courier/presentation/order_details/views/order_details_view.dart';
import 'package:medical_courier/presentation/otp/bindings/otp_binding.dart';
import 'package:medical_courier/presentation/otp/views/otp_view.dart';
import 'package:medical_courier/presentation/profile/bindings/profile_binding.dart';
import 'package:medical_courier/presentation/profile/views/profile_view.dart';
import 'package:medical_courier/presentation/select_language/bindings/select_language_binding.dart';
import 'package:medical_courier/presentation/select_language/views/select_language_view.dart';
import 'package:medical_courier/presentation/signIn_with_pin/bindings/signin_with_pin_binding.dart';
import 'package:medical_courier/presentation/signIn_with_pin/views/signin_with_pin_view.dart';
import 'package:medical_courier/presentation/splash/bindings/splash_binding.dart';
import 'package:medical_courier/presentation/splash/views/splash_view.dart';
import 'package:medical_courier/presentation/tools_and_tutorials/bindings/tools_and_tutorials_binding.dart';
import 'package:medical_courier/presentation/tools_and_tutorials/views/tools_and_tutorials_view.dart';
import 'package:medical_courier/presentation/update_pin/bindings/update_pin_binding.dart';
import 'package:medical_courier/presentation/update_pin/views/update_pin_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
      transition: Transition.fadeIn, // Custom transition
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: _Paths.SIGNIN_WITH_PIN,
      page: () => const SigninWithPinView(),
      binding: SigninWithPinBinding(),
      transition: Transition.fadeIn, // Custom transition
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
      transition: Transition.fadeIn, // Custom transition
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // GetPage(
    //   name: _Paths.MY_DASHBOARD,
    //   page: () => const MyDashboardView(),
    //   binding: MyDashboardBinding(),
    //   transition: Transition.fadeIn, // Custom transition
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    // GetPage(
    //   name: _Paths.VISION_BOARD,
    //   page: () => const VisionBoardView(),
    //   binding: VisionBoardBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PROJECTS,
    //   page: () => const ProjectsView(),
    //   binding: ProjectsBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PROJECT_DETAIL,
    //   page: () => const ProjectDetailView(),
    //   binding: ProjectDetailBinding(),
    // ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
    // GetPage(
    //   name: _Paths.NEW_PROJECT,
    //   page: () => const NewProjectView(),
    //   binding: NewProjectBinding(),
    // ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    // GetPage(
    //   name: _Paths.ACTIVITY,
    //   page: () => const ActivityView(),
    //   binding: ActivityBinding(),
    // ),
    // GetPage(
    //   name: _Paths.HISTORY,
    //   page: () => const HistoryView(),
    //   binding: HistoryBinding(),
    // ),
    GetPage(
      name: _Paths.ACCOUNT_SETTING,
      page: () => const AccountSettingView(),
      binding: AccountSettingBinding(),
    ),
    // GetPage(
    //   name: _Paths.NOTIFICATIONS,
    //   page: () => const NotificationsView(),
    //   binding: NotificationsBinding(),
    // ),
    // GetPage(
    //   name: _Paths.TOOL_AND_SUPPLY,
    //   page: () => const ToolAndSupplyView(),
    //   binding: ToolAndSupplyBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PURCHASES,
    //   page: () => const PurchasesView(),
    //   binding: PurchasesBinding(),
    // ),
    // GetPage(
    //   name: _Paths.SEARCH_RESULT,
    //   page: () => const SearchResultView(),
    //   binding: SearchResultBinding(),
    // ),
    // GetPage(
    //   name: _Paths.TOOLS_AND_SUPPLIES_LIST,
    //   page: () => const ToolsAndSuppliesListView(),
    //   binding: ToolsAndSuppliesListBinding(),
    // ),
    // GetPage(
    //   name: _Paths.VENDOR_LIST,
    //   page: () => const VendorListView(),
    //   binding: VendorListBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PROJECT_INDIVIDUAL,
    //   page: () => const ProjectIndividualView(),
    //   binding: ProjectIndividualBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ONBOARDING_SUMMARY,
    //   page: () => const OnboardingSummaryView(),
    //   binding: OnboardingSummaryBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PREFERENCES,
    //   page: () => const PreferencesView(),
    //   binding: PreferencesBinding(),
    // ),
    // GetPage(
    //   name: _Paths.SIGNUP_SUCCESS,
    //   page: () => const SignupSuccessView(),
    //   binding: SignupSuccessBinding(),
    //   transition: Transition.fadeIn, // Custom transition
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    GetPage(
      name: _Paths.CHANGE_PIN,
      page: () => const ChangePinView(),
      binding: ChangePinBinding(),
      transition: Transition.fadeIn, // Custom transition
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: _Paths.TOOLS_AND_TUTORIALS,
      page: () => const ToolsAndTutorialsView(),
      binding: ToolsAndTutorialsBinding(),
      transition: Transition.downToUp, // Custom transition
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // GetPage(
    //   name: _Paths.INDIVIDUAL_TOOL,
    //   page: () => const IndividualToolView(),
    //   binding: IndividualToolBinding(),
    //   transition: Transition.zoom, // Custom transition
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    GetPage(
      name: _Paths.SELECT_LANGUAGE,
      page: () => const SelectLanguageView(),
      binding: SelectLanguageBinding(),
    ),
    // GetPage(
    //   name: _Paths.END_USER_LICENSE,
    //   page: () => const EndUserLicenseView(),
    //   binding: EndUserLicenseBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PRIVACY_POLICY,
    //   page: () => const PrivacyPolicyView(),
    //   binding: PrivacyPolicyBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PROJECT_STATUS,
    //   page: () => const ProjectStatusView(),
    //   binding: ProjectStatusBinding(),
    // ),
    GetPage(
      name: _Paths.CHANGE_LANGUAGE,
      page: () => const ChangeLanguageView(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_MAP,
      page: () => NavigationMapView(),
      binding: NavigationMapBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(name: _Paths.CHAT, page: () => ChatView(), binding: ChatBinding()),
    GetPage(
      name: _Paths.CHAT_ROOM,
      page: () => const ChatRoomView(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PIN,
      page: () => UpdatePinView(),
      binding: UpdatePinBinding(),
    ),
    GetPage(
      name: _Paths.DISPATCHERS_LIST,
      page: () => DispatchersListView(),
      binding: DispatchersListBinding(),
    ),
  ];
}
