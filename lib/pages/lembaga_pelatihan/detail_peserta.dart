import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/widgets/alumni_detail_card.dart';

class DetailPesertaPage extends StatelessWidget {
  final int routeID;
  final String? id;

  const DetailPesertaPage({super.key, required this.routeID, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back(id: routeID);
                    },
                    child: const ImageIcon(
                      AssetImage('assets/icons/line/Arrow_Left.png'),
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Moh Hafiz',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'Poppins-Semibold'),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const AlumniDetailCard(
                name: 'Moh. Hafis',
                title: 'Web Developer',
                description:
                    'Seorang programmer otodidak yang menyukai tantangan dan tidak pernah berhenti belajar.',
                salary: 'Rp 4.000.000',
                dateRange: '02 Agustus 2019 - sekarang',
                position: 'Manager Pengembangan dan IT',
                company: 'Kominfo Sumsel',
                level: 'Expert Level',
                imageUrl:
                    'assets/images/profile-pictures/pp_1.png', // Replace with your image URL
              ),
            ],
          ),
        ),
      ),
    );
  }
}
