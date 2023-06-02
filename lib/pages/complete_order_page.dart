import 'package:dnd_order_app/componenets/complete_order_page/top_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CompleteOrderPage extends StatelessWidget {
  const CompleteOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('주문 완료'),
        ),
        body: Column(
          children: [
            TopBanner(),
          ],
        ),
      ),
    );
  }
}
