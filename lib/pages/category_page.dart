import 'package:dnd_order_app/componenets/category_page/category_filter.dart';
import 'package:dnd_order_app/componenets/category_page/category_list.dart';
import 'package:dnd_order_app/componenets/mainpage/category_food.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({
    super.key,
    required this.menu,
    required this.onCategoryTapped,
  });
  final String menu;
  final Function onCategoryTapped;

  final List<String> FOOD_KR = ['햄버거', '피자', '족발', '치킨', '중국집', '한식'];

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          CategoryFood(
              onCategoryTapped: widget.onCategoryTapped,
              index: widget.FOOD_KR.indexOf(widget.menu)),
          CategoryFilter(),
          Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  width: 400,
                  height: 350,
                  child: CategoryList(),
                ),
              ))
        ],
      ),
    ));
  }
}
