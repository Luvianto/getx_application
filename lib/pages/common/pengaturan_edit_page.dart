import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/const.dart';
import 'package:getx_application/common/utils/file_picker.dart';
import 'package:getx_application/controllers/profile/profile_controller.dart';
import 'package:getx_application/controllers/profile/profile_edit_controller.dart';
import 'package:getx_application/models/abstract.dart';
import 'package:getx_application/models/alumni/alumni_model.dart';
import 'package:getx_application/models/auth.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/models/wilayah/wilayah_model.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/common/utils/default_picture.dart';

class PengaturanEditPage extends StatefulWidget {
  const PengaturanEditPage({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<PengaturanEditPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String bio = '';
  String? _fileName;
  String image = '';
  String? selectedField;
  String? selectedCountry;
  String? selectedProvince;
  String? selectedProvinceCode;
  String? selectedCity;
  String? selectedCityCode;
  String? selectedSubdistrict;
  String? selectedSubdistrictCode;
  String? role;
  UserModel? profileDataUser;

  List<String> items = ['Indonesia'];

  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();

    role = profileController.userRole.value;
    final profileData = profileController.profileData.value;
    final profileDataDetail = profileData!['detail'] as DetailModel;
    if (profileData['user'] is UserModel) {
      profileDataUser = profileData['user'] as UserModel;
    }

    if (role == rolesMap['ALUMNI']) {
      final alumniDetail = profileDataDetail as AlumniModel;
      selectedField = alumniDetail.focusField?.id.isEmpty ?? true
          ? null
          : alumniDetail.focusField?.id;
    }

    selectedCountry = profileDataUser?.country?.isEmpty ?? true
        ? null
        : profileDataUser?.country;
    selectedProvince = profileDataUser?.province?.isEmpty ?? true
        ? null
        : profileDataUser?.province;
    selectedCity =
        profileDataUser?.city?.isEmpty ?? true ? null : profileDataUser?.city;
    selectedSubdistrict = profileDataUser?.subdistrict?.isEmpty ?? true
        ? null
        : profileDataUser?.subdistrict;
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final profileEditController = Get.put(ProfileEditController());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),
                Text(
                  'Ubah Profil',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 14),
                Obx(() {
                  if (profileController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (profileController.profileData.value == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final profileData = profileController.profileData.value!;
                    final detailUtils = profileData['detailUtils'];
                    var profileName = detailUtils['name'];
                    var key = detailUtils['key'];
                    var editId = detailUtils['editId'];

                    final updatedImageUrl =
                        profileEditController.updatedImageUrl.value;
                    return CustomContainer(
                      child: Column(
                        children: [
                          buildTextFormField(
                            initialValue: profileName,
                            labelText: "Nama $role",
                            onSaved: (value) => name = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            enabled: !(role == rolesMap['ALUMNI'] ||
                                role == rolesMap['UNIVERSITAS']),
                          ),
                          const SizedBox(height: 16),
                          buildFilePicker(
                            uploadFile: (fileData) async {
                              await profileEditController.uploadFile(fileData);
                            },
                            deleteFile: () async {
                              await profileEditController.deleteFile(
                                  profileEditController.updatedImageUrl.value);
                            },
                            onFileNameChanged: (newFileName) {
                              setState(() {
                                _fileName = newFileName;
                              });
                            },
                            fileName: _fileName,
                          ),
                          const SizedBox(height: 16),
                          handleUserPicture(
                              updatedImageUrl != ''
                                  ? updatedImageUrl
                                  : profileDataUser?.imageUrl ?? '',
                              size: 300),
                          const SizedBox(height: 16),
                          buildTextFormField(
                            initialValue: profileDataUser?.bio ?? '',
                            labelText: 'Bio',
                            onSaved: (value) => bio = value!,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your bio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ...buildDropdowns(),
                          const SizedBox(height: 16),
                          buildActionButtons(
                              editId, key, profileEditController),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField({
    required String initialValue,
    required String labelText,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    bool enabled = true,
  }) {
    return TextFormField(
      initialValue: initialValue,
      style: const TextStyle(fontSize: 14, fontFamily: 'Poppins-Light'),
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
      enabled: enabled,
    );
  }

  List<Widget> buildDropdowns() {
    final dropdownData = [];

    final profileEditController = Get.put(ProfileEditController());
    final List<FieldEnum> fields = profileEditController.fields;
    final List<WilayahModel> provinces = profileEditController.provinces;
    final List<WilayahModel> regencies = profileEditController.regencies;
    final List<WilayahModel> districts = profileEditController.districts;

    if (role == rolesMap['ALUMNI']) {
      dropdownData.add({
        'value': fields.any((field) => field.id == selectedField)
            ? selectedField
            : null,
        'label': 'Bidang Kemampuan',
        'onChanged': (String? newValue) {
          setState(() {
            selectedField = newValue;
          });
        },
        'items': fields.map<DropdownMenuItem<String>>((field) {
          return DropdownMenuItem<String>(
            value: field.id,
            child: Text(field.name),
          );
        }).toList(),
        'enabled': true,
      });
    }

    dropdownData.addAll([
      {
        'value': items.contains(selectedCountry) ? selectedCountry : null,
        'label': 'Negara',
        'onChanged': (String? newValue) =>
            setState(() => selectedCountry = newValue),
        'items': items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        'enabled': false,
      },
      {
        'value': provinces.any((province) => province.name == selectedProvince)
            ? selectedProvince
            : null,
        'label': 'Provinsi',
        'onChanged': (String? newValue) async {
          setState(() {
            selectedProvince = newValue;
            selectedCity = '';
            selectedCityCode = '';
            selectedSubdistrict = '';
            selectedSubdistrictCode = '';
            selectedProvinceCode = provinces
                .firstWhere(
                  (province) => province.name == newValue,
                )
                .code;
          });
          await profileEditController
              .fetchRegenciesByProvince(selectedProvinceCode!);
        },
        'items': provinces.map<DropdownMenuItem<String>>((province) {
          return DropdownMenuItem<String>(
            value: province.name,
            child: Text(province.name),
          );
        }).toList(),
        'enabled': true,
      },
      {
        'value': regencies.any((regency) => regency.name == selectedCity)
            ? selectedCity
            : null,
        'label': 'Kota',
        'onChanged': (String? newValue) async {
          setState(() {
            selectedCity = newValue;
            selectedSubdistrict = '';
            selectedSubdistrictCode = '';
            selectedCityCode = regencies
                .firstWhere(
                  (regency) => regency.name == newValue,
                )
                .code;
          });
          await profileEditController.fetchDistrictsByCity(selectedCityCode!);
        },
        'items': regencies.map<DropdownMenuItem<String>>((regency) {
          return DropdownMenuItem<String>(
            value: regency.name,
            child: Text(regency.name),
          );
        }).toList(),
        'enabled': selectedProvince != null,
      },
      {
        'value':
            districts.any((district) => district.name == selectedSubdistrict)
                ? selectedSubdistrict
                : null,
        'label': 'Kecamatan',
        'onChanged': (String? newValue) async {
          setState(() {
            selectedSubdistrict = newValue;
            selectedSubdistrictCode = districts
                .firstWhere(
                  (district) => district.name == newValue,
                )
                .code;
          });
        },
        'items': districts.map<DropdownMenuItem<String>>((district) {
          return DropdownMenuItem<String>(
            value: district.name,
            child: Text(district.name),
          );
        }).toList(),
        'enabled': selectedCity != null,
      },
    ]);

    return dropdownData.map((data) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: DropdownButtonFormField<String>(
          value: data['value'],
          onChanged: data['enabled']
              ? data['onChanged'] as void Function(String?)?
              : null,
          items: data['items'] as List<DropdownMenuItem<String>>,
          decoration: InputDecoration(
            labelText: data['label'] as String,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
          ),
          disabledHint: data['label'] == 'Negara'
              ? const Text('Indonesia')
              : Text('Pilih ${data['label']}'),
        ),
      );
    }).toList();
  }

  Row buildActionButtons(
    var editId,
    var key,
    ProfileEditController profileEditController,
  ) {
    final profileEditController = Get.put(ProfileEditController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Get.back(id: editId);
          },
          child: const Text(
            'Kembali',
            style: TextStyle(fontSize: 15),
          ),
        ),
        const SizedBox(width: 15),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              final updateData = <String, dynamic>{
                'image_url': profileEditController.updatedImageUrl.value != ''
                    ? profileEditController.updatedImageUrl.value
                    : profileDataUser?.imageUrl,
                'bio': bio,
                'country': 'Indonesia',
                'province': selectedProvince ?? profileDataUser?.province,
                'city': selectedCity ?? '',
                'subdistrict': selectedSubdistrict ?? '',
              };

              if (role == rolesMap['ALUMNI']) {
                updateData['field'] = {"id": selectedField};
              }

              if (role != rolesMap['ALUMNI'] &&
                  role != rolesMap['UNIVERSITAS']) {
                updateData[key] = name;
              }

              profileEditController.updateProfile(updateData);
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
    );
  }
}
