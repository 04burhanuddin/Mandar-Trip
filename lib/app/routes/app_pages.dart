import 'package:get/get.dart';
import 'package:mandar_trip/app/modules/direction_tour/views/direction_tour_view.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/add_editor/bindings/add_editor_binding.dart';
import '../modules/add_editor/views/add_editor_view.dart';
import '../modules/add_tour/bindings/add_tour_binding.dart';
import '../modules/add_tour/views/add_tour_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_tour/bindings/detail_tour_binding.dart';
import '../modules/detail_tour/views/detail_tour_view.dart';
import '../modules/direction_tour/views/direction_tour_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/edit_tour/bindings/edit_tour_binding.dart';
import '../modules/edit_tour/views/edit_tour_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/list_tour/bindings/list_tour_binding.dart';
import '../modules/list_tour/views/list_tour_view.dart';
import '../modules/list_user/bindings/list_user_binding.dart';
import '../modules/list_user/views/list_user_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EDITOR,
      page: () => AddEditorView(),
      binding: AddEditorBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TOUR,
      page: () => AddTourView(),
      binding: AddTourBinding(),
    ),
    GetPage(
      name: _Paths.LIST_TOUR,
      page: () => ListTourView(),
      binding: ListTourBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_TOUR,
      page: () => DetailTourView(),
      binding: DetailTourBinding(),
    ),
    GetPage(
      name: _Paths.DIRECTION_TOUR,
      page: () => const Direction(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.LIST_USER,
      page: () => ListUserView(),
      binding: ListUserBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_TOUR,
      page: () => EditTourView(),
      binding: EditTourBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
