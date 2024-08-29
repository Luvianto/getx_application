import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/common/utils/validator.dart';
import 'package:getx_application/app/controller/auth/signin_controller.dart';
import 'package:getx_application/app/common/widgets/custom_button.dart';
import 'package:getx_application/app/routes/app_pages.dart';

class SigninPage extends GetView<SigninController> {
  SigninPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) => controller.email.value = value,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: validateEmail,
              ),
              const SizedBox(height: 16.0),
              Obx(
                () => TextFormField(
                  onChanged: (value) => controller.password.value = value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !controller.isPasswordVisible.value,
                  validator: validatePassword,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Get.toNamed('/forgot-password', id: 1);
                    },
                    child: const Text('Lupa password?'),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: 'SIGN IN',
                        onTap: () {
                          // if (_formKey.currentState?.validate() ??
                          //     false) {
                          controller.fakeSignIn();
                          // }
                        },
                      ),
              ),
              const SizedBox(height: 42),
              Column(
                children: [
                  const Text('Belum Memiliki Akun?'),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: const Text(
                      'Daftar disini',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
