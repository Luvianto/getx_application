import 'package:flutter/material.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/handle_picture_widget.dart';
import 'package:getx_application/widgets/like_button.dart';
import 'package:getx_application/widgets/post_points.dart';

class TrainingCard extends StatelessWidget {
  final String institutionLogo;
  final String institutionName;
  final String thumbnailImage;
  final String title;
  final String description;
  final String createdAt;
  final int point;
  final bool isLiked;
  final int likesTotal;
  final Function(bool isLiked) updateLike;
  final int commentsTotal;
  final Function() onTap;

  const TrainingCard({
    super.key,
    required this.institutionLogo,
    required this.institutionName,
    required this.thumbnailImage,
    required this.title,
    required this.description,
    required this.point,
    required this.isLiked,
    required this.likesTotal,
    required this.updateLike,
    required this.commentsTotal,
    required this.createdAt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Image.asset(
                    //   institutionLogo,
                    //   height: 50,
                    //   width: 50,
                    //   fit: BoxFit.cover,
                    // ),
                    // const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          institutionName,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          createdAt,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                PostLabel(
                    title: '$point Pts',
                    icon: const AssetImage('assets/icons/line/Arrow_Up.png')),
              ],
            ),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100],
                ),
                width: MediaQuery.of(context).size.width * 1,
                height: 180,
                child: handlePictureWidget(
                    imageUrl: thumbnailImage, height: 240, width: 600)),
            const SizedBox(height: 13),
            Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.displayLarge),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.justify,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                LikeButton(
                  isLiked: isLiked,
                  likesTotal: likesTotal,
                  updateLike: (bool isLiked) {
                    updateLike(isLiked);
                  },
                ),
                const SizedBox(width: 10),
                InkWell(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 180, 180, 180),
                        ),
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      children: [
                        const ImageIcon(
                          AssetImage('assets/icons/line/Chat.png'),
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text('$commentsTotal')
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
