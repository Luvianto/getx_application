import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/widgets/alumni_card.dart';
import 'package:getx_application/widgets/custom_button.dart';

class SelectPesertaPage extends StatefulWidget {
  final int routeID;
  final String? id;

  const SelectPesertaPage({super.key, this.id, required this.routeID});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<SelectPesertaPage> {
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
                      Get.back(id: 20);
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
                    'Next.js Fullstack - Intermediate',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'Poppins-Semibold'),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'Pilih Peserta Hadir',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 3),
              Text(
                'Peserta yang ditandai akan diberikan poin',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 14,
              ),
              CustomButton(
                text: 'Proses Kirim Poin ke Peserta',
                onTap: () {},
              ),
              const SizedBox(
                height: 14,
              ),
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
                routeID: widget.routeID,
              ),
              const SizedBox(height: 16),
              AlumniCard(
                name: 'Fadila Sari',
                title: 'Web Developer',
                description:
                    'Programmer pemula yang menyukai tantangan dan tidak pernah berhenti belajar hal baru.',
                salary: 'Rp 3.500.000',
                dateRange: '19 Januari 2024 - sekarang',
                position: 'Junior Web Developer',
                company: 'BPKAD OKI',
                level: 'Beginner Level',
                imageUrl: 'assets/images/profile-pictures/pp_2.png',
                routeID: widget.routeID,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
