import 'package:dio/dio.dart';
import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/main.dart';
import 'package:dnd_order_app/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> iconList = ["google", "facebook", "apple", "kakao"];
  String? label;
  String enteredEmail = "";
  String enteredPassword = "";
  Color buttonColor = Colors.grey;

  final CreateUserController createUserController = Get.put(
    CreateUserController(),
  );

  final TextEditingController textEditingController =
      new TextEditingController();

  int level = 1;

  bool isExistingEmail = false;

  final dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.0.2:8000",
      receiveTimeout: Duration(seconds: 20),
      connectTimeout: Duration(seconds: 20),
      sendTimeout: Duration(seconds: 20),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.label = "이메일을 입력해 주세요.";
  }

  Widget build(BuildContext context) {
    bool isValidEmail(String value) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern);
      return (!regex.hasMatch(value)) ? false : true;
    }

    bool isValidPassword(String value) {
      return value.length >= 7;
    }

    void buttonTappedHandler() async {
      try {
        if (level == 1 && isValidEmail(enteredEmail)) {
          final response = await dio.post(
            '/user/signup/email',
            data: {
              'userEmail': enteredEmail,
            },
          );

          setState(() {
            if (response.data['isValid'] == true) {
              buttonColor = Colors.green;
              label = "비밀번호를 입력해 주세요.";
              level++;
            } else {
              buttonColor = Colors.yellow;
              label = "이미 존재하는 이메일 입니다. 로그인을 위해 비밀번호를 입력해 주세요.";
              level++;
              isExistingEmail = true;
            }
          });
        } else if (level == 1 && !isValidEmail(enteredEmail)) {
          setState(
            () {
              buttonColor = Colors.red;
              label = "올바른 이메일 형식을 입력해주세요.";
            },
          );
        }

        if (level == 2 && isValidPassword(enteredPassword)) {
          if (isExistingEmail) {
            // 비밀번호와 이메일을 전달해 로그인을 시도한다.
            final response = await dio.post('/user/signin', data: {
              "userEmail": enteredEmail,
              "userPassword": enteredPassword,
            });
            // 비밀번호가 일치하는지 아닌지에 검사
            if (response.data['isValid'] == true) {
              // 비밀번호가 일치할경우
              // 로컬 저장소에 키-발루 값을 할당하고
              var storage = new FlutterSecureStorage();
              setState(() {
                label = "로그인 중입니다...";
              });
              await storage.write(key: 'DnD', value: enteredEmail);
              // 메인화면으로 이동시킨다.
              Get.to(() => MainApp());
            } else {
              // 그렇지 않을 경우
              // 빨간색으로 표현해 일치하지 않음을 알린다.
              setState(() {
                buttonColor = Colors.red;
                label = "비밀번호가 일치하지 않습니다. 다시 입력해주세요.";
              });
            }
          } else {
            // 비밀번호를 입력하고 회원가입 페이지로 넘어간다.
            setState(() {
              buttonColor = Colors.green;
            });
            createUserController.setUserPassword(enteredPassword);
            createUserController.setUserEmail(enteredEmail);
            Get.to(() => SignUpPage());
          }
        } else if (level == 2 && !isValidPassword(enteredPassword)) {
          setState(() {
            buttonColor = Colors.red;
            label = "올바른 패스워드를 입력해주세요.";
          });
        }
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("에러가 발생했습니다."),
            content: Text('다시시도해 주세요'),
          ),
        );
      }
    }

    void onChangeHandler(String value) {
      setState(() {
        if (level == 1) {
          enteredEmail = value;
          if (isValidEmail(enteredEmail)) {
            buttonColor = Colors.blue;
            label = "올바른 이메일 형식이 입력되었습니다.";
          } else {
            buttonColor = Colors.grey;
            label = "올바른 이메일 형식을 입력해주세요.";
          }
        } else {
          enteredPassword = value;
          if (isValidPassword(enteredPassword)) {
            buttonColor = Colors.blue;
            label = "올바른 패스워드 형식이 입력되었습니다.";
          } else {
            buttonColor = Colors.grey;
            label = "패스워드는 7자리 이상이여야 합니다.";
          }
        }
      });
    }

    return GestureDetector(
      onTap: () => {
        FocusScope.of(context).requestFocus(
          new FocusNode(),
        ),
      },
      child: MaterialApp(
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
                  'Sign up',
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
                Text('배달앱 시작을 위해 회원가입을 진행해주세요.'),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: 300,
                  child: TextField(
                    controller: textEditingController,
                    onChanged: (value) => {
                      onChangeHandler(value),
                    },
                    decoration: InputDecoration(
                      labelText: label,
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
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => buttonColor,
                      ),
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(100, 0, 100, 0),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: () => {
                      buttonTappedHandler(),
                      textEditingController.clear(),
                    },
                    child: Text('Continue'),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text('아래 이메일 계정으로 간편하게 시작하기'),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...iconList.map(
                      (icon) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/login/${icon}.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
