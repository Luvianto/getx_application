import 'package:get/get.dart';
import 'package:getx_application/bindings/create/alumni_create_binding.dart';
import 'package:getx_application/bindings/create/company_create_binding.dart';
import 'package:getx_application/bindings/create/training_create_binding.dart';
import 'package:getx_application/bindings/create/university_create_binding.dart';
import 'package:getx_application/bindings/layout_binding.dart';
import 'package:getx_application/bindings/auth/signin_binding.dart';
import 'package:getx_application/bindings/auth/signup_binding.dart';
import 'package:getx_application/layout.dart';
import 'package:getx_application/pages/auth/register_alumni_screen.dart';
import 'package:getx_application/pages/auth/register_company_screen.dart';
import 'package:getx_application/pages/auth/register_lembaga_screen.dart';
import 'package:getx_application/pages/auth/register_university_screen.dart';
import 'package:getx_application/pages/auth/sign_in_screen.dart';
import 'package:getx_application/pages/auth/sign_up_screen.dart';
part 'app_routes.dart';

class AppPages {
  static final routes = {
    Routes.LAYOUT: {
      'page': () => const LayoutPage(),
      'binding': LayoutBinding(),
    },
    Routes.SIGNIN: {
      'page': () => const SignInScreen(),
      'binding': SigninBinding(),
    },
    Routes.SIGNUP: {
      'page': () => SignUpScreen(),
      'binding': SignupBinding(),
    },
    Routes.ALUMNI + Routes.SIGNUP: {
      'page': () => const RegisterAlumniScreen(),
      'binding': AlumniCreateBinding(),
    },
    Routes.UNIVERSITY + Routes.SIGNUP: {
      'page': () => const RegisterUniversityScreen(),
      'binding': UniversityCreateBinding(),
    },
    Routes.COMPANY + Routes.SIGNUP: {
      'page': () => const RegisterCompanyScreen(),
      'binding': CompanyCreateBinding(),
    },
    Routes.TRAINING + Routes.SIGNUP: {
      'page': () => const RegisterLembagaScreen(),
      'binding': TrainingCreateBinding(),
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
