import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/controller/auth/signup_controller.dart';
import 'package:getx_application/app/routes/app_pages.dart';

class SelectRolePage extends GetView<SignupController> {
  SelectRolePage({super.key});

  final List<Map<String, dynamic>> roles = [
    {
      "icon": const Icon(Icons.diversity_3_rounded),
      "name": 'Alumni',
      "route": Routes.ALUMNI + Routes.SIGNUP,
      "description":
          "Orang-orang yang telah mengikuti atau tamat dari suatu sekolah atau perguruan tinggi."
    },
    {
      "icon": const Icon(Icons.apartment_rounded),
      "name": 'Perusahaan',
      "route": Routes.COMPANY + Routes.SIGNUP,
      "description":
          "Setiap bentuk usaha yang bersifat tetap dan terus menerus dan didirikan, bekerja serta berkedudukan dalam wilayah Republik Indonesia."
    },
    {
      "icon": const Icon(Icons.precision_manufacturing_rounded),
      "name": 'Lembaga Pelatihan',
      "route": Routes.TRAINING + Routes.SIGNUP,
      "description":
          "Satuan Pendidikan Nonformal yang diselenggarakan bagi masyarakat yang memerlukan bekal pengetahuan."
    },
    {
      "icon": const Icon(Icons.school_rounded),
      "name": 'Universitas',
      "route": Routes.UNIVERSITY + Routes.SIGNUP,
      "description":
          "Perguruan tinggi yang terdiri dari sejumlah fakultas yang menyelenggarakan pendidikan akademik."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Role',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.navigate_before),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const Text(
              'Sesuaikan jenis akun yang dipilih dengan sebagai siapa anda bertindak saat ini!',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: roles.map((role) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    title: Text(
                      role["name"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    childrenPadding: const EdgeInsets.all(16),
                    leading: role["icon"],
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        role["description"]!,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xff25324A)),
                            foregroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xffFFFFFF)),
                          ),
                          onPressed: () {
                            Get.toNamed(role["route"]!);
                          },
                          child: const Text("Pilih"),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
