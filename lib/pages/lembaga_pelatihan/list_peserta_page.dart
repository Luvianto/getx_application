import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/default_picture.dart';
import 'package:getx_application/controllers/alumni_in_trainings/alumni_in_trainings_controller.dart';
import 'package:getx_application/models/alumni_in_training/alumni_in_training_model.dart';
import 'package:getx_application/widgets/card_title.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/infinite_scroll.dart';

class ListPesertaPage extends StatefulWidget {
  final int routeID;
  final String? id;

  const ListPesertaPage({super.key, this.id, required this.routeID});

  @override
  State<ListPesertaPage> createState() => _ListPesertaPageState();
}

class _ListPesertaPageState extends State<ListPesertaPage> {
  AlumniInTrainingsController? controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(AlumniInTrainingsController(id: widget.id!));
    controller?.fetchAlumniInTrainings(widget.id!);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller!.hasMoreItems && !controller!.isLoadingMore.value) {
          controller?.fetchAlumniInTrainings(widget.id!, isLoadMore: true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/details/${widget.id}', id: widget.routeID);
                  },
                  child: const ImageIcon(
                    AssetImage('assets/icons/line/Arrow_Left.png'),
                    size: 16,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Post Pelatihan',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins-Semibold'),
                )
              ],
            ),
            const SizedBox(height: 14),
            Obx(() {
              if (controller!.alumniInTrainings.isEmpty) {
                return Text(
                  '0 Data Peserta Ditemukan',
                  style: Theme.of(context).textTheme.displayLarge,
                );
              }
              return Text(
                '${controller!.pagination.value.totalItems} Data Peserta Ditemukan',
                style: Theme.of(context).textTheme.displayLarge,
              );
            }),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller!.refreshAlumniInTraining,
                child: InfiniteScrollList<AlumniInTrainingModel>(
                  scrollController: _scrollController,
                  items: controller!.alumniInTrainings,
                  hasMoreItems: () => controller!.hasMoreItems,
                  isLoading: controller!.isLoading,
                  isLoadingMore: controller!.isLoadingMore,
                  fetchMoreItems: () => controller!
                      .fetchAlumniInTrainings(widget.id!, isLoadMore: true),
                  itemBuilder: (context, alumniData) {
                    final alumni = alumniData.alumni;
                    if (alumni == null) {
                      return const Text('Data Alumni Tidak Ditemukan');
                    }
                    return CustomContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  handleUserPicture(alumni.user!.imageUrl!,
                                      size: 50),
                                  const SizedBox(width: 10),
                                  CardTitle(
                                      title: alumni.name!,
                                      subtitle: alumni.focusField == null
                                          ? 'Belum ada bidang'
                                          : alumni.focusField!.name),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            alumni.user?.bio ?? 'Belum ada bio',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  height: 1.5,
                                ),
                          ),
                          const SizedBox(height: 12),
                          CustomButton(
                            text: 'Lihat Detail',
                            onTap: () {
                              Get.toNamed('/detail-peserta/${alumni.id}',
                                  id: widget.routeID);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  bottomPadding: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
