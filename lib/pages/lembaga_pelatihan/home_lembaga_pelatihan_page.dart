import 'package:flutter/material.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/common/utils/object_parser.dart';
import 'package:getx_application/controllers/dashboard_controller.dart';
import 'package:getx_application/controllers/training_post/training_post_controller.dart';
import 'package:getx_application/widgets/custom_bar_chart.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/post_pelatihan_card.dart';
import 'package:get/get.dart';

class HomeLembagaPelatihanPage extends StatefulWidget {
  const HomeLembagaPelatihanPage({super.key});

  @override
  State<HomeLembagaPelatihanPage> createState() =>
      _HomeLembagaPelatihanPageState();
}

class _HomeLembagaPelatihanPageState extends State<HomeLembagaPelatihanPage> {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  final TrainingPostController trainingPostController =
      Get.put(TrainingPostController());

  @override
  void initState() {
    dashboardController.fetchTrainingDashboard();
    trainingPostController.fetchTrainingPost();
    super.initState();
  }

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
              Text(
                'Statistik Peserta',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _StatistikPeserta(
                controller: dashboardController,
              ),
              const SizedBox(height: 16),
              Text(
                'Pelatihan Diselenggarakan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              _PelatihanDiselenggarakan(
                controller: trainingPostController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatistikPeserta extends StatelessWidget {
  final DashboardController controller;

  const _StatistikPeserta({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final dashboardData = controller.trainingDashboardData.value;
      final dataValues = dashboardData.alumniJoined?.month != null
          ? parseMonthData(dashboardData.alumniJoined!.month!)
          : <String, double>{};

      return CustomBarChart(
          title: "Semua Pelatihan",
          subtitle: "Tahun ${dashboardData.alumniJoined?.year ?? 'N/A'}",
          dataValues: dataValues);
    });
  }
}

class _PelatihanDiselenggarakan extends StatelessWidget {
  final TrainingPostController controller;

  const _PelatihanDiselenggarakan({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final datas = controller.trainingPostData;

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: datas.length,
        itemBuilder: (context, index) {
          final data = datas[index];
          return CustomContainer(
            child: PostPelatihanCard(
              routingID: 20,
              id: data.id!,
              title: data.title!,
              description: data.description!,
              field: data.field!.name,
              date: formatTimestamp(data.createdAt!),
              points: data.point!.toString(),
              imageUrl: data.thumbnailUrl!,
              isLiked: data.isLiked ?? false,
              likesTotal: data.likesTotal ?? 0,
              updateLike: (bool isLiked) {
                controller.updateTrainingPostLike(
                  data.id!,
                  isLiked,
                );
              },
              commentsCount: data.commentsTotal!,
              canManage: false,
            ),
          );
        },
      );
    });
  }
}
