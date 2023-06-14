import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class OrderedInfo extends StatelessWidget {
  OrderedInfo({super.key});

  final OrderInfoController orderInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    // fetch로 주문 현황 받아와야함.
    return Neumorphic(
      style: NeumorphicStyle(
        color: BACKGROUND,
      ),
      child: Container(
        width: 300,
        height: 200,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            // 받아온 주문 현황 여기에 표시.
            SizedBox(
              height: 10,
            ),
            Text(
              '주문자 명: ${orderInfoController.userName.value}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '총 가격: ${orderInfoController.total}원',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '결제 일시: ${orderInfoController.payDate}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
