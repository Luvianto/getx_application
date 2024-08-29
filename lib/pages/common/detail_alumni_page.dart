import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/alumni/alumni_controller.dart';
import 'package:getx_application/models/alumni/alumni_model.dart';
import 'package:getx_application/widgets/alumni_detail_card.dart';

class DetailAlumniPage extends StatefulWidget {
  final String id;
  final int routeID;

  const DetailAlumniPage({super.key, required this.id, required this.routeID});

  @override
  State<DetailAlumniPage> createState() => _DetailAlumnisPageState();
}

class _DetailAlumnisPageState extends State<DetailAlumniPage> {
  final AlumniController controller = Get.put(AlumniController());

  @override
  void initState() {
    super.initState();
    controller.fetchAlumniDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingDetails.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final AlumniModel alumniDetail = controller.alumniDetails.value;

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back(id: widget.routeID);
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
                      'Kembali',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Poppins-Semibold'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                AlumniDetailCard(
                  name: alumniDetail.name ?? '-',
                  title: alumniDetail.focusField?.name ?? '-',
                  description: alumniDetail.user?.bio ?? '-',
                  salary: '-', //not displayed
                  dateRange: alumniDetail.graduationDate ?? '-',
                  position: '-', //currently static
                  company: alumniDetail.user?.companyData?.companyName ?? '-',
                  level: 'Expert Level', //currently static
                  imageUrl: alumniDetail.user?.imageUrl ?? '-',
                  gpa: alumniDetail.gpa != null
                      ? alumniDetail.gpa!.toString()
                      : '0',
                  graduationDate: alumniDetail.graduationDate ?? '-',
                  major: alumniDetail.major ?? '-',
                  email: alumniDetail.user?.email ?? '-',
                  fields: alumniDetail.fields,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
