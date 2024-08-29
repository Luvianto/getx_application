import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final Color? color;
  final Icon? icon;
  final String text;

  const InfoRow({
    super.key,
    this.color,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color ?? const Color(0xffFFFFFF),
          radius: icon != null ? 12 : 4,
          child: icon,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}
