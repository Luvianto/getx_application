import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_application/app/common/widgets/custom_button.dart';
import 'package:getx_application/app/controller/create/alumni_create_controller.dart';

class AlumniCreatePage extends GetView<AlumniCreateController> {
  const AlumniCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lengkapi Informasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Masukkan Universitas Anda'),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextFormField(
                    onTap: () {
                      controller.isSelectingUniversity.value = true;
                    },
                    onChanged: (value) {
                      controller.universityName.value = value;
                    },
                    readOnly: controller.universityId.value.isNotEmpty,
                    decoration: InputDecoration(
                      hintText: 'Universitas Indonesia...',
                      border: const OutlineInputBorder(),
                      suffixIcon: controller.universityId.value.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: controller.deleteUniversityName,
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
                                  onTap: () {},
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
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          ],
                        )
                      : Container(),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => controller.universityId.value.isNotEmpty
                      ? TextFormField(
                          controller: controller.alumniController,
                          onChanged: (value) {
                            controller.nim.value = value;
                          },
                          readOnly: controller.isSelectingAlumni.value,
                          decoration: InputDecoration(
                            labelText: 'NIM',
                            hintText: 'Masukkan NIM Anda',
                            border: const OutlineInputBorder(),
                            suffixIcon: controller.isSelectingAlumni.value
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {},
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
                  () => controller.isLoadingAlumnis.value
                      ? const Center(child: CircularProgressIndicator())
                      : controller.alumnis.isEmpty
                          ? const Text('')
                          : Column(
                              children: controller.alumnis.map((student) {
                                return ListTile(
                                  title: Text(student.nama),
                                  onTap: () async {},
                                );
                              }).toList(),
                            ),
                ),
                Obx(
                  () => controller.isSelectingAlumni.value
                      ? const Text(
                          "Konfirmasi Data Lengkapi data yang diperlukan",
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => controller.isSelectingAlumni.value
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
                              controller: controller.gpaController,
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
                                        controller.graduationDate.value.isEmpty
                                            ? 'Select Graduation Date'
                                            : 'Graduation Date: ${controller.graduationDate.value}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () =>
                                      controller.pickGraduationDate(context),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                ),
                const SizedBox(height: 16.0),
                Obx(
                  () => controller.isSelectingAlumni.value
                      ? CustomButton(
                          text: "Konfirmasi",
                          onTap: () {
                            if (controller.formKey.currentState?.validate() ??
                                false) {}
                          },
                        )
                      : Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
