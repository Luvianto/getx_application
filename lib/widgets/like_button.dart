import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final int likesTotal;
  final Function(bool isLiked) updateLike;

  const LikeButton({
    super.key,
    required this.isLiked,
    required this.likesTotal,
    required this.updateLike,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isLiked;
  late int likesTotal;
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likesTotal = widget.likesTotal;
    _debouncer = Debouncer(delay: const Duration(seconds: 1));
  }

  void updateLike() {
    setState(() {
      if (isLiked) {
        isLiked = false;
        likesTotal--;
      } else {
        isLiked = true;
        likesTotal++;
      }
    });

    _debouncer(() {
      widget.updateLike(isLiked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        updateLike;
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 180, 180, 180),
              ),
              borderRadius: BorderRadius.circular(100)),
          child: GestureDetector(
            onTap: updateLike,
            child: Row(
              children: [
                isLiked
                    ? const Icon(
                        Icons.favorite,
                        size: 16,
                        color: Colors.red,
                      )
                    : const ImageIcon(
                        AssetImage('assets/icons/line/Heart.png'),
                        size: 16,
                      ),
                const SizedBox(width: 5),
                Text('$likesTotal'),
              ],
            ),
          )),
    );
  }
}
