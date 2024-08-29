import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/object_parser.dart';
import 'package:getx_application/controllers/dashboard_controller.dart';
import 'package:getx_application/models/dashboard/university_dashboard_model.dart';
import 'package:getx_application/widgets/custom_bar_chart.dart';

// widgets
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/header_text.dart';
import 'package:getx_application/widgets/info_card.dart';

class HomeUniversitasPage extends StatefulWidget {
  const HomeUniversitasPage({super.key});

  @override
  State<HomeUniversitasPage> createState() => _HomeUniversitasPage();
}

class _HomeUniversitasPage extends State<HomeUniversitasPage> {
  final DashboardController controller = Get.put(DashboardController());

  @override
  void initState() {
    controller.fetchUniversiDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final dashboardData = controller.universityDashboardData.value;
        final dataValues = dashboardData.alumniAcceptedPerMonth?.month != null
            ? parseMonthData(dashboardData.alumniAcceptedPerMonth!.month)
            : <String, double>{};

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderText(
                title: 'Alumni Diterima Kerja',
                subtitle: 'Selama tahun 2024',
              ),
              const SizedBox(height: 16),
              CustomBarChart(
                title: "Semua Prodi",
                subtitle: "",
                dataValues: dataValues,
              ),
              const SizedBox(height: 16),
              TipePerusahaanAlumni(
                  data: dashboardData.alumniAcceptedByCompanyType ?? []),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Lihat Insight Lainnya',
                onTap: () {
                  Get.toNamed('/demografi-alumni', id: 41);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class TipePerusahaanAlumni extends StatelessWidget {
  final List<AlumniAcceptedByCompanyType> data;

  const TipePerusahaanAlumni({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 8,
      children: [
        for (int i = 0; i < data.length; i++)
          SizedBox(
            width: (MediaQuery.of(context).size.width - 48) / 2,
            child: InfoCard(
              label: data[i].companyTypeName,
              count: data[i].total,
              // onTap: () => Get.toNamed('/alumni-accepted-at-companies', id: 41),
            ),
          ),
      ],
    );
  }
}
