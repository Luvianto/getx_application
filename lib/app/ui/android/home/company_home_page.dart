import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/controller/layout_controller.dart';

class CompanyHomePage extends GetView<LayoutController> {
  const CompanyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Company home'),
    );
  }
}
