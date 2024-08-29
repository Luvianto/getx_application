import 'package:flutter/material.dart';
import 'package:getx_application/pages/alumni/alumni_home_page.dart';
import 'package:getx_application/pages/alumni/riwayat_lamaran_page.dart';
import 'package:getx_application/pages/common/cari_alumni_page.dart';
import 'package:getx_application/pages/common/pengaturan_page.dart';
import 'package:getx_application/pages/lembaga_pelatihan/home_lembaga_pelatihan_page.dart';
import 'package:getx_application/pages/lembaga_pelatihan/kelola_post_pelatihan_page.dart';
import 'package:getx_application/pages/lembaga_pelatihan/tambah_post_page.dart';
import 'package:getx_application/pages/perusahaan/home_perusahaan_page.dart';
import 'package:getx_application/pages/perusahaan/kelola_lowongan_page.dart';
import 'package:getx_application/pages/universitas/home_universitas_page.dart';
import 'package:iconly/iconly.dart';
import 'package:getx_application/pages/common/notifikasi_page.dart';
import 'package:getx_application/pages/perusahaan/tambah_post_perusahaan_page.dart';

class RoleBasedNavigationManager {
  final String userRole;
  List<BottomNavigationBarItem> destinations;
  List<Widget> pages;

  RoleBasedNavigationManager(this.userRole)
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
      case "Perusahaan":
      case "Lembaga Pelatihan":
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
        ];
    }
  }

  static List<Widget> _getPages(String userRole) {
    switch (userRole) {
      case "Alumni":
        return const [
          AlumniHomePage(
            routeID: 0,
          ),
          RiwayatLamaranPage(),
          NotifikasiPage(),
          PengaturanPage()
        ];
      case "Universitas":
        return const [
          HomeUniversitasPage(),
          CariAlumniPage(
            routeID: 0,
          ),
          NotifikasiPage(),
          PengaturanPage()
        ];
      case "Perusahaan":
        return const [
          HomePerusahaanPage(),
          KelolaLowonganPage(),
          TambahPostPerusahaanPage(),
          NotifikasiPage(),
          PengaturanPage()
        ];
      case "Lembaga Pelatihan":
        return const [
          HomeLembagaPelatihanPage(),
          KelolaPostPelatihanPage(),
          TambahPostPage(),
          NotifikasiPage(),
          PengaturanPage()
        ];
      default:
        return const [Center(child: Text("No content available"))];
    }
  }
}
