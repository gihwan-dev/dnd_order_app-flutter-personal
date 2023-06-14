import 'package:dnd_order_app/pages/check_order_page.dart';
import 'package:dnd_order_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class MyPageMenu extends StatelessWidget {
  const MyPageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(),
          TextButton(
            onPressed: () => {
              Get.to(
                CheckOrderPage(),
              )
            },
            child: Text(
              '내 주문 정보',
            ),
          ),
          TextButton(
            onPressed: () => {},
            child: Text('앱 설정'),
          ),
          TextButton(
            onPressed: () async {
              await Get.deleteAll();
              await FlutterSecureStorage().delete(key: 'DnD');
              Get.to(() => LoginPage());
            },
            child: Text('로그아웃'),
          )
        ],
      ),
    );
  }
}
