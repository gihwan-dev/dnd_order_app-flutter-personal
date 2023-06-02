import 'package:dnd_order_app/class/class.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  ItemList(
      {super.key, required this.orderButtonClicked, required this.DUMMY_ITEM});

  final Function orderButtonClicked;

  final List<Item> DUMMY_ITEM;

  bool isChange = false;

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  void changeHandler() {
    setState(() {
      widget.isChange = !widget.isChange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Container(
            height: 350,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: ListView(
              children: [
                ...widget.DUMMY_ITEM.map(
                  (item) => GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    child: Image.asset(
                                      'assets/images/item.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item.name}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text('${item.description}'),
                                      Text('${item.price} 원'),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text('${item.amount}'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () => {
                                      changeHandler(),
                                      item.amount += 1,
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => {
                                      changeHandler(),
                                      if (item.amount > 0) item.amount -= 1
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      size: 16,
                                    ),
                                  )
                                ],
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
        TextButton(
          onPressed: () => {widget.orderButtonClicked(widget.DUMMY_ITEM)},
          child: Text('주문하기'),
        ),
      ],
    );
  }
}
