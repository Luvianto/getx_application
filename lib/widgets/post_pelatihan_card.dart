import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/widgets/handle_picture_widget.dart';
import 'package:getx_application/widgets/like_button.dart';
import 'package:getx_application/widgets/post_points.dart';

class PostPelatihanCard extends StatelessWidget {
  final int routingID;
  final int id;
  final String title;
  final String description;
  final String field;
  final String date;
  final String points;
  final bool isLiked;
  final int likesTotal;
  final Function(bool isLiked) updateLike;
  final String imageUrl;
  final int commentsCount;
  final bool canManage;
  final int? editDestination;
  final int? deleteDestination;

  const PostPelatihanCard({
    super.key,
    required this.routingID,
    required this.id,
    required this.title,
    required this.description,
    required this.field,
    required this.date,
    required this.points,
    required this.isLiked,
    required this.likesTotal,
    required this.updateLike,
    required this.imageUrl,
    required this.commentsCount,
    required this.canManage,
    this.editDestination,
    this.deleteDestination,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/details/$id', id: routingID);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field,
                    style: Theme.of(context).textTheme.displayLarge,
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
                        onPressed: () {
                          Get.toNamed('/edit/$id', id: 23);
                        },
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
                  ],
                ),
              if (canManage == false)
                PostLabel(
                    title: '$points Pts',
                    icon: const AssetImage('assets/icons/line/Arrow_Up.png'))
            ],
          ),
          const SizedBox(height: 13),
          handlePictureWidget(
            imageUrl: imageUrl,
            height: 240,
            width: 600,
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.displayLarge),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              LikeButton(
                isLiked: isLiked,
                likesTotal: likesTotal,
                updateLike: (bool isLiked) {
                  updateLike(isLiked);
                },
              ),
              const SizedBox(width: 13),
              PostLabel(
                  title: '$commentsCount',
                  icon: const AssetImage('assets/icons/line/Chat.png')),
              const SizedBox(width: 13),
              if (canManage)
                PostLabel(
                    title: '$points Pts',
                    icon: const AssetImage('assets/icons/line/Arrow_Up.png')),
            ],
          )
        ],
      ),
    );
  }
}
