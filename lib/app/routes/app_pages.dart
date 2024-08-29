import 'package:get/get.dart';
import 'package:getx_application/app/bindings/create/alumni_create_binding.dart';
import 'package:getx_application/app/bindings/create/company_create_binding.dart';
import 'package:getx_application/app/bindings/create/training_create_binding.dart';
import 'package:getx_application/app/bindings/create/university_create_binding.dart';
import 'package:getx_application/app/bindings/layout_binding.dart';
import 'package:getx_application/app/bindings/auth/signin_binding.dart';
import 'package:getx_application/app/bindings/auth/signup_binding.dart';
import 'package:getx_application/app/ui/android/activity/activity_page.dart';
import 'package:getx_application/app/ui/android/auth/select_role_page.dart';
import 'package:getx_application/app/ui/android/auth/signup_page.dart';
import 'package:getx_application/app/ui/android/create/alumni_create_page.dart';
import 'package:getx_application/app/ui/android/create/company_create_page.dart';
import 'package:getx_application/app/ui/android/create/training_create_page.dart';
import 'package:getx_application/app/ui/android/create/university_create_page.dart';
import 'package:getx_application/app/ui/android/error/error_page.dart';
import 'package:getx_application/app/ui/android/auth/signin_page.dart';
import 'package:getx_application/app/ui/android/layout/layout_page.dart';
import 'package:getx_application/app/ui/android/notification/notification_page.dart';
import 'package:getx_application/app/ui/android/search/search_page.dart';
import 'package:getx_application/app/ui/android/vacancy/vacancy_page.dart';
part './app_routes.dart';

class AppPages {
  static final routes = {
    Routes.ERROR: {
      'page': () => const ErrorPage(),
      'binding': LayoutBinding(),
    },
    Routes.LAYOUT: {
      'page': () => const LayoutPage(),
      'binding': LayoutBinding(),
    },
    Routes.SIGNIN: {
      'page': () => SigninPage(),
      'binding': SigninBinding(),
    },
    Routes.SIGNUP: {
      'page': () => SignupPage(),
      'binding': SignupBinding(),
    },
    Routes.SELECTROLE: {
      'page': () => SelectRolePage(),
      'binding': SignupBinding(),
    },
    Routes.ALUMNI + Routes.SIGNUP: {
      'page': () => const AlumniCreatePage(),
      'binding': AlumniCreateBinding(),
    },
    Routes.UNIVERSITY + Routes.SIGNUP: {
      'page': () => const UniversityCreatePage(),
      'binding': UniversityCreateBinding(),
    },
    Routes.COMPANY + Routes.SIGNUP: {
      'page': () => const CompanyCreatePage(),
      'binding': CompanyCreateBinding(),
    },
    Routes.TRAINING + Routes.SIGNUP: {
      'page': () => const TrainingCreatePage(),
      'binding': TrainingCreateBinding(),
    },
    Routes.ACTIVITY: {
      'page': () => const ActivityPage(),
      'binding': LayoutBinding(),
    },
    Routes.NOTIFICATION: {
      'page': () => const NotificationPage(),
      'binding': LayoutBinding(),
    },
    Routes.SEARCH: {
      'page': () => const SearchPage(),
      'binding': LayoutBinding(),
    },
    Routes.SETTING: {
      'page': () => const NotificationPage(),
      'binding': LayoutBinding(),
    },
    Routes.VACANCY: {
      'page': () => const VacancyPage(),
      'binding': LayoutBinding(),
    },
  };

  static final pages = routes.entries
      .map(
        (route) => GetPage(
          name: route.key,
          page: route.value['page'] as GetPageBuilder,
          binding: route.value['binding'] as Bindings,
        ),
      )
      .toList();
}
