import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/pages/order_page.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text('장바구니'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
                child: Text(
                  '주문 목록',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
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
                                            Text('${item.name}'),
                                            Text(
                                                '${item.price} * ${item.amount} = ${item.price * item.amount}원'),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: IconButton(
                                            icon: Icon(Icons.add, size: 16),
                                            onPressed: () => {
                                              myCartController.addItem(item),
                                              print(item.amount)
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              size: 16,
                                            ),
                                            onPressed: () => {
                                              myCartController.removeItem(item),
                                              if (myCartController.cart.isEmpty)
                                                {
                                                  cartIsEmpty(),
                                                }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList()
                      : [
                          Center(
                            child: Text(
                              '장바구니가 비었습니다.',
                              style: TextStyle(fontSize: 24),
                            ),
                          )
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
                    child: Text('총 가격: ${myCartController.total}'),
                  ))
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
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
              child: Text('주문하기'),
            ),
          )
        ],
      ),
    );
  }
}
