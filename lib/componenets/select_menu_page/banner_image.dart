import 'package:dnd_order_app/class/class.dart';
import 'package:flutter/material.dart';

class BannerImage extends StatefulWidget {
  const BannerImage({super.key, required this.curStore});

  final Store curStore;

  @override
  State<BannerImage> createState() => _BannerImageState();
}

class _BannerImageState extends State<BannerImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/${widget.curStore.name}.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
