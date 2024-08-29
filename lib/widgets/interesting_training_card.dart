import 'package:flutter/material.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/handle_picture_widget.dart';

class InterestingTrainingCard extends StatelessWidget {
  final String title;
  final String trainingType;
  final int point;
  final String image;
  final Function() onTap;

  const InterestingTrainingCard({
    super.key,
    required this.title,
    required this.trainingType,
    required this.point,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: CustomContainer(
          child: SizedBox(
            child: Row(
              children: [
                CircleAvatar(
                    radius: 35,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: handlePictureWidget(
                        imageUrl: image, height: 100, width: 100)),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    Text(trainingType),
                    Text('$point poin')
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
