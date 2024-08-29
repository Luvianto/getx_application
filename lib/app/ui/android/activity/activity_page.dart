import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/controller/layout_controller.dart';

class ActivityPage extends GetView<LayoutController> {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Activity page'),
    );
  }
}
