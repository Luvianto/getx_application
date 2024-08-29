import 'package:flutter/material.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/common/utils/default_picture.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/handle_picture_widget.dart';
import 'package:getx_application/widgets/like_button.dart';
import 'package:getx_application/widgets/post_points.dart';

class VacancyCard extends StatelessWidget {
  final String companyLogo;
  final String companyName;
  final String earlyDateOfReceipt;
  final String finalDateOfReceipt;
  final String level;
  final String thumbnailImage;
  final String position;
  final String description;
  final bool isShowLikeButton;
  final bool isLiked;
  final int likesTotal;
  final Function(bool isLiked) updateLike;
  final int commentsTotal;
  final int appliedTotal;
  final int minSalary;
  final int maxSalary;
  final Function() onTap;
  final String fieldName;

  const VacancyCard({
    super.key,
    required this.companyLogo,
    required this.companyName,
    required this.earlyDateOfReceipt,
    required this.finalDateOfReceipt,
    required this.level,
    required this.thumbnailImage,
    required this.position,
    required this.description,
    this.isShowLikeButton = true,
    required this.isLiked,
    required this.likesTotal,
    required this.updateLike,
    required this.commentsTotal,
    required this.appliedTotal,
    required this.minSalary,
    required this.maxSalary,
    required this.onTap,
    required this.fieldName,
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
                    handleUserPicture(companyLogo),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companyName,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          formatTimestamp(earlyDateOfReceipt),
                          style: const TextStyle(fontSize: 10),
                        ),
                        Text(
                          formatTimestamp(finalDateOfReceipt),
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 244, 244),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const ImageIcon(
                          AssetImage('assets/icons/line/bar_chart.png')),
                      Text(
                        level,
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                )
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
            const SizedBox(height: 14),
            Text(position, style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 6),
            Text(
              description,
              textAlign: TextAlign.justify,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Wrap(spacing: 10, runSpacing: 8, children: [
              if (minSalary != 0 && maxSalary != 0)
                IntrinsicWidth(
                    child: PostLabel(
                        title: "Rp$minSalary - Rp$maxSalary",
                        icon: const AssetImage('assets/icons/line/Chart.png'))),
              IntrinsicWidth(
                  child: PostLabel(
                      title: "$appliedTotal Pelamar",
                      icon: const AssetImage('assets/icons/line/Work.png'))),
              IntrinsicWidth(
                  child: PostLabel(
                      title: fieldName,
                      icon:
                          const AssetImage('assets/icons/line/Arrow_Up.png'))),
            ]),
            const SizedBox(height: 10),
            Row(
              children: [
                if (isShowLikeButton)
                  LikeButton(
                    isLiked: isLiked,
                    likesTotal: likesTotal,
                    updateLike: (bool isLiked) {
                      updateLike(isLiked);
                    },
                  ),
                if (isShowLikeButton) const SizedBox(width: 10),
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
