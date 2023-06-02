import 'package:dnd_order_app/class/class.dart';
import 'package:flutter/material.dart';

class BannerText extends StatefulWidget {
  BannerText({super.key, required this.curStore});

  Store curStore;

  @override
  State<BannerText> createState() => _BannerTextState();
}

class _BannerTextState extends State<BannerText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            '${widget.curStore.name}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 5,
          ),
          Text('가게 설명'),
        ],
      ),
    );
  }
}
