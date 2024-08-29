import 'package:flutter/material.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/common/utils/default_picture.dart';
import 'package:getx_application/widgets/card_title.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

void openEmail(email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query: encodeQueryParameters(<String, String>{
      'subject': 'Menghubungi Melalui UVCE MApps',
      'body':
          'Hi Talent Terbaik UVCE, Saya menemukan akun mu di UVCE Mapps dan tertarik untuk mengobrol, apakah anda luang?',
    }),
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    // Handle the case where the URL cannot be launched
    print('Gagal mengirim email');
  }
}

class AlumniDetailCard extends StatelessWidget {
  final String name;
  final String title;
  final String description;
  final String salary;
  final String dateRange;
  final String position;
  final String company;
  final String level;
  final String? imageUrl;
  final String? graduationDate;
  final String? major;
  final String? gpa;
  final String? email;
  final List? fields;

  const AlumniDetailCard({
    super.key,
    required this.name,
    required this.title,
    required this.description,
    required this.salary,
    required this.dateRange,
    required this.position,
    required this.company,
    required this.level,
    this.graduationDate,
    this.major,
    this.gpa,
    this.imageUrl,
    this.email,
    this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  handleUserPicture(imageUrl!, size: 50),
                  const SizedBox(width: 10),
                  CardTitle(title: name, subtitle: title),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: fields?.length ?? 0,
            itemBuilder: (context, index) {
              final field = fields?[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  border: Border.all(color: const Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    const Icon(IconlyLight.chart),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${field.point} Poin diraih untuk bidang ${field.name}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'Informasi Pekerjaan',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                fontFamily: 'Poppins-Semibold'),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.37,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  border: Border.all(color: const Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text('Perusahaan'),
                    const SizedBox(height: 4),
                    Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffEDEDED),
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                              child: Icon(Icons.business,
                                  size: 16, color: Colors.grey),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                company,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                                overflow: TextOverflow.fade,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.37,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  border: Border.all(color: const Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text('Email'),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffEDEDED),
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                            child:
                                Icon(Icons.work, size: 16, color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              email ?? '-',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              overflow: TextOverflow.fade,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Informasi Alumni',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                fontFamily: 'Poppins-Semibold'),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.37,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  border: Border.all(color: const Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text('Program Studi'),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffEDEDED),
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                            child:
                                Icon(Icons.work, size: 16, color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              major ?? '-',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              overflow: TextOverflow.fade,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.37,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  border: Border.all(color: const Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text('IPK'),
                    const SizedBox(
                      height: 4,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffEDEDED),
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                            child: Icon(Icons.wallet,
                                size: 16, color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              gpa ?? '0',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              overflow: TextOverflow.fade,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.37,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  border: Border.all(color: const Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text('Tanggal Lulus'),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffEDEDED),
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                            child: Icon(Icons.date_range,
                                size: 16, color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              formatTimestamp(graduationDate ?? '-',
                                  isDateOnly: true),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              overflow: TextOverflow.fade,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Hubungi Peserta Ini',
            onTap: () {
              openEmail(email);
            },
          )
        ],
      ),
    );
  }
}
