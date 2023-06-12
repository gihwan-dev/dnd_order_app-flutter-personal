import 'package:dnd_order_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SearchingFood extends StatelessWidget {
  const SearchingFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          lightSource: LightSource.top,
          depth: 10,
        ),
        child: Container(
          decoration: BoxDecoration(),
          width: 380,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: '음식또는 음식점을 검색해주세요.'),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: BLUE,
                  ),
                  onPressed: () => {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
