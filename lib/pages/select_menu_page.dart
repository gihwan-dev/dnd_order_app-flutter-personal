import 'package:dnd_order_app/componenets/select_menu_page/banner_image.dart';
import 'package:dnd_order_app/componenets/select_menu_page/banner_text.dart';
import 'package:dnd_order_app/componenets/select_menu_page/item_list.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:dnd_order_app/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../class/class.dart';

class SelectMenuPage extends StatefulWidget {
  SelectMenuPage({
    super.key,
    required this.curStore,
  });

  final Store curStore;

  @override
  State<SelectMenuPage> createState() => _SelectMenuPageState();
}

class _SelectMenuPageState extends State<SelectMenuPage> {
  @override
  Widget build(BuildContext context) {
    void orderButtonClicked(List<Item> itemList) {
      final MyCartController myCartController = Get.find();
      myCartController.setCart(itemList);
      Get.to(() => CartPage());
    }

    return GestureDetector(
      onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
      child: Scaffold(
        backgroundColor: BACKGROUND,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: BLUE,
          ),
          backgroundColor: BACKGROUND,
          title: Text(
            '메뉴 선택',
            style: TextStyle(
              color: BLUE,
            ),
          ),
        ),
        body: Column(
          children: [
            BannerImage(curStore: widget.curStore),
            BannerText(curStore: widget.curStore),
            ItemList(
              orderButtonClicked: orderButtonClicked,
              DUMMY_ITEM: widget.curStore.menu,
            ),
          ],
        ),
      ),
    );
  }
}
