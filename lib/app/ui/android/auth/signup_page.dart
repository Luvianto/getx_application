import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/common/utils/validator.dart';
import 'package:getx_application/app/common/widgets/custom_button.dart';
import 'package:getx_application/app/controller/auth/signup_controller.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pendaftaran Akun',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => controller.setEmail(value),
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nomor Telepon',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => controller.setPhone(value),
                    validator: validatePhoneNumber,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(15),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                    () => TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: !controller.isPasswordVisible.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      onChanged: (value) => controller.setPassword,
                      obscureText: !controller.isPasswordVisible.value,
                      validator: validatePassword,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                    () => TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: !controller.isConfirmPasswordVisible.value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: controller.toogleConfirmPasswordVisibility,
                        ),
                      ),
                      onChanged: controller.setConfirmPassword,
                      obscureText: !controller.isConfirmPasswordVisible.value,
                      validator: (value) => validateConfirmPassword(
                        value,
                        controller.password.value,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36.0),
                  Obx(
                    () => controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: 'LANJUT',
                            onTap: () {
                              // if (controller.formKey.currentState?.validate() ??
                              //     false) {
                              controller.formKey.currentState!.save();
                              controller.fakeCheckEmail();
                              // }
                            },
                          ),
                  ),
                  const SizedBox(height: 42),
                  Column(
                    children: [
                      const Text('Sudah Memiliki Akun?'),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          'Login disini',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
