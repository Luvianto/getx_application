import 'package:flutter/material.dart';
import 'custom_container.dart';
import 'custom_button.dart';

class InfoCard extends StatelessWidget {
  final dynamic count;
  final String label;
  final Function()? onTap;
  final String? type;

  const InfoCard({
    super.key,
    required this.count,
    required this.label,
    this.onTap,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xffF8F8F8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              type == 'lowongan' ? '$count lowongan' : '$count Orang',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 18,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          if (onTap != null)
            CustomButton(
              text: 'Lihat Detail',
              onTap: onTap,
            ),
        ],
      ),
    );
  }
}
