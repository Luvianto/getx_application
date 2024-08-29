import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/common/utils/default_picture.dart';
import 'package:getx_application/controllers/application/kirim_lamaran_controller.dart';
import 'package:getx_application/models/company/company_model.dart';
import 'package:getx_application/models/dashboard/alumni_dashboard_model.dart';
import 'package:getx_application/models/enums.dart';
import 'package:getx_application/widgets/custom_button.dart';
import 'package:getx_application/widgets/custom_container.dart';
import 'package:getx_application/widgets/handle_picture_widget.dart';
import 'package:getx_application/widgets/like_button.dart';
import 'package:getx_application/widgets/post_points.dart';

class VacancyDetailsCard extends StatelessWidget {
  final RxInt id;
  final Field field;
  final JobType jobType;
  final IncomeType incomeType;
  final CompanyModel company;
  final LevelEnum level;
  final String position;
  final String thumbnailUrl;
  final String description;
  final String earlyDateOfReceipt;
  final String finalDateOfReceipt;
  final int minSalary;
  final int maxSalary;
  final int appliedCount;
  final int likesTotal;
  final int commentsTotal;
  final bool isApplied;
  final bool isLiked;
  final Function(bool isLiked) updateLike;
  final int routeID;
  final int? applicationsID;

  VacancyDetailsCard({
    super.key,
    required int id,
    required this.field,
    required this.jobType,
    required this.incomeType,
    required this.company,
    required this.level,
    required this.position,
    required this.thumbnailUrl,
    required this.description,
    required this.earlyDateOfReceipt,
    required this.finalDateOfReceipt,
    required this.minSalary,
    required this.maxSalary,
    required this.appliedCount,
    required this.likesTotal,
    required this.commentsTotal,
    required this.isApplied,
    required this.isLiked,
    required this.updateLike,
    required this.routeID,
    this.applicationsID,
  }) : id = id.obs;

  @override
  Widget build(BuildContext context) {
    KirimLamaranController controller = Get.put(KirimLamaranController());

    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.companyName,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Expanded(
                        child: Text(
                          "${formatTimestamp(earlyDateOfReceipt)} - ${formatTimestamp(finalDateOfReceipt)}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ))
                ],
              ),
              handleUserPicture(company.user?.imageUrl ?? '-')
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            width: MediaQuery.of(context).size.width * 1,
            height: 180,
            child: Center(
              child: handlePictureWidget(
                imageUrl: thumbnailUrl,
                height: 240,
                width: 600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              IntrinsicWidth(
                child: LikeButton(
                  isLiked: isLiked,
                  likesTotal: likesTotal,
                  updateLike: updateLike,
                ),
              ),
              IntrinsicWidth(
                child: PostLabel(
                    title: field.name ?? '-',
                    icon: const AssetImage('assets/icons/line/Arrow_Up.png')),
              ),
              IntrinsicWidth(
                child: PostLabel(
                    title: "$appliedCount Pelamar",
                    icon: const AssetImage('assets/icons/line/Work.png')),
              ),
              if (minSalary != 0 && maxSalary != 0)
                IntrinsicWidth(
                  child: PostLabel(
                      title: "Rp $minSalary - $maxSalary",
                      icon: const AssetImage('assets/icons/line/Filter.png')),
                ),
              IntrinsicWidth(
                child: PostLabel(
                    title: incomeType.name,
                    icon: const AssetImage('assets/icons/line/Chat.png')),
              ),
              IntrinsicWidth(
                child: PostLabel(
                    title: "${level.name} Level",
                    icon: const AssetImage('assets/icons/line/bar_chart.png')),
              )
            ],
          ),
          const SizedBox(height: 18),
          Text("$position - ${jobType.name}",
              style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 18),
          if (!isApplied && routeID != 8)
            CustomButton(
              text: 'Kirim Lamaran',
              onTap: () => {
                Get.toNamed('/kirim-lamaran', id: routeID),
                controller.selectedVacancyId = id,
              },
            ),
          if (routeID == 8)
            CustomButton(
              text: 'Lihat Lamaran Masuk',
              onTap: () => {
                Get.toNamed('/list-lamaran/$id', id: routeID),
              },
            ),
          if (isApplied && applicationsID != 0)
            CustomButton(
              text: 'Tracking Lamaran',
              onTap: () {
                Get.toNamed('/tracking-lamaran/$applicationsID', id: routeID);
              },
            ),
        ],
      ),
    );
  }
}
