import 'package:get/get.dart';
import 'package:locked_in/presentation/account_setting/bindings/account_setting_binding.dart';
import 'package:locked_in/presentation/account_setting/views/account_setting_view.dart';
import 'package:locked_in/presentation/change_language/bindings/change_language_binding.dart';
import 'package:locked_in/presentation/change_language/views/change_language_view.dart';
import 'package:locked_in/presentation/change_pin/bindings/change_pin_binding.dart';
import 'package:locked_in/presentation/change_pin/views/change_pin_view.dart';
import 'package:locked_in/presentation/chat/bindings/chat_binding.dart';
import 'package:locked_in/presentation/chat/bindings/chat_room_binding.dart';
import 'package:locked_in/presentation/chat/views/chat_view.dart';
import 'package:locked_in/presentation/chat/views/chat_room_view.dart';
import 'package:locked_in/presentation/contact_us/bindings/contact_us_binding.dart';
import 'package:locked_in/presentation/contact_us/views/contact_us_view.dart';
import 'package:locked_in/presentation/dispatchers_list/bindings/dispatchers_list.dart';
import 'package:locked_in/presentation/dispatchers_list/views/dispatchers_list_view.dart';
import 'package:locked_in/presentation/forget_password/bindings/forget_password_binding.dart';
import 'package:locked_in/presentation/forget_password/views/forget_password_view.dart';
import 'package:locked_in/presentation/home/bindings/home_binding.dart';
import 'package:locked_in/presentation/home/views/home_view.dart';
import 'package:locked_in/presentation/navbar/bindings/navbar_binding.dart';
import 'package:locked_in/presentation/navbar/views/navbar_view.dart';
import 'package:locked_in/presentation/order_details/bindings/order_details_binding.dart';
import 'package:locked_in/presentation/order_details/views/order_details_view.dart';
import 'package:locked_in/presentation/otp/bindings/otp_binding.dart';
import 'package:locked_in/presentation/otp/views/otp_view.dart';
import 'package:locked_in/presentation/personal_info/bindings/personal_info_binding.dart';
import 'package:locked_in/presentation/personal_info/views/personal_info_view.dart';
import 'package:locked_in/presentation/profile/bindings/profile_binding.dart';
import 'package:locked_in/presentation/profile/views/profile_view.dart';
import 'package:locked_in/presentation/select_language/bindings/select_language_binding.dart';
import 'package:locked_in/presentation/select_language/views/select_language_view.dart';
import 'package:locked_in/presentation/signIn_with_pin/bindings/signin_with_pin_binding.dart';
import 'package:locked_in/presentation/signIn_with_pin/views/signin_with_pin_view.dart';
import 'package:locked_in/presentation/signup_with_email/bindings/signup_binding.dart';
import 'package:locked_in/presentation/signup_with_email/views/signup_view.dart';
import 'package:locked_in/presentation/splash/bindings/splash_binding.dart';
import 'package:locked_in/presentation/splash/views/splash_view.dart';
import 'package:locked_in/presentation/tools_and_tutorials/bindings/tools_and_tutorials_binding.dart';
import 'package:locked_in/presentation/tools_and_tutorials/views/tools_and_tutorials_view.dart';
import 'package:locked_in/presentation/update_pin/bindings/update_pin_binding.dart';
import 'package:locked_in/presentation/update_pin/views/update_pin_view.dart';
import 'package:locked_in/presentation/verify_through_nfc/bindings/verify_nfc_binding.dart';
import 'package:locked_in/presentation/verify_through_nfc/views/verify_nfc_view.dart';
import 'package:locked_in/presentation/welcome/bindings/welcome_binding.dart';
import 'package:locked_in/presentation/welcome/views/welcome_view.dart';
import 'package:locked_in/presentation/onboarding/bindings/onboarding_binding.dart';
import 'package:locked_in/presentation/onboarding/views/onboarding_view.dart';

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
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => const PersonalInfoView(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
      transition: Transition.fadeIn, // Custom transition
      transitionDuration: const Duration(milliseconds: 300),
    ),
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
    GetPage(
      name: _Paths.VERIFY_NFC,
      page: () => VerifyPromptView(),
      binding: VerifyNfcBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
