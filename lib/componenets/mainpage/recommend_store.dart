import 'package:dnd_order_app/pages/select_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../class/class.dart';

class RecommendStore extends StatelessWidget {
  RecommendStore({
    super.key,
  });

  final PageController pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    final AllStoreController allStoreController = Get.find();
    final storeList = allStoreController.storeList;

    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [Text('추천 음식점')],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)),
              width: 380,
              height: 200,
              child: PageView(
                controller: pageController,
                children: [
                  ...storeList.map(
                    (item) => GestureDetector(
                      onTap: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SelectMenuPage(
                            curStore: item,
                          );
                        }))
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                    'assets/images/${item.name}.jpg',
                                    fit: BoxFit.fill),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
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
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 1.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) =>
                                                {print(rating)},
                                          ),
                                          Text(item.rating.toString()),
                                          SizedBox(width: 3),
                                          Text('(' +
                                              item.review_count.toString() +
                                              ')'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
