import 'package:dnd_order_app/componenets/check_order_page/ordered_info.dart';
import 'package:dnd_order_app/componenets/check_order_page/ordered_menu.dart';
import 'package:dnd_order_app/componenets/order_page/order_info.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:dnd_order_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class CheckOrderPage extends StatelessWidget {
  const CheckOrderPage({super.key});

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
          '주문 정보 확인',
          style: TextStyle(
            color: BLUE,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '주문 메뉴',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              OrderedMenu(),
            ],
          ),
          Column(
            children: [
              Text(
                '주문 정보',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              OrderedInfo(),
            ],
          ),
          NeumorphicButton(
            style: NeumorphicStyle(
              color: BACKGROUND,
            ),
            child: Text(
              '메인 화면으로 돌아가기',
              style: TextStyle(color: BLUE, fontWeight: FontWeight.w500),
            ),
            onPressed: () => Get.to(MainApp()),
          ),
          Row(),
        ],
      ),
    );
  }
}
