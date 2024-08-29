import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final bool isDisabled;
  final int color;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.isDisabled = false,
    this.color = 0xff25324A,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey : Color(color),
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: const Color(0xffFFFFFF)),
        ),
      ),
    );
  }
}
