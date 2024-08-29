import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/common/widgets/custom_button.dart';
import 'package:getx_application/app/controller/setting/setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  @override
  final controller = Get.put(SettingController());

  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Setting Page'),
          const SizedBox(height: 8),
          Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: 'LOGOUT',
                    onTap: controller.fakeSignOut,
                  ),
          )
        ],
      ),
    );
  }
}
