import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/common/utils/default_picture.dart';
import 'package:getx_application/controllers/training_post/training_post_comment_controller.dart';
import 'package:getx_application/controllers/training_post/training_post_controller.dart';
import 'package:getx_application/models/training_post/training_post_model.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/training_details_card.dart';

class TrainingDetailsPage extends StatefulWidget {
  final String id;
  const TrainingDetailsPage({super.key, required this.id});

  @override
  State<TrainingDetailsPage> createState() => _TrainingsPageState();
}

class _TrainingsPageState extends State<TrainingDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TrainingPostController controller = Get.put(TrainingPostController());
  final TrainingPostCommentController commentsController =
      Get.put(TrainingPostCommentController());
  Rx<TrainingPostModel?> trainingPostDetails = Rx(null);

  final TextEditingController commentDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchTrainingPostDetails(widget.id);
    commentsController.fetchTrainingPost(widget.id);

    commentsController.postId = RxString(widget.id);
  }

  void clearForm() {
    commentDescriptionController.clear();
    commentsController.commentDescription.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingDetails.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final TrainingPostModel trainingPost =
          controller.trainingPostDetails.value;

      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      trainingPost.title!,
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                  ],
                ),
                const SizedBox(height: 20),
                TrainingDetailsCard(
                  id: trainingPost.id!,
                  title: trainingPost.title!,
                  createdAt: parseToTimeAgo(trainingPost.createdAt!),
                  commentsTotal: trainingPost.commentsTotal!,
                  description: trainingPost.description!,
                  institutionName:
                      trainingPost.trainingInstitution!.institutionName,
                  institutionLogo:
                      trainingPost.trainingInstitution!.institutionName,
                  likesTotal: trainingPost.likesTotal!,
                  thumbnailUrl: trainingPost.thumbnailUrl!,
                  point: trainingPost.point!,
                  isJoined: trainingPost.isJoined ?? false,
                  isLiked: trainingPost.isLiked ?? false,
                  updateLike: (bool isLiked) {
                    controller.updateTrainingPostLike(
                      trainingPost.id!,
                      isLiked,
                    );
                  },
                  joinedCount: trainingPost.joinedCount!,
                  field: trainingPost.field!.name,
                ),
                const SizedBox(height: 10),
                CustomContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tambah Komentar',
                        style: TextStyle(
                            fontSize: 15, fontFamily: 'Poppins-Semibold'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              constraints: const BoxConstraints(),
                              child: TextFormField(
                                controller: commentDescriptionController,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Light',
                                ),
                                maxLines: null,
                                decoration: InputDecoration(
                                  labelText: 'Masukan Komentar',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                      width: 2.0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(16.0),
                                  suffixIcon: Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.send,
                                          color: Colors.blue),
                                      onPressed: () async {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          _formKey.currentState!.save();

                                          bool success =
                                              await commentsController
                                                  .postTrainingComments();

                                          if (success) {
                                            clearForm();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                onSaved: (value) {
                                  if (value!.isNotEmpty) {
                                    commentsController
                                        .commentDescription.value = value;
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Harap Isi Komentar';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _Komentar(controller: commentsController),
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
              return const Center(
                child: Text('Belum ada komentar'),
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
