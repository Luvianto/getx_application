import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/controllers/auth/register_company_controller.dart';
import 'package:getx_application/controllers/auth/signup_controller.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';

class RegisterCompanyScreen extends StatefulWidget {
  const RegisterCompanyScreen({super.key});

  @override
  State<RegisterCompanyScreen> createState() => _RegisterCompanyScreenState();
}

class _RegisterCompanyScreenState extends State<RegisterCompanyScreen> {
  final RegisterCompanyController controller =
      Get.put(RegisterCompanyController());

  final _formKey = GlobalKey<FormState>();

  List<CompanyType> items = [
    CompanyType(id: 0, name: 'Startup'),
    CompanyType(id: 1, name: 'Goverment'),
    CompanyType(id: 2, name: 'Foreign')
  ];

  @override
  void initState() {
    super.initState();
    controller.password.value = Get.find<SignUpController>().password.value;
    controller.email.value = Get.find<SignUpController>().email.value;
    controller.phoneNumber.value =
        Get.find<SignUpController>().phoneNumber.value;
    items = controller.companyTypes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 80),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    const Expanded(
                        child: Text(
                      'Lengkapi Informasi Akun Perusahaan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Poppins-Semibold'),
                    )),
                  ],
                ),
                const SizedBox(height: 30.0),
                CustomContainer(
                    child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Perusahaan',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    onSaved: (value) {
                      if (value != null) {
                        controller.companyName.value = value;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan nama perusahaan';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Tipe Perusahaan',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedType.value.toString(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.selectedType.value =
                                int.tryParse(newValue) ?? 0;
                          }
                        },
                        items: items.map((CompanyType item) {
                          return DropdownMenuItem<String>(
                            value: item.id.toString(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal Berdiri',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => Text(
                              controller.foundingDate.value.isEmpty
                                  ? 'Belum dipilih'
                                  : controller.foundingDate.value,
                              style: Theme.of(context).textTheme.bodyLarge,
                            )),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => controller.pickFoundingDate(context),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Jumlah Karyawan',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Karyawan',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      if (value != null) {
                        controller.employeesNumber.value =
                            int.tryParse(value) ?? 0;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Jumlah Karyawan';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Jam Mulai Kerja',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jam Mulai Kerja',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      if (value != null) {
                        controller.earlyWorkingHours.value =
                            int.tryParse(value) ?? 0;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Jam Mulai Kerja';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Jam Pulang Kerja',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jam Pulang Kerja',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      if (value != null) {
                        controller.endWorkingHours.value =
                            int.tryParse(value) ?? 0;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Jam Pulang Kerja';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    text: "Konfirmasi",
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState!.save();
                        controller.registerCompany();
                      }
                    },
                  ),
                ])),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
