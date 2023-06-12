import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/main.dart';
import 'package:dnd_order_app/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  String userAddress = '';
  String userPostCode = '';
  String userDetailAddress = '';
  String userPhoneNumber = '';
  String userName = '';

  @override
  Widget build(BuildContext context) {
    KpostalView kakaoPostal() {
      return KpostalView(
        useLocalServer: true,
        localPort: 1024,
        callback: (Kpostal result) {
          setState(() {
            userAddress = result.address;
            userPostCode = result.postCode;
          });
        },
      );
    }

    void userDetailAddressHandler(String value) {
      setState(() {
        userDetailAddress = value;
      });
    }

    void userPhoneNumberHandler(String value) {
      setState(() {
        userPhoneNumber = value;
      });
    }

    void userNameHandler(String value) {
      setState(() {
        userName = value;
      });
    }

    Future<void> onSubmitHandler() async {
      final CreateUserController createUserController = Get.find();
      createUserController.setUserAddress(userAddress);
      createUserController.setUserDetailAddress(userDetailAddress);
      createUserController.setUserPostCode(userPostCode);
      createUserController.setUserName(userName);
      createUserController.setUserPhoneNumber(userPhoneNumber);
      final result = await createUserController.createNewUser();
      print(result);
      if (result) {
        var storage = new FlutterSecureStorage();
        await storage.write(
            key: 'DnD', value: createUserController.userEmail.value);
        Get.to(
          () => MainApp(),
        );
      } else {
        // 다이얼로그 표시
        print("생성에 실패 했습니다.");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("회원가입에 실패했습니다. 다시 시도해 주세요."),
          ),
        );
      }
    }

    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () => {
            FocusScope.of(context).requestFocus(
              new FocusNode(),
            )
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(40, 100, 40, 40),
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
                              Text(userPostCode),
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
                              Text(userAddress),
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
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '상세 주소를 입력해 주세요.',
                      ),
                      onChanged: (value) => userDetailAddressHandler(value),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '이름',
                      ),
                      onChanged: (value) => userNameHandler(value),
                    ),
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '전화번호(010-1234-5678)',
                      ),
                      onChanged: (value) => userPhoneNumberHandler(value),
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
                        await onSubmitHandler();
                      },
                      child: Text('완료'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
