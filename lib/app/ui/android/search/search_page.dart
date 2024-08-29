import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/controller/layout_controller.dart';

class SearchPage extends GetView<LayoutController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Search page'),
    );
  }
}
