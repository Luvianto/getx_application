import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/const.dart';
import 'package:getx_application/common/utils/default_picture.dart';
import 'package:getx_application/controllers/profile/profile_controller.dart';
import 'package:getx_application/controllers/auth/signin_controller.dart';
import 'package:getx_application/models/auth.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/custom_info_label.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signInController = Get.put(SignInController());
    final profileController = Get.put(ProfileController());

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
                'Pengaturan',
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
                  final user = profileData['user'];
                  final labelName = "Nama ${profileController.userRole.value}";
                  final name = profileData['detailUtils']['name'];
                  final editId = profileData['detailUtils']['editId'];

                  return Column(
                    children: [
                      buildProfileHeader(user, name),
                      const SizedBox(height: 14),
                      CustomContainer(
                        child: Column(
                          children: [
                            buildEditProfileButton(editId),
                            const SizedBox(height: 14),
                            ...buildInfoLabels(user, labelName, name),
                            const SizedBox(height: 14),
                            CustomButton(
                              text: "Logout",
                              onTap: () {
                                signInController.signOut();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileHeader(UserModel user, String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xff25324A),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: Colors.grey[100],
            ),
            width: 80,
            height: 80,
            child: handleUserPicture(user.imageUrl ?? ''),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xffFFFFFF)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            (user.bio?.isEmpty ?? true) ? 'No bio available' : user.bio!,
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Color(0xffFFFFFF), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget buildEditProfileButton(int editId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 35,
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed('/edit-setting', id: editId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff25324A),
              elevation: 0,
            ),
            child: const Text(
              'Ubah Profil',
              style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildInfoLabels(UserModel user, String labelName, String name) {
    final infoData = [
      {'title': labelName, 'description': name},
      {
        'title': 'Bio',
        'description':
            user.bio?.isEmpty ?? true ? 'No bio available' : user.bio!
      },
    ];

    if (user.role.name == rolesMap['ALUMNI']) {
      infoData.add({
        'title': 'Bidang Kemampuan',
        'description': user.alumniData?.focusField?.name ?? '-'
      });
    }

    final locationData = [
      {
        'title': 'Negara',
        'description': user.country?.isEmpty ?? true ? '-' : user.country!
      },
      {
        'title': 'Provinsi',
        'description': user.province?.isEmpty ?? true ? '-' : user.province!
      },
      {
        'title': 'Kota / Kabupaten',
        'description': user.city?.isEmpty ?? true ? '-' : user.city!
      },
      {
        'title': 'Kecamatan',
        'description':
            user.subdistrict?.isEmpty ?? true ? '-' : user.subdistrict!
      },
    ];

    infoData.addAll(locationData);

    return infoData.map((data) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: CustomInfoLabel(
          title: data['title'] as String,
          description: data['description'] as String,
        ),
      );
    }).toList();
  }
}
