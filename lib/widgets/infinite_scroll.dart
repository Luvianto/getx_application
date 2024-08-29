import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfiniteScrollList<T> extends StatelessWidget {
  final ScrollController scrollController;
  final RxList<T> items;
  final bool Function() hasMoreItems;
  final RxBool isLoading;
  final RxBool isLoadingMore;
  final Future<void> Function() fetchMoreItems;
  final Widget Function(BuildContext, T) itemBuilder;
  final double bottomPadding;

  const InfiniteScrollList({
    super.key,
    required this.scrollController,
    required this.items,
    required this.hasMoreItems,
    required this.isLoading,
    required this.isLoadingMore,
    required this.fetchMoreItems,
    required this.itemBuilder,
    this.bottomPadding = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value && items.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.only(bottom: bottomPadding),
        itemCount: items.length + (hasMoreItems() ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return itemBuilder(context, items[index]);
        },
      );
    });
  }
}
