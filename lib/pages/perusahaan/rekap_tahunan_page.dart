import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/widgets/alumni_card.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/post_lowongan_card.dart';

class RekapTahunanPage extends StatelessWidget {
  final String type;
  final int routeID;

  const RekapTahunanPage(
      {super.key, required this.type, required this.routeID});

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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back(id: 8);
                    },
                    child: const ImageIcon(
                      AssetImage('assets/icons/line/Arrow_Left.png'),
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      type == 'Lowongan'
                          ? 'Lowongan Pekerjaan Dibuka Tahun Ini'
                          : 'Karyawan Baru Diterima Tahun Ini',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 14),
              if (type == 'Lowongan')
                const CustomContainer(
                    child: PostLowonganCard(
                  title: 'Next JS Fullstack - Intermediete',
                  description:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies eget ....',
                  field: 'Frontend Developer',
                  date: '23 Februari 2024',
                  likesCount: 20,
                  commentsCount: 20,
                  canManage: false,
                  editDestination: 1,
                  deleteDestination: 1,
                  appliedCount: 200,
                  level: 'Entry',
                  salaryCount: '3-6jt',
                  routeId: 8,
                  routeUrl: '/detail-lowongan',
                )),
              const SizedBox(height: 14),
              if (type != 'Lowongan')
                AlumniCard(
                    name: 'Moh. Hafis',
                    title: 'Web Developer',
                    description:
                        'Seorang programmer otodidak yang menyukai tantangan dan tidak pernah berhenti belajar.',
                    salary: 'Rp 4.000.000',
                    dateRange: '02 Agustus 2019 - sekarang',
                    position: 'Manager Pengembangan dan IT',
                    company: 'Kominfo Sumsel',
                    level: 'Expert Level',
                    imageUrl: 'assets/images/profile-pictures/pp_1.png',
                    routeID: routeID),
            ],
          ),
        ),
      ),
    );
  }
}
