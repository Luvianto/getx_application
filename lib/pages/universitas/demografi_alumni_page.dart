import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:getx_application/controllers/insight/insight_controller.dart';
import 'package:getx_application/widgets/custom_card.dart';

class DemografiAlumniPage extends StatefulWidget {
  const DemografiAlumniPage({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<DemografiAlumniPage> {
  // final _formKey = GlobalKey<FormState>();
  // String name = '';
  // String email = '';
  // String? selectedValue;

  // List<String> items = ['Seniority', 'Lokasi', 'Skala Perusahaan'];

  final InsightController controller = Get.put(InsightController());

  @override
  void initState() {
    super.initState();
    controller.fetchInsightByFields();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final insightByFields = controller.insightByFieldsData.value;
      final all = insightByFields.totalAlumni?.all ?? 0;
      final withoutField = insightByFields.totalAlumni?.withoutFocusField ?? 0;

      final otherPersentage = withoutField / all * 100;

      NumberFormat formatPersen = NumberFormat.percentPattern();

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
                      'Demografi Alumni',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Poppins-Semibold'),
                    ),
                  ],
                ),
                // const SizedBox(height: 14),
                // DropdownButtonFormField<String>(
                //   value: selectedValue,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedValue = newValue!;
                //     });
                //   },
                //   items: items.map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   decoration: InputDecoration(
                //     labelText: 'Seniority',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: const BorderSide(
                //         color: Colors.blue,
                //         width: 2.0, // Set border width
                //         style: BorderStyle.solid,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 24),
                // CustomContainer(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       CardTitle(
                //         title: 'Total Alumni',
                //         subtitle: "${insightByFields.totalAlumni?.all}",
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 20),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: insightByFields.fields?.length,
                          itemBuilder: (context, index) {
                            final field = insightByFields.fields?[index];
                            final current = field?.total ?? 0;
                            final total = insightByFields.totalAlumni?.all ?? 0;
                            final persentage = current / total * 100;

                            return CustomCard(
                              title: field?.name ?? '-',
                              subtitle:
                                  '${field?.total} - ${formatPersen.format(persentage / 100)}',
                              listWidget: [
                                LinearProgressIndicator(
                                  value: persentage / 100,
                                  color: const Color.fromARGB(255, 22, 24, 22),
                                ),
                              ],
                            );
                          },
                        ),
                ),
                CustomCard(
                  title: 'Lainnya',
                  subtitle:
                      '${insightByFields.totalAlumni?.withoutFocusField} - ${formatPersen.format(otherPersentage / 100)}',
                  listWidget: [
                    LinearProgressIndicator(
                      value: otherPersentage / 100,
                      color: const Color.fromARGB(255, 22, 24, 22),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
