import 'package:dnd_order_app/componenets/my_page/my_page_menu.dart';
import 'package:dnd_order_app/componenets/my_page/profile.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BACKGROUND,
        title: Text(
          '내 정보',
          style: TextStyle(
            color: BLUE,
          ),
        ),
      ),
      body: Column(
        children: [
          Profile(),
          MyPageMenu(),
        ],
      ),
    );
  }
}
