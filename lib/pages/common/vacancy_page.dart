import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:iconly/iconly.dart';
import 'package:getx_application/controllers/vacancy/vacancy_controller.dart';
import 'package:getx_application/models/vacancy/vacancy_model.dart';
import 'package:getx_application/widgets/infinite_scroll.dart';
import 'package:getx_application/widgets/vacancy_card.dart';

class VacancyPage extends StatefulWidget {
  final int routeID;
  const VacancyPage({super.key, required this.routeID});

  @override
  State<VacancyPage> createState() => _VacancyPageState();
}

class _VacancyPageState extends State<VacancyPage> {
  final VacancyController controller = Get.put(VacancyController());
  final ScrollController _scrollController = ScrollController();
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchVacancies();
    });
    _debouncer = Debouncer(delay: const Duration(seconds: 1));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.hasMoreItems && !controller.isLoadingMore.value) {
          controller.fetchVacancies(isLoadMore: true);
        }
      }
    });
  }

  void updateList(String value) {
    controller.searchKeyword.value = value;

    _debouncer(() {
      controller.fetchVacancies(keyword: value);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                'Cari Lowongan Pekerjaan',
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
          // const SizedBox(height: 20),
          // TextFormField(
          //   controller: _searchController,
          //   style: const TextStyle(fontSize: 14, fontFamily: 'Poppins-Light'),
          //   decoration: InputDecoration(
          //     prefixIcon: const Icon(IconlyLight.search),
          //     suffixIcon: IconButton(
          //         onPressed: () => _searchController.clear,
          //         icon: const Icon(IconlyLight.close_square)),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(10),
          //       borderSide: const BorderSide(
          //         color: Colors.blue,
          //         width: 2.0,
          //         style: BorderStyle.solid,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.vacancies.isEmpty) {
                  return Text(
                    'Data tidak ditemukan!',
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                }
                return Text(
                  '${controller.pagination.value.totalItems} Data Lowongan Ditemukan',
                  style: Theme.of(context).textTheme.displayLarge,
                );
              }),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshAlumniInTraining,
              child: InfiniteScrollList<VacancyModel>(
                scrollController: _scrollController,
                items: controller.vacancies,
                hasMoreItems: () => controller.hasMoreItems,
                isLoading: controller.isLoading,
                isLoadingMore: controller.isLoadingMore,
                fetchMoreItems: () =>
                    controller.fetchVacancies(isLoadMore: true),
                itemBuilder: (context, vacancy) {
                  return VacancyCard(
                    onTap: () => Get.toNamed('/vacancy/${vacancy.id}',
                        id: widget.routeID),
                    companyLogo: vacancy.company?.user?.imageUrl ?? '-',
                    companyName: vacancy.company?.companyName ?? '-',
                    earlyDateOfReceipt: vacancy.earlyDateOfReceipt ?? '-',
                    finalDateOfReceipt: vacancy.finalDateOfReceipt ?? '-',
                    level: vacancy.level?.name ?? '-',
                    thumbnailImage: vacancy.thumbnailUrl ?? '-',
                    position: vacancy.position ?? '-',
                    description: vacancy.description ?? '-',
                    isLiked: vacancy.isLiked ?? false,
                    likesTotal: vacancy.likesTotal ?? 0,
                    updateLike: (bool isLiked) {
                      controller.updateVacancyLike(
                        vacancy.id!,
                        isLiked,
                      );
                    },
                    fieldName: vacancy.field?.name ?? '-',
                    commentsTotal: vacancy.commentsTotal ?? 0,
                    appliedTotal: vacancy.appliedCount ?? 0,
                    minSalary: vacancy.minSalary ?? 0,
                    maxSalary: vacancy.maxSalary ?? 0,
                  );
                },
                bottomPadding: 40,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
