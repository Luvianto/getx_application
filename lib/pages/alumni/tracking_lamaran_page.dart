import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/controllers/application/application_controller.dart';
import 'package:getx_application/models/application/application_model.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_card.dart';
import 'package:getx_application/widgets/custom_container.dart';

class TrackingLamaranPage extends StatefulWidget {
  final String id;
  final int routeID;
  const TrackingLamaranPage(
      {super.key, required this.id, required this.routeID});

  @override
  State<TrackingLamaranPage> createState() => _TrackingLamaranPageState();
}

class _TrackingLamaranPageState extends State<TrackingLamaranPage> {
  final ApplicationController controller = Get.put(ApplicationController());
  Rx<ApplicationModel?> applicationDetails = Rx(null);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // String? _fileName;

  List<ApplicationStage> items = [
    ApplicationStage(id: 1, name: 'Loading...'),
    ApplicationStage(id: 2, name: '')
  ];

  @override
  void initState() {
    controller.fetchApplicationByID(widget.id);
    controller.fetchApplicationStages();

    items = controller.fieldEnum;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingDetails.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final ApplicationModel application = controller.applicationDetails.value;

      return Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back(id: widget.routeID);
                      },
                      child: const ImageIcon(
                        AssetImage('assets/icons/line/Arrow_Left.png'),
                        size: 16,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Text(
                    'Tracking Lamaran',
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                ],
              ),
              const SizedBox(height: 20),
              if (widget.routeID != 8)
                CustomContainer(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                          "${application.vacancy?.position} - ${application.vacancy?.company?.companyName}",
                          style: Theme.of(context).textTheme.displayLarge),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Lihat Detail',
                        onTap: () => Get.toNamed(
                            '/vacancy/${application.vacancy?.id}/${application.id}',
                            id: widget.routeID),
                      ),
                    ])),
              if (widget.routeID == 8)
                CustomContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Update Status',
                        style: TextStyle(
                            fontSize: 15, fontFamily: 'Poppins-Semibold'),
                      ),
                      const SizedBox(height: 10),
                      Obx(() => DropdownButtonFormField<String>(
                            value: controller.selectedField.value.isNotEmpty
                                ? controller.selectedField.value
                                : null,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.selectedField.value = newValue;
                              }
                            },
                            items: items.map((ApplicationStage item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(item.name),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Status',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2.0, // Set border width
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => ElevatedButton(
                            onPressed: controller.selectedField.value.isNotEmpty
                                ? () {
                                    controller.updateApplicationStatus(
                                        widget.id,
                                        application.vacancy?.id.toString() ??
                                            '0');
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  controller.selectedField.value.isNotEmpty
                                      ? const Color(0xff25324A)
                                      : Colors.grey,
                              elevation: 0,
                            ),
                            child: const Text(
                              'Simpan',
                              style: TextStyle(color: Color(0xffFFFFFF)),
                            ),
                          )),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: application.applicationJourney?.length,
                itemBuilder: (context, index) {
                  final journey = application.applicationJourney?[index];

                  return CustomCard(
                    title: journey?.name ?? '-',
                    subtitle: formatTimestamp(journey?.date ?? '-'),
                    listWidget: const [
                      LinearProgressIndicator(
                        value: 1,
                        color: Color.fromARGB(255, 6, 147, 6),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ));
    });
  }
}
