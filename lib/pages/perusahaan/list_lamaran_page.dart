import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/controllers/application/application_controller.dart';
import 'package:getx_application/controllers/vacancy/vacancy_controller.dart';
import 'package:getx_application/models/application/application_model.dart';
import 'package:getx_application/widgets/alumni_card.dart';

class ListLamaranPage extends StatefulWidget {
  final String id;
  final int routeID;
  const ListLamaranPage({super.key, required this.id, required this.routeID});

  @override
  State<ListLamaranPage> createState() => _ListLamaranPageState();
}

class _ListLamaranPageState extends State<ListLamaranPage> {
  final ApplicationController controller = Get.put(ApplicationController());
  final VacancyController vacancyController = Get.put(VacancyController());

  @override
  void initState() {
    super.initState();
    controller.fetchApplicationByVacancy(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final List<ApplicationModel> applications = controller.applications;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.back(id: widget.routeID);
                                },
                                child: const ImageIcon(
                                  AssetImage(
                                      'assets/icons/line/Arrow_Left.png'),
                                  size: 16,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Semua Lamaran Masuk',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  fontFamily: 'Poppins-Semibold'),
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
                              return AlumniCard(
                                name: application.alumni?.name ?? '-',
                                title:
                                    application.alumni?.focusField?.name ?? '-',
                                description:
                                    application.alumni?.user?.bio ?? '-',
                                dateRange: formatTimestamp(
                                    application.alumni?.graduationDate ?? '-',
                                    isDateOnly: true),
                                position: application.alumni?.major ?? '-',
                                company: application.alumni?.user?.companyData
                                        ?.companyName ??
                                    '-',
                                salary: '-', //not displayed
                                level: application.alumni?.focusField?.point ??
                                    '-',
                                imageUrl: application.alumni?.user?.imageUrl!,
                                id: application.alumni?.id.toString(),
                                routeID: widget.routeID,
                                applicationId: application.id.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            )));
  }
}
