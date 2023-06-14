import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserInfoController userInfoController = Get.find();
    return Stack(
      children: [
        Neumorphic(
          style: NeumorphicStyle(
            color: BACKGROUND,
            depth: 10,
          ),
          child: Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      lightSource: LightSource.top,
                      depth: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/profile.avif',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userInfoController.userName.value}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${userInfoController.userEmail.value}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => {},
                child: NeumorphicText(
                  '내 정보 변경',
                  style: NeumorphicStyle(
                    color: Colors.blue,
                    shape: NeumorphicShape.flat,
                    depth: 20,
                    lightSource: LightSource.top,
                  ),
                ),
              )
              // child: TextButton(
              //   child: Text('내 정보 변경'),
              //   onPressed: () => {},
              // ),
              ),
        )
      ],
    );
  }
}
