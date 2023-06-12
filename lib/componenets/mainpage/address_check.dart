import 'package:dnd_order_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AddressCheck extends StatefulWidget {
  const AddressCheck({super.key});

  @override
  State<AddressCheck> createState() => _AddressCheckState();
}

class _AddressCheckState extends State<AddressCheck> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [],
          ),
          Text(
            '이 주소가 맞으신가요?',
            style: TextStyle(
              fontSize: 20,
              color: BLUE,
            ),
          ),
          SizedBox(height: 10),
          Neumorphic(
            style: NeumorphicStyle(
              lightSource: LightSource.top,
              depth: 10,
              shape: NeumorphicShape.flat,
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '부산광역시 사상구 가야대로...',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
