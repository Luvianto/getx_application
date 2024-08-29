import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        border: Border.all(color: const Color(0xffCCCCCC)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }
}
