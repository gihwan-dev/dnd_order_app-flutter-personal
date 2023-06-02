import 'package:flutter/material.dart';

class CategoryFood extends StatelessWidget {
  CategoryFood(
      {super.key, required this.onCategoryTapped, required this.index});
  final Function onCategoryTapped;
  final List<String> FOOD_CATEGORY = [
    'hamberger',
    'pizza',
    'jokbal',
    'chicken',
    'china',
    'korea'
  ];
  final index;

  final List<String> FOOD_KR = ['햄버거', '피자', '족발', '치킨', '중국집', '한식'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('카테고리'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 380,
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...FOOD_CATEGORY.map(
                  (item) => GestureDetector(
                    onTap: () => {
                      this.onCategoryTapped(
                          FOOD_KR[FOOD_CATEGORY.indexOf(item)]),
                    },
                    child: Padding(
                      key: Key(item),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: this.index == FOOD_CATEGORY.indexOf(item)
                              ? Colors.grey[200]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 160,
                        width: 130,
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image.asset(
                                  'assets/images/${item}.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${FOOD_KR[FOOD_CATEGORY.indexOf(item)]}')
                                  ]),
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
        ],
      ),
    );
  }
}
