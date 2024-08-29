import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/application/application_controller.dart';
import 'package:getx_application/controllers/vacancy/vacancy_controller.dart';
import 'package:getx_application/models/application/application_model.dart';
import 'package:getx_application/widgets/vacancy_card.dart';

class RiwayatLamaranPage extends StatefulWidget {
  const RiwayatLamaranPage({super.key});

  @override
  State<RiwayatLamaranPage> createState() => _RiwayatLamaranPageState();
}

class _RiwayatLamaranPageState extends State<RiwayatLamaranPage> {
  final ApplicationController controller = Get.put(ApplicationController());
  final VacancyController vacancyController = Get.put(VacancyController());

  @override
  void initState() {
    super.initState();
    controller.fetchApplications();
  }

  @override
  Widget build(BuildContext context) {
    final List<ApplicationModel> applications = controller.applications;

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Lamaran Pekerjaan Dikirim',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${applications.length} data ditemukan',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: applications.length,
                            itemBuilder: (context, index) {
                              final application = applications[index];
                              return VacancyCard(
                                onTap: () {
                                  Get.toNamed(
                                      '/tracking-lamaran/${application.id}',
                                      id: 14);
                                },
                                companyLogo: application
                                        .vacancy?.company?.user?.imageUrl ??
                                    '',
                                companyName:
                                    application.vacancy?.company?.companyName ??
                                        '-',
                                earlyDateOfReceipt:
                                    application.vacancy?.earlyDateOfReceipt ??
                                        '-',
                                finalDateOfReceipt:
                                    application.vacancy?.finalDateOfReceipt ??
                                        '-',
                                level: application.vacancy?.level?.name ?? '-',
                                thumbnailImage:
                                    application.vacancy?.thumbnailUrl ?? '-',
                                fieldName:
                                    application.vacancy?.field?.name ?? '-',
                                position: application.vacancy?.position ?? '-',
                                description:
                                    application.vacancy?.description ?? '-',
                                isShowLikeButton: false,
                                isLiked: application.vacancy?.isLiked ?? false,
                                likesTotal:
                                    application.vacancy?.likesTotal ?? 0,
                                updateLike: (bool isLiked) {
                                  vacancyController.updateVacancyLike(
                                    application.vacancy?.id! ?? 0,
                                    isLiked,
                                  );
                                },
                                commentsTotal:
                                    application.vacancy?.commentsTotal ?? 0,
                                appliedTotal:
                                    application.vacancy?.appliedCount ?? 0,
                                minSalary: application.vacancy?.minSalary ?? 0,
                                maxSalary: application.vacancy?.maxSalary ?? 0,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            )));
  }
}
