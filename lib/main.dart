import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/pages/cart_page.dart';
import 'package:dnd_order_app/pages/category_page.dart';
import 'package:dnd_order_app/pages/login_page.dart';
import 'package:dnd_order_app/pages/main_page.dart';
import 'package:dnd_order_app/pages/map_page.dart';
import 'package:dnd_order_app/pages/my_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

List<Store> DUMMY_STORE = [
  new Store('store1', 4.2, 324),
  new Store('store2', 4.6, 284),
  new Store('store3', 5.0, 988),
  new Store('store4', 4.4, 1023),
];

void main() {
  runApp(
    GetMaterialApp(
      home: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  MainApp({
    super.key,
  });
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;
  late Widget content;

  Future<String?> isUserSaved() async {
    var storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'DnD');
    return value;
  }

  void onCategoryTapped(String menu) {
    setState(() {
      content = CategoryPage(
        onCategoryTapped: onCategoryTapped,
        menu: menu,
      );
    });
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      switch (index) {
        case 0:
          content = MainPage(
            onCategoryTapped: onCategoryTapped,
          );
          break;
        case 1:
          content = CartPage();
          break;
        case 2:
          content = MapPage();
          break;
        case 3:
          content = MyPage();
          break;
        default:
      }
    });
  }

  @override
  void initState() {
    super.initState();
    content = MainPage(
      onCategoryTapped: onCategoryTapped,
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('에러가 발생했습니다. 다시 시작해주세요.'),
            ),
          ),
        );
      } else if (snapshot.data == null) {
        return LoginPage();
      } else {
        final AllStoreController allStoreController = Get.put(
          AllStoreController(),
        );
        allStoreController.setAllStore(DUMMY_STORE);

        final MyCartController myCartController = Get.put(
          MyCartController(),
        );

        final UserInfoController userInfoController = Get.put(
          UserInfoController(),
        );

        // 유저 정보 fetch 이후 컨트롤러에 할당
        userInfoController.setName('최기환');
        userInfoController.setPhoneNumber('010-6606-9806');
        userInfoController.setUserAddress('부산광역시 사상구 가야대로 384');
        userInfoController.setUserDetailAddress('308호');
        userInfoController.setUserEmail('rlghks3004@gmail.com');
        return MaterialApp(
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '홈',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: '장바구니',
                    backgroundColor: Colors.grey),
                BottomNavigationBarItem(
                    icon: Icon(Icons.map),
                    label: '지도',
                    backgroundColor: Colors.grey),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: '마이페이지',
                    backgroundColor: Colors.grey),
              ],
              currentIndex: currentIndex,
              selectedItemColor: Colors.amber,
              onTap: onTabTapped,
            ),
            body: content,
          ),
        );
        ;
      }
    });
  }
}
