import 'package:flutter/material.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/card_title.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget>? listWidget;

  const CustomCard({
    super.key,
    this.listWidget,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle(
            title: title,
            subtitle: subtitle,
          ),
          const SizedBox(height: 16),
          if (listWidget != null)
            Column(
              children: listWidget!,
            ),
        ],
      ),
    );
  }
}
