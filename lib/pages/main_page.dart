import 'package:dnd_order_app/componenets/mainpage/address_check.dart';
import 'package:dnd_order_app/componenets/mainpage/category_food.dart';
import 'package:dnd_order_app/componenets/mainpage/recommend_store.dart';
import 'package:dnd_order_app/componenets/mainpage/searching_food.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({
    super.key,
    required this.onCategoryTapped,
  });
  final Function onCategoryTapped;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AddressCheck(),
          SearchingFood(),
          CategoryFood(
            onCategoryTapped: this.onCategoryTapped,
            index: null,
          ),
          RecommendStore(),
        ],
      ),
    );
  }
}
