import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/auth/register_alumni_controller.dart';
import 'package:getx_application/controllers/auth/signup_controller.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/header_text.dart';

class RegisterAlumniScreen extends StatefulWidget {
  const RegisterAlumniScreen({super.key});

  @override
  State<RegisterAlumniScreen> createState() => _RegisterAlumniScreenState();
}

class _RegisterAlumniScreenState extends State<RegisterAlumniScreen> {
  final RegisterAlumniController controller =
      Get.put(RegisterAlumniController());

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _studentController = TextEditingController();
  final TextEditingController _gpaController = TextEditingController();

  late Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    String password = Get.find<SignUpController>().password.value;
    String email = Get.find<SignUpController>().email.value;
    String phoneNumber = Get.find<SignUpController>().phoneNumber.value;
    userData = Get.arguments ??
        {
          "user": {"phone": phoneNumber, "email": email, "password": password},
          "name": "",
          "university_name": "",
          "gpa": 0,
          "graduation_date": "",
          "major": "",
          "pddikti_student_id": ""
        };
    print("userdata: $userData");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Register Alumni'),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 80),
          // padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const HeaderText(
                //   title: "Masukkan universitas Anda",
                //   subtitle: "Lalu pilih universitas yang telah Anda tempuh",
                // ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back(id: 1);
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
                      'Lengkapi Informasi Akun Alumni',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Poppins-Semibold'),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                CustomContainer(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Cari dan Pilih Perguruan Tinggi Anda',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => TextFormField(
                        controller: _universityController,
                        onChanged: (value) {
                          controller.isSelectingUniversity.value = false;
                          controller.universityName.value = value;
                        },
                        readOnly: controller.universityId.value.isNotEmpty,
                        decoration: InputDecoration(
                          labelText: 'University Name',
                          border: const OutlineInputBorder(),
                          suffixIcon: controller.universityId.value.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _universityController.clear();
                                    controller.universityId.value = '';
                                    controller.isSelectingUniversity.value =
                                        false;
                                    controller.students.clear();
                                    controller.studentNim.value = '';
                                    controller.isSelectingStudent.value = false;
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Obx(
                      () => controller.isLoadingUniversities.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.universities.isEmpty
                              ? const Text('')
                              : Column(
                                  children: controller.universities.map((univ) {
                                    return ListTile(
                                      title: Text(univ.namaPt),
                                      onTap: () {
                                        controller.isSelectingUniversity.value =
                                            true;
                                        controller.universityName.value =
                                            univ.namaPt;
                                        controller.universityId.value =
                                            univ.idSp;
                                        _universityController.text =
                                            univ.namaPt;
                                        controller.universities.clear();
                                        _studentController.clear();
                                      },
                                    );
                                  }).toList(),
                                ),
                    ),
                    // const SizedBox(height: 16.0),
                    Obx(
                      () => controller.universityId.value.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Masukan Nomor Induk dan Pilih Data Mahasiswa Anda',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              ],
                            )
                          // ? const HeaderText(
                          //     title: "Masukkan NIM",
                          //     subtitle:
                          //         "Lalu pilih nama yang sesuai dengan nama Anda",
                          //   )
                          : Container(),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => controller.universityId.value.isNotEmpty
                          ? TextFormField(
                              controller: _studentController,
                              onChanged: (value) {
                                controller.studentNim.value = value;
                              },
                              readOnly: controller.isSelectingStudent.value,
                              decoration: InputDecoration(
                                labelText: 'NIM',
                                hintText: 'Masukkan NIM Anda',
                                border: const OutlineInputBorder(),
                                suffixIcon: controller.isSelectingStudent.value
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          _studentController.clear();
                                          controller.isSelectingStudent.value =
                                              false;
                                        },
                                      )
                                    : null,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tolong masukkan NIM yang sesuai';
                                }
                                return null;
                              },
                            )
                          : Container(),
                    ),
                    const SizedBox(height: 16.0),
                    Obx(
                      () => controller.isLoadingStudents.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.students.isEmpty
                              ? const Text('')
                              : Column(
                                  children: controller.students.map((student) {
                                    return ListTile(
                                      title: Text(student.nama),
                                      onTap: () async {
                                        controller.isSelectingStudent.value =
                                            true;
                                        controller.students.clear();
                                        controller.studentName.value =
                                            student.nama;
                                        controller.studentId = student.id;
                                        controller.studentMajor =
                                            student.namaProdi;
                                        _studentController.text = student.nim;
                                      },
                                    );
                                  }).toList(),
                                ),
                    ),
                    // const SizedBox(height: 16.0),
                    Obx(
                      () => controller.isSelectingStudent.value
                          ? const HeaderText(
                              title: "Konfirmasi Data",
                              subtitle: "Lengkapi data yang diperlukan",
                            )
                          : Container(),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => controller.isSelectingStudent.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  initialValue: controller.studentName.value,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Nama',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  initialValue: controller.studentMajor,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Program Studi',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 32.0),
                                TextFormField(
                                  controller: _gpaController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  decoration: const InputDecoration(
                                    labelText: 'GPA',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    final parsedValue = double.tryParse(value);
                                    if (parsedValue != null) {
                                      controller.gpa.value = parsedValue;
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your GPA';
                                    }
                                    if (double.tryParse(value) == null) {
                                      return 'Please enter a valid GPA';
                                    } else {
                                      if (double.tryParse(value)! > 5.0) {
                                        return 'Tolong masukan GPA yang valid';
                                      }
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*')),
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Obx(() => Text(
                                            controller.graduationDate.value
                                                    .isEmpty
                                                ? 'Select Graduation Date'
                                                : 'Graduation Date: ${controller.graduationDate.value}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          )),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () => controller
                                          .pickGraduationDate(context),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    const SizedBox(height: 16.0),
                    Obx(
                      () => controller.isSelectingStudent.value
                          ? CustomButton(
                              text: "Konfirmasi",
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  controller.phoneNumber.value =
                                      userData["user"]["phone"];
                                  controller.email.value =
                                      userData["user"]["email"];
                                  controller.password.value =
                                      userData["user"]["password"];
                                  controller.registerAlumni();
                                }
                              },
                            )
                          : Container(),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
