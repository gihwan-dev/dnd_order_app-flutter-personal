import 'package:dnd_order_app/class/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserInfoController userInfoController = Get.find();
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 2.0,
                    ),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${userInfoController.userName.value}'),
                  SizedBox(height: 10),
                  Text('${userInfoController.userEmail.value}'),
                ],
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              child: Text('내 정보 변경'),
              onPressed: () => {},
            ),
          ),
        )
      ],
    );
  }
}
