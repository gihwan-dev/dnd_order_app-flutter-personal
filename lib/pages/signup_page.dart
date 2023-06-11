import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/main.dart';
import 'package:dnd_order_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:kpostal/kpostal.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final CreateUserController createUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    String address = '';
    String postCode = '';

    KpostalView kakaoPostal() {
      return KpostalView(
        useLocalServer: true,
        localPort: 1024,
        callback: (Kpostal result) {
          setState(() {
            postCode = result.postCode;
            address = result.address;
          });
        },
      );
    }

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(),
              Text(
                'Create',
                style: TextStyle(
                  fontSize: 57,
                ),
              ),
              Text(
                'Account',
                style: TextStyle(
                  fontSize: 57,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('계속해서 회원가입을 진행해 주세요.'),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '우편번호: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text('${postCode}'),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Text(
                            '주소: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text('${address}'),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    child: Text('변경'),
                    onPressed: () async {
                      await Get.to(() => kakaoPostal());
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '이름',
                  ),
                ),
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '전화번호(010-1234-5678)',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.fromLTRB(100, 0, 100, 0),
                    ),
                  ),
                  onPressed: () async {
                    await Get.to(
                      () => MainApp(),
                    );
                  },
                  child: Text('완료'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
