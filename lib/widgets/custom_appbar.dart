import 'package:flutter/material.dart';
import 'package:getx_application/common/utils/default_picture.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String subtitle;
  final String imageUrl;

  const CustomAppBar({
    super.key,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ALUMNI UVCE',
            style: TextStyle(
              color: Color(0xff25324A),
              fontSize: 14,
              fontFamily: "Poppins-ExtraBoldItalic",
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xff25324A),
              fontSize: 12,
              fontFamily: "Poppins-LightItalic",
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xffffffff),
      scrolledUnderElevation: 0.0,
      actions: [
        Stack(
          children: [
            CircleAvatar(
              radius: 18,
              child: handleUserPicture(imageUrl),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 6,
                  backgroundColor: Color(0xff0AAD07),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
