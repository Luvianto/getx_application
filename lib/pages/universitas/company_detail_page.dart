import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/widgets/alumni_card.dart';

class CompanyDetailPage extends StatefulWidget {
  final int routeID;
  final String? id;

  const CompanyDetailPage({super.key, this.id, required this.routeID});

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
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
                      Get.back(id: 41);
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
                    'Kominfo Sumsel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'Poppins-Semibold'),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xff25324A),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/profile-pictures/pp_3.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Kominfo Sumsel',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xffFFFFFF)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Kominfo Sumsel ... Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies eget ....',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Color(0xffFFFFFF), fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '40 Data Ditemukan',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AlumniCard(
                name: 'Moh. Hafis',
                title: 'Web Developer',
                description:
                    'Seorang programmer otodidak yang menyukai tantangan dan tidak pernah berhenti belajar.',
                position: 'Manager Pengembangan dan IT',
                company: 'Kominfo Sumsel',
                salary: '-',
                dateRange: '19 Agustus 2023 - sekarang',
                level: 'Entry Level',
                imageUrl: 'assets/images/profile-pictures/pp_1.png',
                routeID: widget.routeID,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
