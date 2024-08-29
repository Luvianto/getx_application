import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/auth/register_training_controller.dart';
import 'package:getx_application/controllers/auth/signup_controller.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';

class RegisterLembagaScreen extends StatefulWidget {
  const RegisterLembagaScreen({super.key});

  @override
  State<RegisterLembagaScreen> createState() => _RegisterLembagaScreenState();
}

class _RegisterLembagaScreenState extends State<RegisterLembagaScreen> {
  final RegisterTrainingController controller =
      Get.put(RegisterTrainingController());

  final _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> userData;

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
                      'Lengkapi Informasi Akun',
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
                        'Masukan Nama Institusi',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    onChanged: (value) {
                      controller.institutionName.value = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama Institusi harus diisi!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                    () => controller.institutionName.value.isNotEmpty
                        ? CustomButton(
                            text: "Konfirmasi",
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                controller.password.value =
                                    Get.find<SignUpController>().password.value;
                                controller.email.value =
                                    Get.find<SignUpController>().email.value;
                                controller.phoneNumber.value =
                                    Get.find<SignUpController>()
                                        .phoneNumber
                                        .value;
                                controller.registerLembagaPelatihan();
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
