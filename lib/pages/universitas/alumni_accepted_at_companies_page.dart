import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/widgets/custom_bar_chart.dart';
import 'package:getx_application/widgets/custom_container.dart';

class AlumniAcceptedAtCompaniesPage extends StatelessWidget {
  const AlumniAcceptedAtCompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataValues = {
      "Jan": 700,
      "Feb": 600,
      "Mar": 750,
      "Apr": 500,
      "Mei": 650,
      "Jun": 0,
      "Jul": 387,
      "Ags": 0,
      "Sep": 0,
      "Okt": 0,
      "Nov": 0,
      "Dec": 0,
    };

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  'Alumni Diterima Kerja - BUMN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins-Semibold'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Jumlah Alumni',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Selama Tahun 2024',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 248, 248),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  child: Text(
                    '233 Orang',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Selama Tahun 2024',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )),
            CustomBarChart(
              title: "Statisik",
              subtitle: "Tahun 2024",
              dataValues: dataValues,
            ),
            const SizedBox(height: 10),
            Text(
              'Daftar Instansi/Perusahaan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  Get.toNamed('/company-detail', id: 41);
                },
                child: CustomContainer(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/images/profile-pictures/pp_3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'KOMINFO SUMSEL',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'BUMN',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              'Perusahaan teknologi negara.',
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )))
          ],
        ),
      ),
    ));
  }
}
