import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/controllers/training_post/training_post_controller.dart';
import 'package:getx_application/models/training_post/training_post_model.dart';
import 'package:getx_application/widgets/training_card.dart';
import 'package:iconly/iconly.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class TrainingsPage extends StatefulWidget {
  const TrainingsPage({super.key});

  @override
  State<TrainingsPage> createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingsPage> {
  final TrainingPostController controller = Get.put(TrainingPostController());
  final ScrollController _scrollController = ScrollController();
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTrainingPost();
    });
    _debouncer = Debouncer(delay: const Duration(seconds: 1));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.hasMoreItems && !controller.isLoadingMore.value) {
          controller.fetchTrainingPost(isLoadMore: true);
        }
      }
    });
  }

  void updateList(String value) {
    controller.searchKeyword.value = value;

    _debouncer(() {
      controller.fetchTrainingPost(keyword: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<TrainingPostModel> trainingPosts = controller.trainingPostData;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back(id: 10);
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
                  'Cari Pelatihan',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins-Semibold'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Search Bar Section
            TextField(
              onChanged: (value) {
                updateList(value);
              },
              style: Theme.of(context).textTheme.displayMedium,
              decoration: InputDecoration(
                hintText: 'Cari disini...',
                hintStyle: Theme.of(context).textTheme.displayMedium,
                prefixIcon: const Icon(IconlyLight.search),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xffF8F8F8), // Warna border saat tidak fokus
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(48),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xffEDEDED), // Warna border saat tidak fokus
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(48),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xffEDEDED), // Warna border saat fokus
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(48),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Text(
                          '${trainingPosts.length} data ditemukan',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                )
                // IconButton(
                //   onPressed: () {},
                //   icon: const ImageIcon(
                //     AssetImage('assets/icons/line/Filter.png'),
                //   ),
                // )
              ],
            ),
            const SizedBox(height: 10),
            Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: trainingPosts.length,
                        itemBuilder: (context, index) {
                          final trainingPost = trainingPosts[index];
                          return TrainingCard(
                            onTap: () => Get.toNamed(
                                "/trainings/${trainingPost.id}",
                                id: 10),
                            institutionLogo:
                                'assets/images/placeholder-image.jpg',
                            institutionName: trainingPost
                                    .trainingInstitution?.institutionName ??
                                '-',
                            thumbnailImage: trainingPost.thumbnailUrl ?? '-',
                            title: trainingPost.title ?? '-',
                            description: trainingPost.description ?? '-',
                            point: trainingPost.point ?? 0,
                            isLiked: trainingPost.isLiked ?? false,
                            likesTotal: trainingPost.likesTotal ?? 0,
                            updateLike: (bool isLiked) {
                              controller.updateTrainingPostLike(
                                trainingPost.id!,
                                isLiked,
                              );
                            },
                            commentsTotal: trainingPost.commentsTotal ?? 0,
                            createdAt: parseToTimeAgo(trainingPost.createdAt!),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
