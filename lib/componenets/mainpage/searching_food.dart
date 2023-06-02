import 'package:flutter/material.dart';

class SearchingFood extends StatelessWidget {
  const SearchingFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20)),
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
                  icon: Icon(Icons.search),
                  onPressed: () => {},
                )
              ],
            ),
          ),
        ));
  }
}
