import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/file_picker.dart';
import 'package:getx_application/controllers/enums/field_controller.dart';
import 'package:getx_application/controllers/file/file_controller.dart';
import 'package:getx_application/controllers/training_post/training_post_controller.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/widgets/custom_container.dart';

class EditPostPage extends StatefulWidget {
  final int routeID;
  final String? id;

  const EditPostPage({super.key, this.id, required this.routeID});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<EditPostPage> {
  final _formKey = GlobalKey<FormState>();
  final TrainingPostController postController =
      Get.put(TrainingPostController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postController.fetchTrainingPostDetails(widget.id ?? '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (postController.isLoadingDetails.value ||
          postController.trainingPostDetails.value.id == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      postController.trainingPostTempEdit = postController.trainingPostDetails;
      var details = postController.trainingPostTempEdit.value;

      final bool isHasApplicants = (details.joinedCount ?? 0) > 0;

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
                          Get.back(id: widget.routeID);
                        },
                        child: const ImageIcon(
                          AssetImage('assets/icons/line/Arrow_Left.png'),
                          size: 16,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Halaman Kelola',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Poppins-Semibold'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Edit Post Pelatihan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 14),
                CustomContainer(
                  child: Column(
                    children: [
                      isHasApplicants
                          ? const Center(
                              child: Text(
                                'Kamu hanya bisa membuka atau menutup post, karena sudah ada yang mendaftar',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : _EditPostForm(details: details, formKey: _formKey),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Checkbox(
                              value: details.isClosed ?? false,
                              onChanged: (bool? value) {
                                setState(() {
                                  details.isClosed = value ?? false;
                                });
                              },
                            ),
                            const Text(
                              'Tutup Post?',
                              style: TextStyle(fontSize: 14),
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (!isHasApplicants) {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      _formKey.currentState!.save();
                                      postController.updateTrainingPost();
                                    }
                                  } else {
                                    postController.updateTrainingPostStatus();
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
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _EditPostForm extends StatefulWidget {
  final dynamic details;
  final GlobalKey<FormState> formKey;

  const _EditPostForm({required this.details, required this.formKey});

  @override
  __EditPostFormState createState() => __EditPostFormState();
}

class __EditPostFormState extends State<_EditPostForm> {
  final FieldController fieldController = Get.put(FieldController());
  final TrainingPostController postController =
      Get.put(TrainingPostController());
  final FileController fileController = Get.put(FileController());

  String _fileName = '';

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pointController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fieldController.fetchFields();
    });
    titleController.text = widget.details.title ?? '';
    descriptionController.text = widget.details.description ?? '';
    pointController.text = widget.details.point?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            style: const TextStyle(fontSize: 14, fontFamily: 'Poppins-Light'),
            decoration: InputDecoration(
              labelText: 'Judul Pelatihan',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onSaved: (value) {
              if (value!.isNotEmpty) {
                widget.details.title = value;
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
          Obx(() {
            if (fieldController.isLoading.value ||
                fieldController.fields.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return DropdownButtonFormField<String>(
              value: widget.details.field?.id,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  widget.details.field!.id = newValue;
                }
              },
              items: fieldController.fields.map((FieldEnum item) {
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
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          buildFilePicker(
            uploadFile: (fileData) async {
              final imageUrl = await fileController.uploadFile(fileData);
              widget.details.thumbnailUrl = imageUrl;
            },
            deleteFile: () async {
              await fileController.deleteFile(widget.details.thumbnailUrl);
            },
            onFileNameChanged: (newFileName) {
              setState(() {
                _fileName = newFileName;
              });
            },
            fileName: _fileName,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            style: const TextStyle(fontSize: 14, fontFamily: 'Poppins-Light'),
            decoration: InputDecoration(
              labelText: 'Deskripsi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onSaved: (value) {
              if (value!.isNotEmpty) {
                widget.details.description = value;
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
            style: const TextStyle(fontSize: 14, fontFamily: 'Poppins-Light'),
            decoration: InputDecoration(
              labelText: 'Poin',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onSaved: (value) {
              if (value!.isNotEmpty) {
                widget.details.point = int.tryParse(value) ?? 0;
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
        ],
      ),
    );
  }
}
