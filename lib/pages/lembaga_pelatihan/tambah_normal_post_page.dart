import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/widgets/custom_container.dart';

class TambahNormalPostPage extends StatefulWidget {
  const TambahNormalPostPage({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<TambahNormalPostPage> {
  // final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String? selectedValue;
  String? _fileName;
  List<String> items = [
    'Frontend Developer',
    'Mobile Developer',
    'Web Developer'
  ];

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
                'Tambah Post Biasa',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              CustomContainer(
                child: Column(
                  children: [
                    TextFormField(
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
                        name = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
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
                            _fileName = result.files.first.name;
                          });
                        }
                      },
                    ),
                    Text('File yang dipilih: $_fileName'),
                    const SizedBox(height: 16),
                    TextFormField(
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
                        name = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back(id: 21);
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
                            ElevatedButton(
                              onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
