import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/validator.dart';
import 'package:getx_application/controllers/auth/signin_controller.dart';
import 'package:getx_application/pages/auth/sign_up_screen.dart';
import 'package:getx_application/routes/app_pages.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/custom_text_form_field.dart';
import 'package:getx_application/widgets/login_register_footer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController controller = Get.put(SignInController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'UVCE MApps',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 30.0),
            CustomContainer(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    onSaved: controller.setEmail,
                    labelText: 'Email',
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                    () => CustomTextFormField(
                      onSaved: controller.setPassword,
                      labelText: 'Password',
                      suffixIcon: VisibilityIcon(
                        isVisible: controller.isPasswordVisible.value,
                        onPressed: controller.togglePasswordVisibility,
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
                          Get.toNamed('/forgot-password', id: 1);
                        },
                        child: Text('Lupa password?',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  ),
                  Obx(
                    () => controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: 'SIGN IN',
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState!.save();
                                controller.signIn();
                              }
                            }),
                  ),
                  LoginRegisterFooter(
                    normalText: "Belum mempunyai akun? ",
                    linkText: "Daftar disini",
                    onClick: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
