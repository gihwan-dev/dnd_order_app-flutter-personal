import 'package:dnd_order_app/class/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final MyCartController myCartController = Get.find();
    return Column(
      children: [
        Text('주문 상세 정보'),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        ...myCartController.cart.map((item) => (ListTile(
                              title: Text(item.name),
                              subtitle: Text(item.price.toString()),
                              trailing: Text(item.amount.toString()),
                            )))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
