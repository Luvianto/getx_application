import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/common/utils/default_picture.dart';
import 'package:getx_application/controllers/vacancy/vacancy_comment_controller.dart';
import 'package:getx_application/controllers/vacancy/vacancy_controller.dart';
import 'package:getx_application/models/company/company_model.dart';
import 'package:getx_application/models/dashboard/alumni_dashboard_model.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/models/vacancy/vacancy_model.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/vacancy_details_card.dart';

class VacancyDetailsPage extends StatefulWidget {
  final String id;
  final int routeID;
  final String? applicationID;

  const VacancyDetailsPage(
      {super.key, required this.id, required this.routeID, this.applicationID});

  @override
  State<VacancyDetailsPage> createState() => _VacancyDetailsPageState();
}

class _VacancyDetailsPageState extends State<VacancyDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final VacancyController controller = Get.put(VacancyController());
  final VacancyCommentController commentsController =
      Get.put(VacancyCommentController());

  Rx<VacancyModel?> vacancyDetails = Rx(null);

  final TextEditingController commentDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.fetchVacancy(int.parse(widget.id));
    commentsController.fetchVacancyComments(widget.id);
    // });

    commentsController.postId = RxString(widget.id);
    main();
  }

  void main() async {
    await initializeDateFormatting('id');
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

      final VacancyModel vacancy = controller.vacancy.value;

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
                          Get.back(id: widget.routeID);
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
                      vacancy.position ?? '-',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                  ],
                ),
                const SizedBox(height: 20),
                VacancyDetailsCard(
                  id: vacancy.id ?? 0,
                  field: vacancy.field ?? Field.fromJson({}),
                  jobType: vacancy.jobType ?? JobType.fromJson({}),
                  incomeType: vacancy.incomeType ?? IncomeType.fromJson({}),
                  company: vacancy.company ?? CompanyModel.fromJson({}),
                  level: vacancy.level ?? LevelEnum.fromJson({}),
                  position: vacancy.position ?? '-',
                  thumbnailUrl: vacancy.thumbnailUrl ?? '-',
                  description: vacancy.description ?? '-',
                  earlyDateOfReceipt: vacancy.earlyDateOfReceipt ?? '-',
                  finalDateOfReceipt: vacancy.finalDateOfReceipt ?? '-',
                  minSalary: vacancy.minSalary ?? 0,
                  maxSalary: vacancy.maxSalary ?? 0,
                  appliedCount: vacancy.appliedCount ?? 0,
                  likesTotal: vacancy.likesTotal ?? 0,
                  commentsTotal: vacancy.commentsTotal ?? 0,
                  isApplied: vacancy.isApplied ?? false,
                  isLiked: vacancy.isLiked ?? false,
                  updateLike: (bool isLiked) {
                    controller.updateVacancyLike(
                      vacancy.id!,
                      isLiked,
                    );
                  },
                  routeID: widget.routeID,
                  applicationsID: int.parse(widget.applicationID ?? '0'),
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

                                        bool success = await commentsController
                                            .postVacancyComments();

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
                                  commentsController.commentDescription.value =
                                      value;
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
                )),
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
  final VacancyCommentController controller;

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
