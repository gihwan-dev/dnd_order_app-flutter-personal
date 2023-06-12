import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/pages/complete_order_page.dart';
import 'package:dnd_order_app/pages/fail_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final MyCartController myCartController = Get.find();
  final UserInfoController userInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: new AppBar(
        title: new Text('결제'),
      ),
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '잠시만 기다려주세요...',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      userCode: 'imp85511288',
      data: PaymentData(
          pg: 'kcp',
          payMethod: 'card',
          name: 'DnD 음식 주문',
          merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
          amount: myCartController.total.value,
          buyerName: userInfoController.userName.value,
          buyerTel: userInfoController.userPhoneNumber.value,
          buyerEmail: userInfoController.userEmail.value,
          buyerAddr: userInfoController.userAddress.value,
          buyerPostcode: userInfoController.userPostCode.value,
          appScheme: 'MyApp',
          cardQuota: [2, 3]),
      callback: (Map<String, String> result) {
        if (result['imp_success'] == 'true') {
          // 주문 완료 하는 로직 들어가야함.
          Get.to(() => CompleteOrderPage());
        } else {
          // 주문 실패 로직 들어가야함.
          Get.to(
            () => FailOrderPage(),
            routeName: '/fail_order_page',
          );
        }
      },
    );
  }
}
