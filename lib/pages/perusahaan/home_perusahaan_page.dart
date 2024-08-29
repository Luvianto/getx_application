import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/object_parser.dart';
import 'package:getx_application/controllers/alumni/alumni_controller.dart';
import 'package:getx_application/controllers/dashboard_controller.dart';
import 'package:getx_application/controllers/vacancy/vacancy_controller.dart';
import 'package:getx_application/models/alumni/alumni_model.dart';
import 'package:getx_application/models/vacancy/vacancy_model.dart';
import 'package:getx_application/widgets/custom_bar_chart.dart';
import 'package:getx_application/widgets/info_card.dart';
import 'package:getx_application/widgets/interesting_talent_card.dart';
import 'package:getx_application/widgets/vacancy_card.dart';

class HomePerusahaanPage extends StatefulWidget {
  const HomePerusahaanPage({super.key});

  @override
  State<HomePerusahaanPage> createState() => _HomePerusahaanPageState();
}

class _HomePerusahaanPageState extends State<HomePerusahaanPage> {
  final DashboardController controller = Get.put(DashboardController());
  final AlumniController alumniController = Get.put(AlumniController());
  final VacancyController vacancyController = Get.put(VacancyController());

  @override
  void initState() {
    controller.fetchCompanyDashboard();
    alumniController.fetchAlumni();
    vacancyController.fetchVacancies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final dashboardData = controller.companyDashboardData.value;
      final dataValues = dashboardData.alumniAcceptedPerMonth?.month != null
          ? parseMonthData(dashboardData.alumniAcceptedPerMonth!.month)
          : <String, double>{};

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
                  'Statistik Penerimaan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                CustomBarChart(
                  title: "Semua Divisi",
                  subtitle: "Tahun 2024",
                  dataValues: dataValues,
                ),
                const SizedBox(height: 16),
                _DetailInformasi(
                  totalAlumniAccepted: dashboardData.totalAlumniAccepted ?? 0,
                  totalVacancy: dashboardData.totalVacancy ?? 0,
                ),
                const SizedBox(height: 16),
                _TalentMenarik(
                  alumniController: alumniController,
                ),
                const SizedBox(height: 14),
                Text(
                  'Pekerjaan Diposting',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 14),
                _PekerjaanDiposting(
                  vacancyController: vacancyController,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _DetailInformasi extends StatelessWidget {
  final int totalVacancy;
  final int totalAlumniAccepted;

  const _DetailInformasi(
      {required this.totalVacancy, required this.totalAlumniAccepted});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listPerusahaan = [
      {"key": "Lowongan", "value": totalVacancy},
      {"key": "Diterima", "value": totalAlumniAccepted},
    ];

    return Row(
      children: [
        for (int i = 0; i < 2; i++) ...[
          Flexible(
            child: InfoCard(
              label: "${listPerusahaan[i]["key"]}",
              count: "${listPerusahaan[i]["value"]}",
              type: i == 0 ? 'lowongan' : 'orang',
              onTap: () {
                Get.toNamed(
                    "/rekap_tahunan/${listPerusahaan[i]["tipe_perusahaan"]}",
                    id: 8);
              },
            ),
          ),
          if (i < listPerusahaan.length - 1) const SizedBox(width: 8),
        ]
      ],
    );
  }
}

class _TalentMenarik extends StatelessWidget {
  final AlumniController alumniController;

  const _TalentMenarik({required this.alumniController});

  @override
  Widget build(BuildContext context) {
    final List<AlumniModel> alumnis = alumniController.alumniData;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Talent Menarik',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/talent', id: 8);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xff25324A))),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded),
                    Text('Cari Talent',
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: Obx(
            () => alumniController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: alumnis.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16.0),
                    itemBuilder: (context, index) {
                      final alumni = alumnis[index];
                      return InterestingTalentCard(
                          onTap: () =>
                              Get.toNamed('/detail-alumni/${alumni.id}', id: 8),
                          name: alumni.name!,
                          major: alumni.major!,
                          image: alumni.user?.imageUrl! ?? '-');
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class _PekerjaanDiposting extends StatelessWidget {
  final VacancyController vacancyController;

  const _PekerjaanDiposting({required this.vacancyController});

  @override
  Widget build(BuildContext context) {
    final List<VacancyModel> vacancies = vacancyController.vacancies;

    return Obx(
      () => vacancyController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vacancies.length,
              itemBuilder: (context, index) {
                final vacancy = vacancies[index];
                return VacancyCard(
                  onTap: () => Get.toNamed('/vacancy/${vacancy.id}', id: 8),
                  companyLogo: vacancy.company?.user?.imageUrl ?? '-',
                  companyName: vacancy.company?.companyName ?? '-',
                  earlyDateOfReceipt: vacancy.earlyDateOfReceipt ?? '-',
                  finalDateOfReceipt: vacancy.finalDateOfReceipt ?? '-',
                  level: vacancy.level?.name ?? '-',
                  thumbnailImage: vacancy.thumbnailUrl ?? '-',
                  position: vacancy.position ?? '-',
                  fieldName: vacancy.field?.name ?? '-',
                  description: vacancy.description ?? '-',
                  isLiked: vacancy.isLiked ?? false,
                  likesTotal: vacancy.likesTotal ?? 0,
                  updateLike: (bool isLiked) {
                    vacancyController.updateVacancyLike(
                      vacancy.id!,
                      isLiked,
                    );
                  },
                  commentsTotal: vacancy.commentsTotal ?? 0,
                  appliedTotal: vacancy.appliedCount ?? 0,
                  minSalary: vacancy.minSalary ?? 0,
                  maxSalary: vacancy.maxSalary ?? 0,
                );
              },
            ),
    );
  }
}
