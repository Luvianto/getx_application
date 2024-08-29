import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/post/tambah_post_controller.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/widgets/custom_container.dart';

class TambahPostPage extends StatefulWidget {
  const TambahPostPage({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<TambahPostPage> {
  final _formKey = GlobalKey<FormState>();
  final postController = Get.put<TambahPostController>(TambahPostController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pointController = TextEditingController();

  List<FieldEnum> items = [
    FieldEnum(id: 'kbdkabsdjsaw3da', name: 'Loading...'),
    FieldEnum(id: 'asdasdsadsadsad', name: '')
  ];

  @override
  void initState() {
    super.initState();
    postController.fetchFields();
    items = postController.fieldEnum;
  }

  void clearForm() {
    print('form cleared');
    titleController.clear();
    descriptionController.clear();
    pointController.clear();

    postController.title.value = '';
    postController.description.value = '';
    postController.point.value = 0;
    postController.selectedField.value = '';
    postController.fileName.value = '';
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
                'Tambah Post Pelatihan',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              CustomContainer(
                child: Form(
                  key: _formKey, // Ensure the form key is attached here
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Poppins-Light'),
                        decoration: InputDecoration(
                          labelText: 'Judul Pelatihan',
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
                            postController.title.value = value;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan Judul';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Obx(() => DropdownButtonFormField<String>(
                            value: postController.selectedField.value.isNotEmpty
                                ? postController.selectedField.value
                                : null,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                postController.selectedField.value = newValue;
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
                      const SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Pilih File',
                          hintText: 'Pilih file yang akan diunggah',
                        ),
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            setState(() {
                              postController.fileName.value =
                                  result.files.first.name;
                            });
                          }
                        },
                      ),
                      Obx(() => Text(
                            postController.fileName.value != ''
                                ? 'File yang dipilih: ${postController.fileName.value}'
                                : 'Tidak ada file yang dipilih',
                          )),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: descriptionController,
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
                            postController.description.value = value;
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
                        controller: pointController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'Poppins-Light'),
                        decoration: InputDecoration(
                          labelText: 'Poin',
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
                            postController.point.value =
                                int.tryParse(value) ?? 0;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan point';
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
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/post-biasa', id: 21);
                                },
                                child: const Text(
                                  'Tambah Post Biasa',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _formKey.currentState!.save();
                                    print('Saved');
                                    bool success =
                                        await postController.postTraining();
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
