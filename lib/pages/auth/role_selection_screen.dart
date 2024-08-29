import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:uvce/controllers/sign_up_controller.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  final List<Map<String, String>> roles = [
    {"name": 'Alumni', "route": '/register_alumni'},
    {"name": 'Perusahaan', "route": '/register_company'},
    {"name": 'Lembaga Pelatihan', "route": '/register_training_institute'},
    {"name": 'Universitas', "route": '/register_university'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Select Role'),
        // ),
        body: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 80),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back(id: 1);
                  },
                  child: const ImageIcon(
                    AssetImage('assets/icons/line/Arrow_Left.png'),
                    size: 16,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Pilih Jenis Akun',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins-Semibold'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'harap sesuaikan jenis akun yang dipilih dengan sebagai siapa anda bertindak saat ini',
              style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Light'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: roles.length,
                itemBuilder: (context, index) {
                  final role = roles[index];
                  return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      margin: const EdgeInsets.all(6),
                      child: ListTile(
                        title: Text(role["name"]!),
                        onTap: () {
                          Get.toNamed(role["route"]!, id: 1);
                        },
                        titleAlignment: ListTileTitleAlignment.center,
                      ));
                },
              ),
            ),
          ]),
    ));
  }
}
