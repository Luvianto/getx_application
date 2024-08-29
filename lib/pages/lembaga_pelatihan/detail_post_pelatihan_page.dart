import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/common/utils/default_picture.dart';
import 'package:getx_application/controllers/training_post/training_post_comment_controller.dart';
import 'package:getx_application/controllers/training_post/training_post_controller.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/handle_picture_widget.dart';
import 'package:getx_application/widgets/like_button.dart';

class DetailPostPelatihanPage extends StatefulWidget {
  final int routeID;
  final String? id;

  const DetailPostPelatihanPage(
      {super.key, required this.id, required this.routeID});

  @override
  State<DetailPostPelatihanPage> createState() =>
      _DetailPostPelatihanPageState();
}

class _DetailPostPelatihanPageState extends State<DetailPostPelatihanPage> {
  final TrainingPostController postController =
      Get.put(TrainingPostController());
  final TrainingPostCommentController commentController =
      Get.put(TrainingPostCommentController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postController.fetchTrainingPostDetails(widget.id!);
      commentController.fetchTrainingPost(widget.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (postController.isLoadingDetails.value ||
          postController.trainingPostDetails.value.id == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final data = postController.trainingPostDetails.value;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 14),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: const ImageIcon(
                          AssetImage('assets/icons/line/Arrow_Left.png'),
                          size: 16,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Halaman Daftar Pelatihan',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/details', id: widget.routeID);
                                },
                                child: Text(
                                  data.field!.name,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppins-Semibold'),
                                ),
                              ),
                              Text(
                                formatTimestamp(data.createdAt!),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          if (widget.routeID == 23)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 35,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed('/edit/${data.id}',
                                          id: widget.routeID);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff25324A),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      handlePictureWidget(
                        imageUrl: data.thumbnailUrl,
                        height: 240,
                        width: 600,
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          LikeButton(
                            isLiked: data.isLiked ?? false,
                            likesTotal: data.likesTotal!,
                            updateLike: (bool isLiked) {
                              postController.updateTrainingPostLike(
                                data.id!,
                                isLiked,
                              );
                            },
                          ),
                          const SizedBox(width: 13),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 180, 180, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Row(
                                children: [
                                  const ImageIcon(
                                    AssetImage(
                                        'assets/icons/line/Arrow_Up.png'),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Text('${data.point} pts')
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          Text(
                            data.title!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          data.description!,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 13),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/list-peserta/${widget.id}',
                              id: widget.routeID);
                        },
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 180, 180, 180),
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Lihat Peserta')],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      if (widget.routeID == 23)
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/select-peserta', id: 23);
                          },
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 11, 165, 93),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tandakan Pelatihan Selesai',
                                    style: TextStyle(color: Color(0xffFFFFFF)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _Komentar(controller: commentController),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _Komentar extends StatelessWidget {
  final TrainingPostCommentController controller;

  const _Komentar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Komentar',
            style: TextStyle(fontSize: 15, fontFamily: 'Poppins-Semibold'),
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final comments = controller.commentData;

            if (comments.isEmpty) {
              return const Column(
                children: [
                  SizedBox(height: 14),
                  Center(
                    child: Text('Belum ada komentar',
                        style: TextStyle(
                            fontSize: 15, fontFamily: 'Poppins-Semibold')),
                  ),
                  SizedBox(height: 14),
                ],
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];

                return CustomContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          handleUserPicture(comment.user!.imageUrl!),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.user!.name!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Poppins-Semibold'),
                              ),
                              Text(
                                parseToTimeAgo(comment.createdAt!),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(comment.comment!),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
