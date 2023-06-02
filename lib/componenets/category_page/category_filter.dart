import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  CategoryFilter({super.key});

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String filter_target = '기본 순';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownButton(
            items: [
              DropdownMenuItem(child: Text('리뷰 많은 순'), value: '리뷰 많은 순'),
              DropdownMenuItem(child: Text('별점 높은 순'), value: '별점 높은 순'),
              DropdownMenuItem(child: Text('기본 순'), value: '기본 순'),
            ],
            onChanged: (value) => {
              setState(() {
                if (value != null) {
                  filter_target = value.toString();
                }
              })
            },
            value: filter_target,
          )
        ],
      ),
    );
  }
}
