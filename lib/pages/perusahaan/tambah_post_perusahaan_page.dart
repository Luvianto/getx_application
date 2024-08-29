import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:getx_application/controllers/vacancy/create_vacancy_controller.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/widgets/custom_container.dart';

class TambahPostPerusahaanPage extends StatefulWidget {
  const TambahPostPerusahaanPage({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<TambahPostPerusahaanPage> {
  final _formKey = GlobalKey<FormState>();
  final createVacancyController =
      Get.put<CreateVacancyController>(CreateVacancyController());

  final TextEditingController positionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController earlyDateOfReceiptController =
      TextEditingController();
  final TextEditingController finalDateOfReceiptController =
      TextEditingController();
  final TextEditingController minSalaryController = TextEditingController();
  final TextEditingController maxSalaryController = TextEditingController();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  List<FieldEnum> fields = [
    FieldEnum(id: 'kbdkabsdjsaw3da', name: 'Loading...'),
    FieldEnum(id: 'asdasdsadsadsad', name: '')
  ];

  List<JobType> jobTypes = [JobType(id: 0, name: 'Loading...')];

  List<IncomeType> incomeTypes = [IncomeType(id: 0, name: 'Loading...')];

  List<LevelEnum> skillLevels = [
    LevelEnum(id: 0, name: 'Loading...', minPoint: 0)
  ];

  @override
  void initState() {
    super.initState();
    createVacancyController.fetchFields();
    createVacancyController.fetchIncomeTypes();
    createVacancyController.fetchJobTypes();
    createVacancyController.fetchSkillLevels();
    fields = createVacancyController.fieldEnum;
    jobTypes = createVacancyController.jobTypeEnum;
    incomeTypes = createVacancyController.incomeTypeEnum;
    skillLevels = createVacancyController.skillLevelEnum;
  }

  void clearForm() {
    print('form cleared');
    positionController.clear();
    descriptionController.clear();
    earlyDateOfReceiptController.clear();
    finalDateOfReceiptController.clear();
    minSalaryController.clear();
    maxSalaryController.clear();

    createVacancyController.position.value = '';
    createVacancyController.description.value = '';
    createVacancyController.fileName.value = '';
    createVacancyController.earlyDateOfReceipt.value = '';
    createVacancyController.finalDateOfReceipt.value = '';
    createVacancyController.minSalary.value = 0;
    createVacancyController.maxSalary.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              Text(
                'Tambah Lowongan Pekerjaan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              CustomContainer(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: positionController,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Poppins-Light'),
                        decoration: InputDecoration(
                          labelText: 'Posisi Pekerjaan',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0, // Set border width
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            createVacancyController.position.value = value;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan posisi pekerjaan';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value:
                              createVacancyController.selectedJobType.value == 0
                                  ? createVacancyController
                                      .selectedJobType.value
                                      .toString()
                                  : null,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              createVacancyController.selectedJobType.value =
                                  int.tryParse(newValue)!;
                            }
                          },
                          items: jobTypes.map((JobType jobType) {
                            return DropdownMenuItem<String>(
                              value: jobType.id.toString(),
                              child: Text(jobType.name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Jenis Pekerjaan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2.0, // Set border width
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: createVacancyController
                                  .selectedField.value.isNotEmpty
                              ? createVacancyController.selectedField.value
                              : null,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              createVacancyController.selectedField.value =
                                  newValue;
                            }
                          },
                          items: fields.map((FieldEnum field) {
                            return DropdownMenuItem<String>(
                              value: field.id,
                              child: Text(field.name),
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
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: createVacancyController
                                      .selectedIncomeType.value ==
                                  0
                              ? createVacancyController.selectedIncomeType.value
                                  .toString()
                              : null,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              createVacancyController.selectedIncomeType.value =
                                  int.tryParse(newValue)!;
                            }
                          },
                          items: incomeTypes.map((IncomeType incomeType) {
                            return DropdownMenuItem<String>(
                              value: incomeType.id.toString(),
                              child: Text(incomeType.name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Jenis Upah',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2.0, // Set border width
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value: createVacancyController
                                      .selectedSkillLevel.value ==
                                  0
                              ? createVacancyController.selectedSkillLevel.value
                                  .toString()
                              : null,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              createVacancyController.selectedSkillLevel.value =
                                  int.tryParse(newValue)!;
                            }
                          },
                          items: skillLevels.map((LevelEnum skillLevel) {
                            return DropdownMenuItem<String>(
                              value: skillLevel.id.toString(),
                              child: Text(skillLevel.name),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Tingkat Keahlian',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2.0, // Set border width
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Pilih Gambar',
                          hintText: 'Pilih gambar yang akan diunggah',
                        ),
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(type: FileType.image);

                          if (result != null) {
                            setState(() {
                              createVacancyController.fileName.value =
                                  result.files.first.name;
                            });
                          }
                        },
                      ),
                      Obx(() => Text(
                            createVacancyController.fileName.value != ''
                                ? 'File yang dipilih: ${createVacancyController.fileName.value}'
                                : 'Tidak ada file yang dipilih',
                          )),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 6,
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
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            createVacancyController.description.value = value;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan deskripsi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: earlyDateOfReceiptController,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Poppins-Light'),
                        decoration: InputDecoration(
                          labelText: 'Tanggal Mulai Rekrutmen',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0, // Set border width
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            createVacancyController.earlyDateOfReceipt.value =
                                value;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Silakan masukkan tanggal mulai rekrutmen';
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
                            earlyDateOfReceiptController.text =
                                dateFormat.format(dateTime);
                            FocusManager.instance.primaryFocus!.unfocus();
                          }
                        },
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus!.unfocus(),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: finalDateOfReceiptController,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Poppins-Light'),
                        decoration: InputDecoration(
                          labelText: 'Tanggal Akhir Rekrutmen',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0, // Set border width
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            createVacancyController.finalDateOfReceipt.value =
                                value;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Silakan masukkan tanggal akhir rekrutmen';
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
                            finalDateOfReceiptController.text =
                                dateFormat.format(dateTime);

                            FocusManager.instance.primaryFocus!.unfocus();
                          }
                        },
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus!.unfocus(),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: minSalaryController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Poppins-Light'),
                        decoration: InputDecoration(
                          labelText: 'Gaji minimal',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0, // Set border width
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            createVacancyController.minSalary.value =
                                int.tryParse(value) ?? 0;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan gaji minimal';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: maxSalaryController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Poppins-Light'),
                        decoration: InputDecoration(
                          labelText: 'Gaji maksimal',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0, // Set border width
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          if (value!.isNotEmpty) {
                            createVacancyController.maxSalary.value =
                                int.tryParse(value) ?? 0;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan gaji maksimal';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _formKey.currentState!.save();
                                    print('Saved');
                                    bool success = await createVacancyController
                                        .postLowonganPekerjaan();
                                    print(success);
                                    if (success) {
                                      clearForm();
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff25324A),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(color: Color(0xffFFFFFF)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
