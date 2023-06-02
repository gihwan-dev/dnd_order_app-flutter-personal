import 'package:dnd_order_app/pages/order_page.dart';
import 'package:dnd_order_app/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class FailOrderPage extends StatelessWidget {
  const FailOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('주문 실패'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('주문 실패'),
            TextButton(
              child: Text("결제 페이지로 돌아가기"),
              onPressed: () => {
                Get.until((route) => Get.currentRoute != '/fail_order_page'),
                Get.until((route) => Get.currentRoute != '/payment_page'),
                Get.to(
                  () => OrderPage(),
                ),
              },
            )
          ],
        ),
      ),
    ));
  }
}
