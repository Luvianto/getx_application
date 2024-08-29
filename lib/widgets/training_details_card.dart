import 'package:flutter/material.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/handle_picture_widget.dart';
import 'package:getx_application/widgets/join_button.dart';
import 'package:getx_application/widgets/like_button.dart';
import 'package:getx_application/widgets/post_points.dart';

class TrainingDetailsCard extends StatelessWidget {
  final int id;
  final String institutionLogo;
  final String institutionName;
  final String title;
  final String description;
  final int point;
  final int likesTotal;
  final int commentsTotal;
  final String thumbnailUrl;
  final int joinedCount;
  final bool isJoined;
  final bool isLiked;
  final Function(bool isLiked) updateLike;
  final String field;
  final String createdAt;

  const TrainingDetailsCard({
    super.key,
    required this.id,
    required this.institutionLogo,
    required this.institutionName,
    required this.title,
    required this.description,
    required this.point,
    required this.likesTotal,
    required this.commentsTotal,
    required this.createdAt,
    required this.thumbnailUrl,
    required this.joinedCount,
    required this.isJoined,
    required this.isLiked,
    required this.updateLike,
    required this.field,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    institutionName,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(createdAt),
                ],
              ),
              Image.asset(
                'assets/images/placeholder-image.jpg',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            width: MediaQuery.of(context).size.width * 1,
            height: 180,
            child: Center(
              child: handlePictureWidget(
                imageUrl: thumbnailUrl,
                height: 240,
                width: 600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              IntrinsicWidth(
                child: LikeButton(
                  isLiked: isLiked,
                  likesTotal: likesTotal,
                  updateLike: updateLike,
                ),
              ),
              IntrinsicWidth(
                child: PostLabel(
                    title: '$point Pts',
                    icon: const AssetImage('assets/icons/line/Arrow_Up.png')),
              ),
              IntrinsicWidth(
                child: PostLabel(
                    title: field,
                    icon: const AssetImage('assets/icons/line/Chart.png')),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.justify,
          ),
          JoinButton(
            isJoined: isJoined,
          ),
        ],
      ),
    );
  }
}
