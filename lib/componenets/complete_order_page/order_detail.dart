import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:dnd_order_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderInfoController orderInfoController = Get.find();
    return Column(
      children: [
        Text(
          '주문 메뉴',
          style: TextStyle(
            color: BLUE,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        Neumorphic(
          style: NeumorphicStyle(
            color: BACKGROUND,
            depth: 10,
          ),
          margin: EdgeInsets.all(16),
          child: Container(
            width: 340,
            height: 300,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                ...orderInfoController.cart.map(
                  (item) => (item.amount > 0
                      ? ListTile(
                          title: Text(
                            item.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            '${item.price.toString()}원',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Text(
                            '수량: ${item.amount.toString()}',
                            style: TextStyle(
                              color: BLUE,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : SizedBox()),
                ),
              ],
            ),
          ),
        ),
        NeumorphicButton(
            style: NeumorphicStyle(
              color: BACKGROUND,
            ),
            child: Text(
              '메인화면으로 이동',
              style: TextStyle(
                color: BLUE,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => {
                  Get.to(MainApp()),
                })
      ],
    );
  }
}
