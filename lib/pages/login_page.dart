import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

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

    void buttonTappedHandler() {
      setState(() {
        if (level == 1) {
          if (isValidEmail(enteredEmail)) {
            buttonColor = Colors.green;
            this.label = "비밀번호를 입력해 주세요.";
            level++;
          } else {
            buttonColor = Colors.red;
          }
        } else if (level == 2) {
          if (isValidPassword(enteredPassword)) {
            buttonColor = Colors.green;
            createUserController.setUserPassword(enteredPassword);
            createUserController.setUserEmail(enteredEmail);
            Get.to(() => SignUpPage());
            level++;
          } else {
            buttonColor = Colors.red;
          }
        }
      });
    }

    void onChangeHandler(String value) {
      setState(() {
        if (level == 1) {
          enteredEmail = value;
          if (isValidEmail(enteredEmail)) {
            buttonColor = Colors.blue;
            label = "올바른 이메일이 입력되었습니다.";
          } else {
            buttonColor = Colors.grey;
            label = "올바른 이메일을 입력해주세요.";
          }
        } else {
          enteredPassword = value;
          if (isValidPassword(enteredPassword)) {
            buttonColor = Colors.blue;
            label = "올바른 패스워드가 입력되었습니다.";
          } else {
            buttonColor = Colors.grey;
            label = "올바른 패스워드를 입력해주세요.";
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
