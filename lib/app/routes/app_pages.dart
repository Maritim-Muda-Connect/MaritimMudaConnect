import 'package:get/get.dart';

import '../data/models/category_data.dart';
import '../modules/analytics/bindings/analytics_binding.dart';
import '../modules/analytics/views/analytics_view.dart';
import '../modules/auth/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/auth/forgot_password/views/forgot_password_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/auth/splash/bindings/splash_binding.dart';
import '../modules/auth/splash/views/splash_view.dart';
import '../modules/catalog/all_catalog/bindings/all_catalog_binding.dart';
import '../modules/catalog/all_catalog/views/all_catalog_view.dart';
import '../modules/catalog/bindings/catalog_binding.dart';
import '../modules/catalog/detail_catalog/bindings/detail_catalog_binding.dart';
import '../modules/catalog/detail_catalog/views/detail_catalog_view.dart';
import '../modules/catalog/sub_catalog/bindings/sub_catalog_binding.dart';
import '../modules/catalog/sub_catalog/views/sub_catalog_view.dart';
import '../modules/catalog/views/catalog_view.dart';
import '../modules/e_kta/bindings/e_kta_binding.dart';
import '../modules/e_kta/views/e_kta_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/event/bindings/event_binding.dart';
import '../modules/home/event/views/event_view.dart';
import '../modules/home/job/bindings/job_binding.dart';
import '../modules/home/job/views/job_view.dart';
import '../modules/home/member/bindings/member_binding.dart';
import '../modules/home/member/views/member_view.dart';
import '../modules/home/scholarship/bindings/scholarship_binding.dart';
import '../modules/home/scholarship/views/scholarship_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/navbar/bindings/main_binding.dart';
import '../modules/navbar/views/main_view.dart';
import '../modules/profile/achievement/bindings/achievement_binding.dart';
import '../modules/profile/achievement/views/achievement_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/educations/bindings/educations_binding.dart';
import '../modules/profile/educations/views/educations_view.dart';
import '../modules/profile/organizations/bindings/organizations_binding.dart';
import '../modules/profile/organizations/views/organizations_view.dart';
import '../modules/profile/profile_user/bindings/profile_user_binding.dart';
import '../modules/profile/profile_user/views/profile_user_view.dart';
import '../modules/profile/publication/bindings/publication_binding.dart';
import '../modules/profile/publication/views/publication_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/work_experiences/bindings/work_experiences_binding.dart';
import '../modules/profile/work_experiences/views/work_experiences_view.dart';

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
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    // GetPage(
    //   name: _Paths.MAIN_DRAWER,
    //   page: () => const MainDrawerView(),
    //   binding: MainDrawerBinding(),
    // ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MEMBER,
      page: () => const MemberView(),
      binding: MemberBinding(),
    ),
    GetPage(
      name: _Paths.ACHIEVEMENT,
      page: () => const AchievementView(),
      binding: AchievementBinding(),
    ),
    GetPage(
      name: _Paths.PUBLICATION,
      page: () => const PublicationView(),
      binding: PublicationBinding(),
    ),
    GetPage(
      name: _Paths.EVENT,
      page: () => EventView(categoryList),
      binding: EventBinding(),
    ),
    GetPage(
      name: _Paths.SCHOLARSHIP,
      page: () => const ScholarshipView(),
      binding: ScholarshipBinding(),
    ),

    GetPage(
      name: _Paths.JOB,
      page: () => const JobView(),
      binding: JobBinding(),
    ),
    GetPage(
      name: _Paths.E_KTA,
      page: () => EKtaView(),
      binding: EKtaBinding(),
    ),
    GetPage(
      name: _Paths.EDUCATIONS,
      page: () => const EducationsView(),
      binding: EducationsBinding(),
    ),
    GetPage(
      name: _Paths.WORK_EXPERIENCES,
      page: () => WorkExperiencesView(),
      binding: WorkExperiencesBinding(),
    ),
    GetPage(
      name: _Paths.ORGANIZATIONS,
      page: () => OrganizationsView(),
      binding: OrganizationsBinding(),
    ),
    GetPage(
      name: _Paths.ANALYTICS,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: _Paths.CATALOG,
      page: () => const CatalogView(),
      binding: CatalogBinding(),
    ),
    GetPage(
      name: _Paths.ALL_CATALOG,
      page: () => const AllCatalogView(),
      binding: AllCatalogBinding(),
    ),
    GetPage(
      name: _Paths.SUB_CATALOG,
      page: () => const SubCatalogView(),
      binding: SubCatalogBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CATALOG,
      page: () => const DetailCatalogView(),
      binding: DetailCatalogBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_USER,
      page: () => const ProfileUserView(),
      binding: ProfileUserBinding(),
    ),
  ];
}
