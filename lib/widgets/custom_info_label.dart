import 'package:flutter/material.dart';

class CustomInfoLabel extends StatelessWidget {
  final String title;
  final String description;

  const CustomInfoLabel({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style:
                  const TextStyle(fontSize: 13, fontFamily: 'Poppins-Semibold'),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 4,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          description,
        ),
      )
    ]);
  }
}
