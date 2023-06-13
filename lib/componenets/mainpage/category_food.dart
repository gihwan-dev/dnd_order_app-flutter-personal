import 'package:dnd_order_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CategoryFood extends StatelessWidget {
  CategoryFood(
      {super.key, required this.onCategoryTapped, required this.index});
  final Function onCategoryTapped;
  final List<String> FOOD_CATEGORY = [
    'hamburger',
    'pizza',
    'dessert',
    'chicken',
    'china',
    'korea'
  ];
  final index;

  final List<String> FOOD_KR = ['햄버거', '피자', '디저트', '치킨', '중국집', '한식'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '카테고리',
                style: TextStyle(
                    color: BLUE, fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Neumorphic(
            style: NeumorphicStyle(
              color: BACKGROUND,
              shape: NeumorphicShape.flat,
              lightSource: LightSource.top,
              depth: 10,
            ),
            child: Container(
              width: 380,
              height: 150,
              child: ListView(
                controller: ScrollController(
                  initialScrollOffset:
                      index != null ? (index.toDouble() * 120 - 80) : 0,
                ),
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
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            lightSource: LightSource.top,
                            depth: 10,
                            shape: NeumorphicShape.flat,
                            color: this.index == FOOD_CATEGORY.indexOf(item)
                                ? YELLOW
                                : BLUE,
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Expanded(
                                    child: ClipRRect(
                                      child: Image.asset(
                                        'assets/images/${item}.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${FOOD_KR[FOOD_CATEGORY.indexOf(item)]}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
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
