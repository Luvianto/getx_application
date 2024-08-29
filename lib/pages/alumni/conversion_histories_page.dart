import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/controllers/conversion/conversion_controller.dart';
import 'package:getx_application/models/conversion/conversion_model.dart';
import 'package:getx_application/widgets/conversion_submission_card.dart';

class ConversionHistoriesPage extends StatefulWidget {
  const ConversionHistoriesPage({super.key});

  @override
  State<ConversionHistoriesPage> createState() =>
      _ConversionHistoriesPageState();
}

class _ConversionHistoriesPageState extends State<ConversionHistoriesPage> {
  final ConversionController controller = Get.put(ConversionController());

  @override
  void initState() {
    super.initState();
    controller.fetchConversions();
  }

  @override
  Widget build(BuildContext context) {
    final List<ConversionModel> conversions = controller.conversions;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back(id: 10);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  Text(
                    'Riwayat Konversi',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () =>
                    Get.toNamed('/point-conversion-application', id: 10),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xff25324A),
                ),
                child: const Text(
                  'Ajukan',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Poppins-SemiBold'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '3 sertifikat ditemukan',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () {},
                icon: const ImageIcon(
                  AssetImage('assets/icons/line/Filter.png'),
                ),
              )
            ],
          ),
          Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: conversions.length,
                      itemBuilder: (context, index) {
                        final conversion = conversions[index];
                        return ConversionSubmissionCard(
                          title: conversion.title,
                          organizer: conversion.organizer,
                          date: formatTimestamp(conversion.date),
                          certificateUrl: conversion.certificateUrl,
                          status: conversion.status,
                          createdAt: formatTimestamp(conversion.submittedAt),
                          point: conversion.pointGiven,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    ));
  }
}
