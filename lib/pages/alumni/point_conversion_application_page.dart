// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:getx_application/common/utils/file_picker.dart';
import 'package:getx_application/controllers/conversion/conversion_controller.dart';
import 'package:getx_application/controllers/file/file_controller.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/widgets/custom_container.dart';

class PointConversionApplicationPage extends StatefulWidget {
  const PointConversionApplicationPage({super.key});

  @override
  State<PointConversionApplicationPage> createState() =>
      _PointConversionApplicationPageState();
}

class _PointConversionApplicationPageState
    extends State<PointConversionApplicationPage> {
  final ConversionController controller = Get.put(ConversionController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? _fileName;

  List<FieldEnum> items = [
    FieldEnum(id: '123', name: 'Loading...'),
    FieldEnum(id: '123', name: '')
  ];

  @override
  void initState() {
    super.initState();
    controller.fetchFields();
    items = controller.fieldEnum;
  }

  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController organizerTextEditingController =
      TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  TextEditingController descriptionTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back(id: 10);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  Text(
                    'Pengajuan Konversi Poin',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              CustomContainer(
                  child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => controller.title.value = value,
                      controller: titleTextEditingController,
                      style: const TextStyle(
                          fontSize: 14, fontFamily: 'Poppins-Light'),
                      decoration: InputDecoration(
                        labelText: 'Judul',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0, // Set border width
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Silakan masukkan judul sertifikat';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) => controller.organizer.value = value,
                      controller: organizerTextEditingController,
                      style: const TextStyle(
                          fontSize: 14, fontFamily: 'Poppins-Light'),
                      decoration: InputDecoration(
                        labelText: 'Penyelenggara',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0, // Set border width
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Silakan masukkan penyelenggara sertifikat';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: dateTextEditingController,
                      onChanged: (value) => controller.date.value = value,
                      style: const TextStyle(
                          fontSize: 14, fontFamily: 'Poppins-Light'),
                      decoration: InputDecoration(
                        labelText: 'Tanggal Sertifikat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0, // Set border width
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Silakan masukkan tanggal sertifikat';
                        }
                        return null;
                      },
                      onTap: () async {
                        final DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(DateTime.now().year + 3),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        );
                        if (dateTime != null) {
                          dateTextEditingController.text =
                              dateFormat.format(dateTime);
                          controller.date.value = dateFormat.format(dateTime);
                          FocusManager.instance.primaryFocus!.unfocus();
                        }
                      },
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus!.unfocus(),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: descriptionTextEditingController,
                      onChanged: (value) =>
                          controller.description.value = value,
                      style: const TextStyle(
                          fontSize: 14, fontFamily: 'Poppins-Light'),
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0, // Set border width
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Silakan masukkan deskripsi sertifikat';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    buildFilePicker(
                      uploadFile: (fileData) async {
                        final imageUrl =
                            await FileController().uploadFile(fileData);
                        controller.certificateUrl.value = imageUrl;
                      },
                      deleteFile: () async {
                        await FileController()
                            .deleteFile(controller.certificateUrl.value);
                      },
                      onFileNameChanged: (newFileName) {
                        setState(() {
                          _fileName = newFileName;
                        });
                      },
                      fileName: _fileName,
                    ),
                    const SizedBox(height: 20),
                    Obx(() => DropdownButtonFormField<String>(
                          value: controller.selectedField.value.isNotEmpty
                              ? controller.selectedField.value
                              : null,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectedField.value = newValue;
                            }
                          },
                          items: items.map((FieldEnum item) {
                            return DropdownMenuItem<String>(
                              value: item.id,
                              child: Text(item.name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Kategori',
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back(id: 10);
                          },
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Obx(() => ElevatedButton(
                              onPressed: controller
                                      .certificateUrl.value.isNotEmpty
                                  ? () {
                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        controller.createConversions();
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    controller.certificateUrl.value.isNotEmpty
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
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
