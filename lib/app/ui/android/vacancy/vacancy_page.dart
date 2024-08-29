import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/controller/layout_controller.dart';

class VacancyPage extends GetView<LayoutController> {
  const VacancyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Vacancy page'),
      ),
    );
  }
}
