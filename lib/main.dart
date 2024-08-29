import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:getx_application/routes/app_pages.dart';
import 'package:getx_application/firebase_options.dart';
import 'package:getx_application/theme/light_theme.dart';

void main() async {
  // Initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Load env
  await dotenv.load(fileName: ".env");

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SIGNIN,
      theme: lightTheme,
      defaultTransition: Transition.cupertino,
      getPages: AppPages.pages,
    ),
  );
}
