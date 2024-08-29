import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/file_picker.dart';
import 'package:getx_application/controllers/application/kirim_lamaran_controller.dart';
import 'package:getx_application/controllers/file/file_controller.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';

class KirimLamaranPage extends StatefulWidget {
  const KirimLamaranPage({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<KirimLamaranPage> {
  String? _fileName;

  KirimLamaranController controller = Get.put(KirimLamaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back(id: 10);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                Expanded(
                  child: Text(
                    'Kirim Lamaran Pekerjaan',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),
            CustomContainer(
              child: Column(
                children: [
                  buildFilePicker(
                    uploadFile: (fileData) async {
                      final imageUrl =
                          await FileController().uploadFile(fileData);
                      controller.fileUrl.value = imageUrl;
                    },
                    deleteFile: () async {
                      await FileController()
                          .deleteFile(controller.fileUrl.value);
                    },
                    onFileNameChanged: (newFileName) {
                      setState(() {
                        _fileName = newFileName;
                      });
                    },
                    fileName: _fileName,
                  ),
                  const SizedBox(height: 16),
                  Obx(() => SizedBox(
                        child: CustomButton(
                          text: 'Kirim Lamaran',
                          onTap: controller.fileUrl.value.isNotEmpty
                              ? () {
                                  controller.postApplication(
                                      controller.selectedVacancyId.value);
                                }
                              : null,
                          isDisabled: controller.fileUrl.value.isEmpty,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
