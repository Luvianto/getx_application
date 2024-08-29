import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/widgets/post_points.dart';

class PostLowonganCard extends StatelessWidget {
  final String title;
  final String description;
  final String field;
  final String date;
  final String level;
  final int likesCount;
  final int commentsCount;
  final int appliedCount;
  final String salaryCount;
  final bool canManage;
  final int? editDestination;
  final int? deleteDestination;
  final String? routeUrl;
  final int? routeId;

  const PostLowonganCard({
    super.key,
    required this.title,
    required this.description,
    required this.field,
    required this.date,
    required this.level,
    required this.likesCount,
    required this.commentsCount,
    required this.appliedCount,
    required this.salaryCount,
    required this.canManage,
    this.editDestination,
    this.deleteDestination,
    this.routeUrl,
    this.routeId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (routeId == null && routeUrl == null) {
                      Get.toNamed('/details', id: 1);
                    } else {
                      Get.toNamed("$routeUrl", id: routeId);
                    }
                  },
                  child: Text(
                    field,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            if (canManage)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff25324A),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Edit',
                        style:
                            TextStyle(color: Color(0xffFFFFFF), fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 90,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffE12B20),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Hapus',
                        style:
                            TextStyle(color: Color(0xffFFFFFF), fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            if (canManage == false)
              PostLabel(
                  title: '$level Level',
                  icon: const AssetImage('assets/icons/line/Arrow_Up.png'))
          ],
        ),
        const SizedBox(height: 13),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/thumbnails/thumbnail_1.png',
            height: 240,
            width: 600,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 13),
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.displayLarge),
          ],
        ),
        const SizedBox(height: 4),
        Text(description, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 13),
        Row(
          children: [
            PostLabel(
                title: '$likesCount',
                icon: const AssetImage('assets/icons/line/Heart.png')),
            const SizedBox(width: 13),
            PostLabel(
                title: '$commentsCount',
                icon: const AssetImage('assets/icons/line/Chat.png')),
            const SizedBox(width: 13),
            PostLabel(
                title: '$appliedCount',
                icon: const AssetImage('assets/icons/line/Work.png')),
            const SizedBox(width: 13),
            PostLabel(
                title: 'Rp $salaryCount',
                icon: const AssetImage('assets/icons/line/Filter.png')),
          ],
        )
      ],
    );
  }
}
