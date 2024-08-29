import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/auth/regiter_university_controller.dart';
import 'package:getx_application/controllers/auth/signup_controller.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';

class RegisterUniversityScreen extends StatefulWidget {
  const RegisterUniversityScreen({super.key});

  @override
  State<RegisterUniversityScreen> createState() =>
      _RegisterUniversityScreenState();
}

class _RegisterUniversityScreenState extends State<RegisterUniversityScreen> {
  final RegisterUniversityController controller =
      Get.put(RegisterUniversityController());

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _universityController = TextEditingController();

  late Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    controller.password.value = Get.find<SignUpController>().password.value;
    controller.email.value = Get.find<SignUpController>().email.value;
    controller.phoneNumber.value =
        Get.find<SignUpController>().phoneNumber.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 80),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      'Lengkapi Informasi Akun Universitas',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Poppins-Semibold'),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                CustomContainer(
                    child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Cari Dan Pilih Universitas Anda',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => TextFormField(
                      controller: _universityController,
                      onChanged: (value) {
                        controller.isSelectingUniversity.value = false;
                        controller.universityName.value = value;
                      },
                      readOnly: controller.universityId.value.isNotEmpty,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: controller.universityId.value.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _universityController.clear();
                                  controller.universityId.value = '';
                                },
                              )
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan nama universitas';
                        }
                        return null;
                      },
                    ),
                  ),
                  Obx(
                    () => controller.isLoadingUniversities.value
                        ? const Center(child: CircularProgressIndicator())
                        : controller.universities.isEmpty
                            ? const Text('')
                            : Column(
                                children: controller.universities.map((univ) {
                                  return ListTile(
                                    title: Text(univ.namaPt),
                                    onTap: () {
                                      controller.isSelectingUniversity.value =
                                          true;
                                      controller.universityName.value =
                                          univ.namaPt;
                                      controller.universityId.value = univ.idSp;
                                      _universityController.text = univ.namaPt;
                                      controller.universities.clear();
                                    },
                                  );
                                }).toList(),
                              ),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                    () => controller.isSelectingUniversity.value
                        ? CustomButton(
                            text: "Konfirmasi",
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                controller.registerUniversity();
                              }
                            },
                          )
                        : Container(),
                  ),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
