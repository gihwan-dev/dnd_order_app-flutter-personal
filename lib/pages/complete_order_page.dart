import 'package:dnd_order_app/componenets/complete_order_page/order_detail.dart';
import 'package:dnd_order_app/componenets/complete_order_page/top_banner.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CompleteOrderPage extends StatelessWidget {
  const CompleteOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: BLUE,
        ),
        backgroundColor: BACKGROUND,
        title: Text(
          '주문 완료',
          style: TextStyle(
            color: BLUE,
          ),
        ),
      ),
      body: Column(
        children: [
          TopBanner(),
          SizedBox(
            height: 40,
          ),
          OrderDetail(),
        ],
      ),
    );
  }
}
