import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:dnd_order_app/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool changeState = false;

  @override
  Widget build(BuildContext context) {
    void cartIsEmpty() {
      setState(() {
        changeState = !changeState;
      });
    }

    final MyCartController myCartController = Get.find();

    bool orderIsDone() {
      if (myCartController.payStatus.value) {
        return true;
      }
      return false;
    }

    return Scaffold(
      backgroundColor: BACKGROUND,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BACKGROUND,
        iconTheme: IconThemeData(
          color: BLUE,
        ),
        title: Text(
          '장바구니',
          style: TextStyle(
            color: BLUE,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
                child: Text(
                  '주문 목록',
                  style: TextStyle(
                    fontSize: 20,
                    color: BLUE,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 380,
              height: 400,
              child: Obx(
                () => ListView(
                  scrollDirection: Axis.vertical,
                  children: myCartController.cart.isEmpty != true
                      ? myCartController.cart
                          .where((element) => element.amount > 0)
                          .toList()
                          .map((item) => GestureDetector(
                                child: Neumorphic(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  style: NeumorphicStyle(
                                    lightSource: LightSource.top,
                                    shape: NeumorphicShape.flat,
                                    depth: 10,
                                    color: BACKGROUND,
                                  ),
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: Image.asset(
                                              'assets/images/item.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${item.name}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                '${item.price} * ${item.amount} = ${item.price * item.amount}원',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          !orderIsDone()
                                              ? Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: IconButton(
                                                    icon: Icon(Icons.add,
                                                        color: Colors.blue,
                                                        size: 16),
                                                    onPressed: () => {
                                                      myCartController
                                                          .addItem(item),
                                                      print(item.amount)
                                                    },
                                                  ),
                                                )
                                              : Text(
                                                  '',
                                                ),
                                          !orderIsDone()
                                              ? Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color: Colors.red,
                                                      size: 16,
                                                    ),
                                                    onPressed: () => {
                                                      myCartController
                                                          .removeItem(item),
                                                      if (myCartController
                                                          .cart.isEmpty)
                                                        {
                                                          cartIsEmpty(),
                                                        }
                                                    },
                                                  ),
                                                )
                                              : Text(
                                                  '',
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList()
                      : [
                          SizedBox(
                            height: 100,
                          ),
                          Center(
                            child: NeumorphicText(
                              '장바구니가 비었습니다.',
                              style: NeumorphicStyle(
                                color: BLUE_GREEN,
                                depth: 20,
                              ),
                              textStyle: NeumorphicTextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() => Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                    child: Text(
                      '총 가격: ${myCartController.total}',
                      style:
                          TextStyle(color: BLUE, fontWeight: FontWeight.w600),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: !myCartController.payStatus.value
                ? NeumorphicButton(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      color: BACKGROUND,
                      lightSource: LightSource.top,
                      depth: 10,
                    ),
                    child: Text(
                      '주문하기',
                      style: TextStyle(
                        color: BLUE,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () => {
                      if (myCartController.cart.isEmpty)
                        {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('장바구니가 비었습니다.'),
                              content: Text('메뉴를 추가한 뒤 다시 진행해주세요.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("확인"),
                                )
                              ],
                            ),
                          )
                        }
                      else
                        {Get.to(() => OrderPage())}
                    },
                  )
                : Text(
                    '주문이 진행중입니다.',
                  ),
          )
        ],
      ),
    );
  }
}
