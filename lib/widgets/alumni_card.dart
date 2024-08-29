import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/default_picture.dart';
import 'package:getx_application/widgets/card_title.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/post_points.dart';

class AlumniCard extends StatelessWidget {
  final String? id;
  final String? applicationId;
  final String name;
  final String title;
  final String description;
  final String salary;
  final String dateRange;
  final String position;
  final String company;
  final String level;
  final String? imageUrl;
  final int routeID;

  const AlumniCard({
    super.key,
    this.id,
    this.applicationId,
    required this.name,
    required this.title,
    required this.description,
    required this.salary,
    required this.dateRange,
    required this.position,
    required this.company,
    required this.level,
    this.imageUrl,
    required this.routeID,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  handleUserPicture(imageUrl ?? '-', size: 50),
                  const SizedBox(width: 10),
                  CardTitle(title: name, subtitle: title),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  height: 1.5,
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          Wrap(spacing: 10, runSpacing: 8, children: [
            IntrinsicWidth(
                child: PostLabel(
                    title: dateRange,
                    icon: const AssetImage('assets/icons/line/Calendar.png'))),
            IntrinsicWidth(
                child: PostLabel(
                    title: position,
                    icon: const AssetImage('assets/icons/line/Work.png'))),
            IntrinsicWidth(
                child: PostLabel(
                    title: company,
                    icon: const AssetImage('assets/icons/line/Chart.png'))),
          ]),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Lihat Detail Alumni',
            onTap: () {
              Get.toNamed('/detail-alumni/$id', id: routeID);
            },
          ),
          const SizedBox(height: 12),
          if (routeID == 8 && applicationId != null)
            CustomButton(
              text: 'Ubah Status Lamaran',
              color: 0xFF027500,
              onTap: () {
                Get.toNamed('/tracking-lamaran/$applicationId', id: routeID);
              },
            ),
        ],
      ),
    );
  }
}
