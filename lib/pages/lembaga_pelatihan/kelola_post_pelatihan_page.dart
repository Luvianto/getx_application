import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/controllers/training_post/training_post_controller.dart';
import 'package:getx_application/models/training_post/training_post_model.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/infinite_scroll.dart';
import 'package:getx_application/widgets/post_pelatihan_card.dart';

class KelolaPostPelatihanPage extends StatefulWidget {
  const KelolaPostPelatihanPage({super.key});

  @override
  State<KelolaPostPelatihanPage> createState() =>
      _KelolaPostPelatihanPageState();
}

class _KelolaPostPelatihanPageState extends State<KelolaPostPelatihanPage> {
  final TrainingPostController controller = Get.put(TrainingPostController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.hasMoreItems && !controller.isLoadingMore.value) {
          controller.fetchTrainingPost(isLoadMore: true);
        }
      }
    });
    controller.fetchTrainingPost();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshTrainingPost() async {
    controller.currentPage = 1;
    controller.trainingPostData.clear();
    await controller.fetchTrainingPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<void>(
          future: controller.fetchTrainingPost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            return RefreshIndicator(
              onRefresh: _refreshTrainingPost,
              child: InfiniteScrollList<TrainingPostModel>(
                scrollController: _scrollController,
                items: controller.trainingPostData,
                hasMoreItems: () => controller.hasMoreItems,
                isLoading: controller.isLoading,
                isLoadingMore: controller.isLoadingMore,
                fetchMoreItems: () =>
                    controller.fetchTrainingPost(isLoadMore: true),
                itemBuilder: (context, data) {
                  return CustomContainer(
                    child: PostPelatihanCard(
                      routingID: 23,
                      id: data.id!,
                      title: data.title!,
                      description: data.description!,
                      field: data.field!.name,
                      date: parseToTimeAgo(data.createdAt!),
                      points: data.point.toString(),
                      imageUrl: data.thumbnailUrl!,
                      isLiked: data.isLiked ?? false,
                      likesTotal: data.likesTotal ?? 0,
                      updateLike: (bool isLiked) {
                        controller.updateTrainingPostLike(
                          data.id!,
                          isLiked,
                        );
                      },
                      commentsCount: data.commentsTotal!,
                      canManage: true,
                      editDestination: data.id!,
                      deleteDestination: data.id!,
                    ),
                  );
                },
                bottomPadding: 40,
              ),
            );
          },
        ),
      ),
    );
  }
}
