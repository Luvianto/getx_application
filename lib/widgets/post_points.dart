import 'package:flutter/material.dart';

class PostLabel extends StatelessWidget {
  final String title;
  final AssetImage icon;

  const PostLabel({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 180, 180, 180),
          ),
          borderRadius: BorderRadius.circular(100)),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(icon, size: 16),
          const SizedBox(
            width: 3,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
