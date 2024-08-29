import 'package:flutter/material.dart';
import 'package:getx_application/widgets/custom_container.dart';

class TrainingComments extends StatelessWidget {
  const TrainingComments({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Komentar'),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                child: Image.asset(
                  'assets/images/profile-pictures/pp_2.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Luvi Dedek Fajri'),
                  Text('30 menit yang lalu'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
              'dolor sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies.'),
          const SizedBox(height: 10),
          const Divider()
        ],
      ),
    );
  }
}
