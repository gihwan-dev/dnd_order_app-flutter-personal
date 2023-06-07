import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
            onPressed: () => {},
            child: Text(
              '내 주문 정보',
            ),
          ),
          TextButton(
            onPressed: () => {},
            child: Text('앱 설정'),
          ),
          TextButton(
            onPressed: () => {},
            child: Text('로그아웃'),
          )
        ],
      ),
    );
  }
}
