// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx_application/controllers/layout_controller.dart';

// class CustomAppBar extends GetView<LayoutController>
//     implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<LayoutController>();
//     return AppBar(
//       automaticallyImplyLeading: false,
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'UVCE',
//             style: TextStyle(
//               color: Color(0xff25324A),
//               fontSize: 14,
//             ),
//           ),
//           Text(
//             "as ${controller.userRole.value}",
//             style: const TextStyle(
//               color: Color(0xff25324A),
//               fontSize: 12,
//             ),
//           )
//         ],
//       ),
//       backgroundColor: const Color(0xffffffff),
//       scrolledUnderElevation: 0.0,
//       actions: const [
//         CircleAvatar(radius: 18),
//         SizedBox(width: 10),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
