import 'package:dnd_order_app/componenets/order_page/order_info.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:dnd_order_app/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  void navigateToPaymanePage() {
    Get.to(() => PaymentPage());
  }

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        FocusScope.of(context).requestFocus(
          new FocusNode(),
        ),
      },
      child: Scaffold(
        backgroundColor: BACKGROUND,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: BLUE,
          ),
          backgroundColor: BACKGROUND,
          elevation: 0,
          title: Text(
            '주문하기',
            style: TextStyle(
              color: BLUE,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: OrderInfo(),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                child: ElevatedButton(
                  onPressed: () => {
                    Get.to(() => PaymentPage(), routeName: '/payment_page'),
                  },
                  child: Text('주문하기'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
