import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: AssetImage(
                'assets/images/profile.avif',
              ),
              fit: BoxFit.cover,
            ),
          ),
          width: 80,
          height: 80,
        )
      ],
    );
  }
}
