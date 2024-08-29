import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:iconly/iconly.dart';
import 'package:getx_application/common/utils/date_parser.dart';
import 'package:getx_application/controllers/alumni/alumni_controller.dart';
import 'package:getx_application/models/alumni/alumni_model.dart';
import 'package:getx_application/widgets/alumni_card.dart';
import 'package:getx_application/widgets/infinite_scroll.dart';

class CariAlumniPage extends StatefulWidget {
  final int routeID;

  const CariAlumniPage({super.key, required this.routeID});

  @override
  State<CariAlumniPage> createState() => _CariAlumniPageState();
}

class _CariAlumniPageState extends State<CariAlumniPage> {
  final AlumniController controller = Get.put(AlumniController());
  final ScrollController _scrollController = ScrollController();
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAlumni();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (controller.hasMoreItems && !controller.isLoadingMore.value) {
          controller.fetchAlumni(isLoadMore: true);
        }
      }
    });

    _debouncer = Debouncer(delay: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void updateList(String value) {
    controller.searchKeyword.value = value;

    _debouncer(() {
      controller.fetchAlumni(keyword: value);
    });
  }

  Future<void> _refreshTrainingPost() async {
    controller.currentPage = 1;
    controller.alumniData.clear();
    await controller.fetchAlumni();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: [
              Row(
                children: [
                  if (widget.routeID == 8)
                    GestureDetector(
                        onTap: () {
                          Get.back(id: widget.routeID);
                        },
                        child: const ImageIcon(
                          AssetImage('assets/icons/line/Arrow_Left.png'),
                          size: 16,
                        )),
                  if (widget.routeID == 8)
                    const SizedBox(
                      width: 20,
                    ),
                  Text(
                    'Cari Alumni',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Search Bar Section
              TextField(
                onChanged: (value) => updateList(value),
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
              const SizedBox(height: 14),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshAlumnis,
                  child: InfiniteScrollList<AlumniModel>(
                    scrollController: _scrollController,
                    items: controller.alumniData,
                    hasMoreItems: () => controller.hasMoreItems,
                    isLoading: controller.isLoading,
                    isLoadingMore: controller.isLoadingMore,
                    fetchMoreItems: () =>
                        controller.fetchAlumni(isLoadMore: true),
                    itemBuilder: (context, data) {
                      return AlumniCard(
                        name: data.name!,
                        title: data.focusField?.name ?? '-',
                        description: data.user?.bio ?? '-',
                        dateRange: formatTimestamp(data.graduationDate ?? '-',
                            isDateOnly: true),
                        position: data.major!,
                        company: data.user?.companyData?.companyName ?? '-',
                        salary: '-', //not displayed
                        level: data.focusField?.point ?? '-',
                        imageUrl: data.user?.imageUrl!,
                        id: data.id.toString(),
                        routeID: widget.routeID,
                      );
                    },
                    bottomPadding: 40,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
