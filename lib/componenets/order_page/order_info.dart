import 'dart:ui';

import 'package:dnd_order_app/class/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class OrderInfo extends StatefulWidget {
  OrderInfo({super.key});
  String howToPay = '카드';

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  @override
  Widget build(BuildContext context) {
    final UserInfoController userInfoController = Get.find();
    final MyCartController myCartController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(
                '주문자명: ${userInfoController.userName}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '주소: ${userInfoController.userAddress}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "전화번호: ${userInfoController.userPhoneNumber}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('요청사항'),
              TextField(
                onChanged: (value) {
                  myCartController.request.value = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '요청사항을 입력해주세요.',
                ),
              )
            ],
          ),
          Row(
            children: [Text('금액: ${myCartController.total} 원')],
          ),
          Row(
            children: [
              Text('결제수단: '),
              DropdownButton(
                value: widget.howToPay,
                items: [
                  DropdownMenuItem(
                    child: Text('카드'),
                    value: '카드',
                  ),
                  DropdownMenuItem(
                    child: Text('현금'),
                    value: '현금',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    widget.howToPay = value.toString();
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
