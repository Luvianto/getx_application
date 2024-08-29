import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/post_points.dart';

class DetailPostLowongan2Page extends StatelessWidget {
  const DetailPostLowongan2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 14),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back(id: 31);
                      },
                      child: const ImageIcon(
                        AssetImage('assets/icons/line/Arrow_Left.png'),
                        size: 16,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Next.js Fullstack - Intermediate',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'Poppins-Semibold'),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              CustomContainer(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Frontend Developer',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'Poppins-Semibold'),
                            ),
                            Text(
                              '23 Februari 2024',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/thumbnails/thumbnail_1.png',
                        height: 240,
                        width: 600,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 13),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostLabel(
                            title: '20k',
                            icon: AssetImage('assets/icons/line/Heart.png')),
                        SizedBox(
                          width: 13,
                        ),
                        PostLabel(
                            title: '29 Applied',
                            icon: AssetImage('assets/icons/line/Work.png')),
                        SizedBox(
                          width: 13,
                        ),
                        PostLabel(
                            title: 'Rp 14-16jt',
                            icon: AssetImage('assets/icons/line/Chart.png')),
                      ],
                    ),
                    const SizedBox(height: 13),
                    const Row(
                      children: [
                        Text(
                          'Next.js Fullstack - Intermediate',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies eget, sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies..',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 13),
                    const Text(
                      'Ultricies eget, sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 13),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed('/list-lamaran', id: 8);
                    //   },
                    //   child: InkWell(
                    //     child: Container(
                    //       padding: const EdgeInsets.symmetric(
                    //           vertical: 10, horizontal: 10),
                    //       decoration: BoxDecoration(
                    //           border: Border.all(
                    //             color: const Color.fromARGB(255, 180, 180, 180),
                    //           ),
                    //           borderRadius: BorderRadius.circular(8)),
                    //       child: const Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [Text('Lihat Semua Lamaran')],
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const CustomContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Komentar',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'Poppins-Semibold'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomContainer(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.person,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Siti Asiyah',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Poppins-Semibold'),
                                    ),
                                    Text(
                                      '30 Menit yang lalu',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'dolor sit amet, consectetur adipiscing elit. Ut in molestie dolor, ut gravida est. Donec neque erat, ultricies.')
                      ],
                    ))
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
