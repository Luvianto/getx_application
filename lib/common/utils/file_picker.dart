import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Column buildFilePicker({
  required Function(Map<String, dynamic>) uploadFile,
  required Function? deleteFile,
  required Function(String) onFileNameChanged,
  required String? fileName,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        readOnly: true,
        decoration: const InputDecoration(
          labelText: 'Pilih File',
          hintText: 'Pilih file yang akan diunggah',
        ),
        controller: TextEditingController(text: fileName),
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            final newFileName = result.files.first.name;
            onFileNameChanged(newFileName);

            final filePath = result.files.first.path;

            if (filePath != null) {
              final file = File(filePath);

              final fileData = {
                'file': await file.readAsBytes(),
                'fileName': newFileName,
              };

              if (deleteFile != null) await deleteFile();
              await uploadFile(fileData);
            }
          }
        },
      ),
    ],
  );
}
