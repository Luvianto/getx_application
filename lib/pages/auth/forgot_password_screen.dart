import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/auth/reset_password_controller.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/custom_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final ResetPasswordController controller = Get.put(ResetPasswordController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 80),
        child: Form(
          key: _formKey,
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
                    'Atur Ulang Password',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'Poppins-Semibold'),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              CustomContainer(
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: 'Email',
                      onChanged: (value) => controller.email.value = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    controller.sendResetPasswordRequest();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff25324A),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Send',
                                  style: TextStyle(color: Color(0xffFFFFFF)),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
