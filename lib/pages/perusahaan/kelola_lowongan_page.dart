import 'package:flutter/material.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/post_lowongan_card.dart';

class KelolaLowonganPage extends StatelessWidget {
  const KelolaLowonganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              Text(
                'Kelola Lowongan Pekerjaan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              const CustomContainer(
                  child: PostLowonganCard(
                title: 'Next JS Fullstack - Intermediete',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies eget ....',
                field: 'Frontend Developer',
                date: '23 Februari 2024',
                likesCount: 20,
                commentsCount: 20,
                canManage: true,
                editDestination: 1,
                deleteDestination: 1,
                appliedCount: 200,
                level: 'Entry',
                salaryCount: '3-6jt',
                routeId: 31,
                routeUrl: '/detail-lowongan',
              )),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
