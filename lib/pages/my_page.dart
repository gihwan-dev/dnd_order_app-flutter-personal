import 'package:dnd_order_app/componenets/my_page/profile.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('내 정보'),
        ),
        body: Column(
          children: [
            Profile(),
          ],
        ));
  }
}
