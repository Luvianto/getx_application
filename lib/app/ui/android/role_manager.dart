import 'package:flutter/material.dart';
import 'package:getx_application/app/ui/android/activity/activity_page.dart';
import 'package:getx_application/app/ui/android/error/error_page.dart';
import 'package:getx_application/app/ui/android/home/alumni_home_page.dart';
import 'package:getx_application/app/ui/android/home/company_home_page.dart';
import 'package:getx_application/app/ui/android/home/training_home_page.dart';
import 'package:getx_application/app/ui/android/home/university_home_page.dart';
import 'package:getx_application/app/ui/android/notification/notification_page.dart';
import 'package:getx_application/app/ui/android/search/search_page.dart';
import 'package:getx_application/app/ui/android/setting/setting_page.dart';
import 'package:getx_application/app/ui/android/vacancy/vacancy_page.dart';
import 'package:iconly/iconly.dart';

class RoleManager {
  final String userRole;
  List<BottomNavigationBarItem> destinations;
  List<Widget> pages;

  RoleManager(this.userRole)
      : destinations = _getDestinations(userRole),
        pages = _getPages(userRole);

  static List<BottomNavigationBarItem> _getDestinations(String userRole) {
    switch (userRole) {
      case "Alumni":
        return const [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.activity), label: ''),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.notification), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.setting), label: ''),
        ];
      case "Universitas":
        return const [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.search), label: ''),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.notification), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.setting), label: ''),
        ];
      case "Perusahaan" || "Lembaga Pelatihan":
        return const [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.activity), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.plus), label: ''),
          BottomNavigationBarItem(
              icon: Icon(IconlyBold.notification), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.setting), label: ''),
        ];
      default:
        return const [
          BottomNavigationBarItem(icon: Icon(IconlyBold.home), label: ''),
          BottomNavigationBarItem(icon: Icon(IconlyBold.profile), label: ''),
        ];
    }
  }

  static List<Widget> _getPages(String userRole) {
    switch (userRole) {
      case "Alumni":
        return [
          AlumniHomePage(),
          ActivityPage(),
          NotificationPage(),
          SettingPage(),
        ];
      case "Universitas":
        return [
          UniversityHomePage(),
          SearchPage(),
          NotificationPage(),
          SettingPage(),
        ];
      case "Perusahaan":
        return [
          CompanyHomePage(),
          VacancyPage(),
          NotificationPage(),
          SettingPage(),
        ];
      case "Lembaga Pelatihan":
        return [
          TrainingHomePage(),
          TrainingHomePage(),
          NotificationPage(),
          SettingPage(),
        ];
      default:
        return const [ErrorPage(), ErrorPage()];
    }
  }
}
