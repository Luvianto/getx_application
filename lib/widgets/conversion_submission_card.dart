import 'package:flutter/material.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/handle_picture_widget.dart';

class ConversionSubmissionCard extends StatelessWidget {
  final String title;
  final String organizer;
  final String date;
  final String certificateUrl;
  final String? description;
  final String createdAt;
  final int point;
  final int status;

  const ConversionSubmissionCard(
      {super.key,
      required this.title,
      required this.organizer,
      required this.date,
      required this.certificateUrl,
      this.description,
      required this.status,
      required this.createdAt,
      required this.point});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  Text(createdAt),
                ],
              ),
              status == 1
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 244, 244, 244),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          ImageIcon(
                            AssetImage('assets/icons/line/bar_chart.png'),
                          ),
                          Text(
                            'Diproses',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    )
                  : status == 2
                      ? Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 65, 159, 153),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              ImageIcon(
                                AssetImage('assets/icons/line/bar_chart.png'),
                                color: Colors.white,
                              ),
                              Text(
                                'Diterima',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              )
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 189, 53, 53),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              ImageIcon(
                                AssetImage('assets/icons/line/bar_chart.png'),
                                color: Colors.white,
                              ),
                              Text(
                                'Ditolak',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              )
                            ],
                          ),
                        )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            width: MediaQuery.of(context).size.width * 1,
            height: 180,
            child: handlePictureWidget(
              imageUrl: certificateUrl,
              height: 240,
              width: 600,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            runSpacing: 5,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 180, 180, 180),
                    ),
                    borderRadius: BorderRadius.circular(100)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ImageIcon(
                      AssetImage('assets/icons/line/Work.png'),
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(organizer)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 180, 180, 180),
                    ),
                    borderRadius: BorderRadius.circular(100)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ImageIcon(
                      AssetImage('assets/icons/line/Arrow_Up.png'),
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(date)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              status != 0
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 180, 180, 180),
                          ),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ImageIcon(
                            AssetImage('assets/icons/line/Arrow_Up.png'),
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text('$point poin')
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
