import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/controller/layout_controller.dart';

class UniversityHomePage extends GetView<LayoutController> {
  const UniversityHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('University home'),
    );
  }
}
