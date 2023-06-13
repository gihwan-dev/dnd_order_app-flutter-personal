import 'package:dnd_order_app/const/const.dart';
import 'package:dnd_order_app/pages/select_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../class/class.dart';

class CategoryList extends StatefulWidget {
  CategoryList({
    super.key,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    final AllStoreController allStoreController = Get.find();
    final allStoreList = allStoreController.storeList;

    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        ...allStoreList.map(
          (item) => GestureDetector(
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SelectMenuPage(
                  curStore: item,
                );
              }))
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: LIGHT_BLUE,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/${item.name}.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: item.rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 16,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) => {print(rating)},
                            ),
                            Text(item.rating.toString()),
                            Text('(' + item.review_count.toString() + ')')
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
