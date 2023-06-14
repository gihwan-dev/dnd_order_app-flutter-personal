import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/componenets/check_order_page/ordered_info.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

class OrderedMenu extends StatelessWidget {
  OrderedMenu({super.key});
  final OrderInfoController orderInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        color: BACKGROUND,
      ),
      child: Container(
        width: 300,
        height: 200,
        child: ListView(
          scrollDirection: Axis.vertical,

          // 받아온 주문 현황 여기에 표시.
          children: [
            ...orderInfoController.cart.map(
              (item) => (item.amount > 0
                  ? ListTile(
                      title: Text(
                        item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        '${item.price.toString()}원',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Text(
                        '수량: ${item.amount.toString()}',
                        style: TextStyle(
                          color: BLUE,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : SizedBox()),
            ),
          ],
        ),
      ),
    );
  }
}
