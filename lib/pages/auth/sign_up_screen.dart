import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/validator.dart';
import 'package:getx_application/controllers/auth/signup_controller.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/custom_text_form_field.dart';
import 'package:getx_application/widgets/login_register_footer.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignUpController controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

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
            CustomContainer(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: 'Email',
                      onSaved: (value) => controller.setEmail(value),
                      validator: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      labelText: 'Nomor Telepon',
                      onSaved: (value) => controller.setPhoneNumber(value),
                      validator: validatePhone,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(15),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Obx(
                      () => CustomTextFormField(
                        labelText: 'Password',
                        onChanged: (value) => controller.setPassword(value),
                        obscureText: !controller.isPasswordVisible.value,
                        suffixIcon: VisibilityIcon(
                          isVisible: !controller.isPasswordVisible.value,
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        validator: validatePassword,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Obx(
                      () => CustomTextFormField(
                        labelText: 'Konfirmasi Password',
                        onChanged: (value) =>
                            controller.setConfirmPassword(value),
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        suffixIcon: VisibilityIcon(
                          isVisible: !controller.isConfirmPasswordVisible.value,
                          onPressed: controller.toogleConfirmPasswordVisibility,
                        ),
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
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _formKey.currentState!.save();
                                  controller.checkEmail();
                                }
                              },
                            ),
                    ),
                    const SizedBox(height: 16.0),
                    LoginRegisterFooter(
                      normalText: "Sudah mempunyai akun? ",
                      linkText: "Masuk sekarang",
                      onClick: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VisibilityIcon extends StatelessWidget {
  final bool isVisible;
  final void Function()? onPressed;

  const VisibilityIcon({
    super.key,
    required this.isVisible,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: onPressed,
    );
  }
}
