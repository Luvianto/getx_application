import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/dashboard_controller.dart';
import 'package:getx_application/controllers/training_post/training_post_controller.dart';
import 'package:getx_application/controllers/vacancy/vacancy_controller.dart';
import 'package:getx_application/models/training_post/training_post_model.dart';
import 'package:getx_application/models/vacancy/vacancy_model.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/interesting_training_card.dart';
import 'package:getx_application/widgets/vacancy_card.dart';

class AlumniHomePage extends StatefulWidget {
  final String? id;
  final int routeID;
  const AlumniHomePage({super.key, this.id, required this.routeID});

  @override
  State<AlumniHomePage> createState() => _AlumniHomePageState();
}

class _AlumniHomePageState extends State<AlumniHomePage> {
  final controller = Get.put<DashboardController>(DashboardController());

  final vacancyController = Get.put<VacancyController>(VacancyController());
  final trainingPostController =
      Get.put<TrainingPostController>(TrainingPostController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAlumniDashboard();
      trainingPostController.fetchTrainingPost();
      vacancyController.fetchVacancies();
    });
    vacancyController.fetchVacancies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (vacancyController.hasMoreItems &&
            !vacancyController.isLoadingMore.value) {
          vacancyController.fetchVacancies(isLoadMore: true);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<TrainingPostModel> trainingPosts =
        trainingPostController.trainingPostData;
    final List<VacancyModel> vacancies = vacancyController.vacancies;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          CustomContainer(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 7),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 248, 248),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final dashboardData = controller.alumniDashboardData.value;

                    final skillLevels = [
                      {'level': 'Beginner', 'minPoints': 0},
                      {'level': 'Intermediate', 'minPoints': 200},
                      {'level': 'Advanced', 'minPoints': 400},
                      {'level': 'Expert', 'minPoints': 600},
                      {'level': 'Master', 'minPoints': 800},
                    ];

                    double points =
                        (dashboardData.field?.point ?? 0).toDouble();
                    double stars = (points / 200).clamp(0, 5);

                    Object skillLevel = skillLevels.lastWhere((level) =>
                        points >= (level['minPoints'] as num))['level']!;

                    return Column(
                      children: [
                        RatingBar.builder(
                          initialRating: stars,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_rate_rounded,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                          ignoreGestures: true,
                        ),
                        Text(
                          'Skill Level - $skillLevel (${points.toInt()} points)',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    );
                  }),
                ),
                Obx(() {
                  final dashboardData = controller.alumniDashboardData.value;
                  return Text(
                    dashboardData.field?.name != null
                        ? 'Bidang ${dashboardData.field!.name}'
                        : 'Belum ada Bidang!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  );
                }),
                Text(
                  'Ikuti lebih banyak pelatihan untuk naik level',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 14),
                CustomButton(
                  onTap: () => Get.toNamed('/conversion-histories', id: 10),
                  text: 'Konversi Sertifikat',
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                child: CustomContainer(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 7),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 248, 248, 248),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(() {
                          final dashboardData =
                              controller.alumniDashboardData.value;
                          return Text(
                            dashboardData.recommendedVacancy?.total != null
                                ? '${dashboardData.recommendedVacancy!.total.toString()} Lowongan'
                                : 'Tidak ada lowongan',
                            style: Theme.of(context).textTheme.titleLarge,
                          );
                        }),
                      ),
                      Text(
                        'Cocok Untukmu',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text('Tersedia Sekarang',
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Lihat Detail',
                        onTap: () =>
                            Get.toNamed('/list-vacancy', id: widget.routeID),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                child: CustomContainer(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 7),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 248, 248, 248),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(() {
                          final dashboardData =
                              controller.alumniDashboardData.value;
                          return Text(
                            dashboardData.recommendedTraining?.total != null
                                ? '${dashboardData.recommendedTraining!.total.toString()} Pelatihan'
                                : 'Tidak ada Pelatihan',
                            style: Theme.of(context).textTheme.titleLarge,
                          );
                        }),
                      ),
                      Text(
                        'Cocok Untukmu',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text('Tersedia Sekarang',
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Lihat Detail',
                        onTap: () =>
                            Get.toNamed('/trainings', id: widget.routeID),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pelatihan Menarik',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              GestureDetector(
                onTap: () => Get.toNamed('/trainings', id: widget.routeID),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xff25324A))),
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded),
                      Text('Cari Pelatihan',
                          style: Theme.of(context).textTheme.titleMedium),
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
              () => trainingPostController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: trainingPosts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16.0),
                      itemBuilder: (context, index) {
                        final trainingPost = trainingPosts[index];
                        return InterestingTrainingCard(
                            onTap: () => Get.toNamed(
                                '/trainings/${trainingPost.id}',
                                id: widget.routeID),
                            title: trainingPost.title!,
                            trainingType: trainingPost.field?.name ?? '-',
                            point: trainingPost.point!,
                            image: trainingPost.thumbnailUrl!);
                      },
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Lowongan Pekerjaan',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Obx(
            () => vacancyController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vacancies.length,
                    itemBuilder: (context, index) {
                      final vacancy = vacancies[index];
                      return VacancyCard(
                        onTap: () => Get.toNamed('/vacancy/${vacancy.id}',
                            id: widget.routeID),
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
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
